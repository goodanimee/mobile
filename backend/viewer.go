package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	_ "embed"
	"encoding/json"
	"fmt"

	"goodanime-backend/models"
	pb "goodanime-backend/proto"
)

//go:embed graphql/viewer.graphql
var viewerQuery string

// FetchViewer returns authenticated user profile from AniList
//
//export FetchViewer
func FetchViewer(token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchViewerResponse{}

	respBody, err := rawGraphqlRequest(tk, viewerQuery, nil)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.ViewerDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Viewer = apiResp.Data.Viewer.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}
