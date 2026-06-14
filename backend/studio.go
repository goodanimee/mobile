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
	"unsafe"

	pb "goodanime-backend/proto"

	"google.golang.org/protobuf/proto"
)

//go:embed graphql/studio_details.graphql
var studioDetailsQuery string

// FetchStudioDetails fetches details of a studio by its ID.
//
//export FetchStudioDetails
func FetchStudioDetails(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchStudioDetailsResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchStudioDetailsRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"studioId": req.StudioId,
		"page":     req.Page,
	}

	respBody, err := rawGraphqlRequest(tk, studioDetailsQuery, variables)
	if err != nil {
		pbResponse.Error = fmt.Sprintf("GraphQL request failed: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.StudioDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode API response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Studio = apiResp.Data.Studio.ToProto()
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

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.ToggleFavouriteStudioRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"studioId": req.StudioId}

	respBody, err := rawGraphqlRequest(tk, toggleFavouriteStudioMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[any]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.StudioId = req.StudioId
	return marshalAndReturn(pbResponse, outLen)
}
