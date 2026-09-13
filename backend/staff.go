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

	var req pb.FetchStaffDetailsRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"id":                 req.StaffId,
		"characterMediaPage": req.CharacterMediaPage,
		"staffMediaPage":     req.StaffMediaPage,
	}

	data, err := executeGraphQL[models.StaffDTO](tk, staffDetailsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Staff = data.Staff.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// ToggleFavouriteStaff toggles the favourite status of a staff member.
//
//export ToggleFavouriteStaff
func ToggleFavouriteStaff(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleFavouriteStaffResponse{}

	var req pb.ToggleFavouriteStaffRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"id": req.StaffId}

	if _, err := executeGraphQL[any](tk, toggleFavouriteStaffMutation, variables); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.StaffId = req.StaffId
	return marshalAndReturn(pbResponse, outLen)
}
