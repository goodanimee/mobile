package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	"goodanime-backend/models"
	pb "goodanime-backend/proto"
)

// ResolveAnilistPreviews resolves multiple AniList entity previews in bulk GraphQL requests.
//
//export ResolveAnilistPreviews
func ResolveAnilistPreviews(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ResolveAnilistPreviewsResponse{}

	var req pb.ResolveAnilistPreviewsRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	batches := models.BuildPreviewBatches(&req)
	for _, batch := range batches {
		pages, err := executeGraphQL[map[string]models.PreviewAliasPageDTO](tk, batch.Query, batch.Variables)
		if err != nil {
			pbResponse.Error = err.Error()
			return marshalAndReturn(pbResponse, outLen)
		}
		if pages != nil {
			models.MergePreviewBatchData(batch.Aliases, *pages, pbResponse)
		}
	}

	return marshalAndReturn(pbResponse, outLen)
}
