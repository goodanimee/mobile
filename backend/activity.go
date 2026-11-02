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

//go:embed graphql/activity_by_id.graphql
var activityByIdQuery string

//go:embed graphql/activity_replies.graphql
var activityRepliesQuery string

//go:embed graphql/save_activity_reply.graphql
var saveActivityReplyMutation string

//go:embed graphql/toggle_activity_reply_like.graphql
var toggleActivityReplyLikeMutation string

// GetActivityById fetches a single activity by ID.
//
//export GetActivityById
func GetActivityById(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.GetActivityByIdResponse{}

	var req pb.GetActivityByIdRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if req.ActivityId <= 0 {
		pbResponse.Error = "Must provide activityId"
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"activityId": req.ActivityId,
	}

	data, err := executeGraphQL[models.ActivityDTO](tk, activityByIdQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if data.Activity != nil {
		pbResponse.Activity = data.Activity.ToProto()
	} else {
		pbResponse.Error = "Activity not found"
	}
	return marshalAndReturn(pbResponse, outLen)
}

// GetActivityReplies fetches paginated replies for an activity.
//
//export GetActivityReplies
func GetActivityReplies(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.GetActivityRepliesResponse{}

	var req pb.GetActivityRepliesRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if req.ActivityId <= 0 {
		pbResponse.Error = "Must provide activityId"
		return marshalAndReturn(pbResponse, outLen)
	}

	page := req.Page
	if page <= 0 {
		page = 1
	}
	perPage := req.PerPage
	if perPage <= 0 {
		perPage = 25
	}

	variables := map[string]any{
		"activityId": req.ActivityId,
		"page":       page,
		"perPage":    perPage,
	}

	data, err := executeGraphQL[models.ActivityRepliesPageDTO](tk, activityRepliesQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.PageInfo = data.Page.PageInfo.ToProto()
	pbResponse.Total = data.Page.PageInfo.Total
	replies := make([]*pb.ActivityReply, 0, len(data.Page.ActivityReplies))
	for i := range data.Page.ActivityReplies {
		if protoItem := data.Page.ActivityReplies[i].ToProto(); protoItem != nil {
			replies = append(replies, protoItem)
		}
	}
	pbResponse.Replies = replies
	return marshalAndReturn(pbResponse, outLen)
}

// SaveActivityReply creates or updates an activity reply.
//
//export SaveActivityReply
func SaveActivityReply(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.SaveActivityReplyResponse{}

	var req pb.SaveActivityReplyRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if req.ActivityId <= 0 {
		pbResponse.Error = "Must provide activityId"
		return marshalAndReturn(pbResponse, outLen)
	}
	if req.Text == "" {
		pbResponse.Error = "Must provide text"
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"activityId": req.ActivityId,
		"text":       req.Text,
	}
	if req.GetReplyId() > 0 {
		variables["replyId"] = req.GetReplyId()
	}

	data, err := executeGraphQL[models.SaveActivityReplyDTO](tk, saveActivityReplyMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if data.SaveActivityReply != nil {
		pbResponse.Reply = data.SaveActivityReply.ToProto()
	} else {
		pbResponse.Error = "Failed to save reply"
	}
	return marshalAndReturn(pbResponse, outLen)
}

// ToggleActivityReplyLike toggles the like status of an activity reply.
//
//export ToggleActivityReplyLike
func ToggleActivityReplyLike(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleActivityReplyLikeResponse{}

	var req pb.ToggleActivityReplyLikeRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if req.ReplyId <= 0 {
		pbResponse.Error = "Must provide replyId"
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"replyId": req.ReplyId,
	}

	data, err := executeGraphQL[models.ToggleActivityReplyLikeDTO](tk, toggleActivityReplyLikeMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.ReplyId = req.ReplyId
	likedUserIds := make([]int32, 0, len(data.ToggleLike))
	for _, user := range data.ToggleLike {
		likedUserIds = append(likedUserIds, user.ID)
	}
	pbResponse.LikedUserIds = likedUserIds
	return marshalAndReturn(pbResponse, outLen)
}
