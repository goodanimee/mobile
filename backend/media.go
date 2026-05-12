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
	"unsafe"

	pb "goodanime-backend/proto"

	"google.golang.org/protobuf/proto"
)

//go:embed graphql/media_details.graphql
var mediaDetailsQuery string

//go:embed graphql/media_staff.graphql
var mediaStaffQuery string

//go:embed graphql/media_characters.graphql
var mediaCharactersQuery string

//go:embed graphql/media_recommendations.graphql
var mediaRecommendationsQuery string

// FetchMediaDetails returns full details for a media ID
//export FetchMediaDetails
func FetchMediaDetails(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaDetailsResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchMediaDetailsRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]interface{}{
		"mediaId":     req.MediaId,
		"notYetAired": true,
	}

	respBody, err := rawGraphqlRequest(tk, mediaDetailsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var errCheck struct {
		Errors []struct {
			Message string `json:"message"`
		} `json:"errors"`
		Data struct {
			Media json.RawMessage `json:"Media"`
		} `json:"data"`
	}
	if err := json.Unmarshal(respBody, &errCheck); err == nil && len(errCheck.Errors) > 0 {
		pbResponse.Error = errCheck.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.RawJson = string(errCheck.Data.Media)
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaStaff returns paginated staff for a media ID
//export FetchMediaStaff
func FetchMediaStaff(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaStaffResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchMediaStaffRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]interface{}{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	respBody, err := rawGraphqlRequest(tk, mediaStaffQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var errCheck struct {
		Errors []struct {
			Message string `json:"message"`
		} `json:"errors"`
		Data struct {
			Media json.RawMessage `json:"Media"`
		} `json:"data"`
	}
	if err := json.Unmarshal(respBody, &errCheck); err == nil && len(errCheck.Errors) > 0 {
		pbResponse.Error = errCheck.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.RawJson = string(errCheck.Data.Media)
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaCharacters returns paginated characters for a media ID
//export FetchMediaCharacters
func FetchMediaCharacters(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaCharactersResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchMediaCharactersRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]interface{}{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	respBody, err := rawGraphqlRequest(tk, mediaCharactersQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var errCheck struct {
		Errors []struct {
			Message string `json:"message"`
		} `json:"errors"`
		Data struct {
			Media json.RawMessage `json:"Media"`
		} `json:"data"`
	}
	if err := json.Unmarshal(respBody, &errCheck); err == nil && len(errCheck.Errors) > 0 {
		pbResponse.Error = errCheck.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.RawJson = string(errCheck.Data.Media)
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaRecommendations returns paginated recommendations for a media ID
//export FetchMediaRecommendations
func FetchMediaRecommendations(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaRecommendationsResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchMediaRecommendationsRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]interface{}{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	respBody, err := rawGraphqlRequest(tk, mediaRecommendationsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var errCheck struct {
		Errors []struct {
			Message string `json:"message"`
		} `json:"errors"`
		Data struct {
			Media json.RawMessage `json:"Media"`
		} `json:"data"`
	}
	if err := json.Unmarshal(respBody, &errCheck); err == nil && len(errCheck.Errors) > 0 {
		pbResponse.Error = errCheck.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.RawJson = string(errCheck.Data.Media)
	return marshalAndReturn(pbResponse, outLen)
}
