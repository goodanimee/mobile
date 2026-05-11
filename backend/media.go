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

// FetchMediaDetails fetches the full details for a given media ID.
// The request payload is a protobuf-encoded FetchMediaDetailsRequest.
// Returns a C-allocated byte buffer containing a FetchMediaDetailsResponse
// with the raw JSON result.
// The caller must free the buffer with FreeBuffer.
//
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

// FetchMediaStaff fetches a paginated list of staff members for a given media ID.
// The request payload is a protobuf-encoded FetchMediaStaffRequest.
// Returns a C-allocated byte buffer containing a FetchMediaStaffResponse.
//
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

// FetchMediaCharacters fetches a paginated list of characters and their voice actors for a given media ID.
// The request payload is a protobuf-encoded FetchMediaCharactersRequest.
// Returns a C-allocated byte buffer containing a FetchMediaCharactersResponse.
//
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
