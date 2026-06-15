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

//go:embed graphql/staff_details.graphql
var staffDetailsQuery string

//go:embed graphql/toggle_favourite_staff.graphql
var toggleFavouriteStaffMutation string

// FetchStaffDetails fetches details of a staff member by its ID.
//
//export FetchStaffDetails
func FetchStaffDetails(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchStaffDetailsResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchStaffDetailsRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"id":                 req.StaffId,
		"characterMediaPage": req.CharacterMediaPage,
		"staffMediaPage":     req.StaffMediaPage,
	}

	respBody, err := rawGraphqlRequest(tk, staffDetailsQuery, variables)
	if err != nil {
		pbResponse.Error = fmt.Sprintf("GraphQL request failed: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.StaffDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode API response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Staff = apiResp.Data.Staff.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// ToggleFavouriteStaff toggles the favourite status of a staff member.
//
//export ToggleFavouriteStaff
func ToggleFavouriteStaff(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleFavouriteStaffResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.ToggleFavouriteStaffRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"id": req.StaffId}

	respBody, err := rawGraphqlRequest(tk, toggleFavouriteStaffMutation, variables)
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

	pbResponse.StaffId = req.StaffId
	return marshalAndReturn(pbResponse, outLen)
}
