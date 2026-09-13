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

//go:embed graphql/studio_details.graphql
var studioDetailsQuery string

// FetchStudioDetails fetches details of a studio by its ID.
//
//export FetchStudioDetails
func FetchStudioDetails(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchStudioDetailsResponse{}

	var req pb.FetchStudioDetailsRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"studioId": req.StudioId,
		"page":     req.Page,
	}

	data, err := executeGraphQL[models.StudioDTO](tk, studioDetailsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Studio = data.Studio.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

//go:embed graphql/toggle_favourite_studio.graphql
var toggleFavouriteStudioMutation string

// ToggleFavouriteStudio toggles the favourite status of a studio on AniList.
//
//export ToggleFavouriteStudio
func ToggleFavouriteStudio(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleFavouriteStudioResponse{}

	var req pb.ToggleFavouriteStudioRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"studioId": req.StudioId}

	if _, err := executeGraphQL[any](tk, toggleFavouriteStudioMutation, variables); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.StudioId = req.StudioId
	return marshalAndReturn(pbResponse, outLen)
}
