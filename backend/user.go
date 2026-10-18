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

//go:embed graphql/user_profile_by_id.graphql
var userProfileByIdQuery string

//go:embed graphql/user_profile_by_name.graphql
var userProfileByNameQuery string

//go:embed graphql/user_follow_counts.graphql
var userFollowCountsQuery string

//go:embed graphql/toggle_follow.graphql
var toggleFollowMutation string

// GetUserProfile fetches a user profile by ID or username
//
//export GetUserProfile
func GetUserProfile(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.GetUserProfileResponse{}

	var req pb.GetUserProfileRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if req.UserId > 0 {
		variables := map[string]any{
			"id": req.UserId,
		}
		data, err := executeGraphQL[models.UserProfileDTO](tk, userProfileByIdQuery, variables)
		if err != nil {
			pbResponse.Error = err.Error()
			return marshalAndReturn(pbResponse, outLen)
		}
		pbResponse.Profile = data.ToProto()
		return marshalAndReturn(pbResponse, outLen)
	}

	if req.Username != "" {
		variables := map[string]any{
			"name": req.Username,
		}
		data, err := executeGraphQL[models.UserProfileDTO](tk, userProfileByNameQuery, variables)
		if err != nil {
			pbResponse.Error = err.Error()
			return marshalAndReturn(pbResponse, outLen)
		}
		profile := data.ToProto()
		if profile != nil && profile.Id > 0 {
			countVars := map[string]any{
				"userId": profile.Id,
			}
			counts, err := executeGraphQL[models.UserFollowCountsDTO](tk, userFollowCountsQuery, countVars)
			if err == nil {
				profile.FollowersCount = counts.Followers.PageInfo.Total
				profile.FollowingCount = counts.Following.PageInfo.Total
			}
		}
		pbResponse.Profile = profile
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Error = "Must provide userId or username"
	return marshalAndReturn(pbResponse, outLen)
}

// ToggleFollow toggles the follow state of a user
//
//export ToggleFollow
func ToggleFollow(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleFollowResponse{}

	var req pb.ToggleFollowRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"userId": req.UserId,
	}

	data, err := executeGraphQL[models.ToggleFollowDTO](tk, toggleFollowMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.UserId = data.ToggleFollow.ID
	pbResponse.IsFollowing = data.ToggleFollow.IsFollowing
	return marshalAndReturn(pbResponse, outLen)
}
