package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	_ "embed"
	pb "goodanime-backend/proto"
)

//go:embed graphql/viewer.graphql
var viewerQuery string

// FetchViewer fetches the authenticated user's profile from AniList,
// marshals it into a FetchViewerResponse protobuf, and returns it as a
// C-allocated byte buffer. The caller must free the buffer with FreeBuffer.
//
// Parameters:
//   - token:  Bearer token for the authenticated request.
//   - outLen: Written with the byte length of the returned buffer.
//
//export FetchViewer
func FetchViewer(token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchViewerResponse{}

	aniResp, err := graphqlRequest(tk, viewerQuery, nil)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	v := aniResp.Data.Viewer
	pbResponse.Viewer = &pb.Viewer{
		Id:           v.ID,
		Name:         v.Name,
		CreatedAt:    v.CreatedAt,
		AvatarMedium: v.Avatar.Medium,
	}
	return marshalAndReturn(pbResponse, outLen)
}
