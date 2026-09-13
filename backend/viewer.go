package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	_ "embed"

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

	data, err := executeGraphQL[models.ViewerDTO](tk, viewerQuery, nil)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Viewer = data.Viewer.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}
