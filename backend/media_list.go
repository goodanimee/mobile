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

	"goodanime-backend/models"
	pb "goodanime-backend/proto"

	"google.golang.org/protobuf/proto"
)

//go:embed graphql/media_list.graphql
var mediaListQuery string

//go:embed graphql/save_media_list_entry.graphql
var saveMediaListEntryMutation string

//go:embed graphql/delete_list_entry.graphql
var deleteMediaListEntryMutation string

// FetchMediaList returns authenticated user's anime list
//
//export FetchMediaList
func FetchMediaList(userId C.int, token *C.char, outLen *C.int) *C.uint8_t {
	uID := int32(userId)
	tk := C.GoString(token)

	pbResponse := &pb.FetchMediaListResponse{}

	respBody, err := rawGraphqlRequest(tk, mediaListQuery, map[string]any{
		"userId": uID,
		"type":   "ANIME",
		"sort":   []string{"SCORE_DESC"},
	})
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.MediaListDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Collection = apiResp.Data.MediaListCollection.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// SaveMediaListEntry updates anime list entry on AniList
//
//export SaveMediaListEntry
func SaveMediaListEntry(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.SaveMediaListEntryResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.SaveMediaListEntryRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"mediaId": req.MediaId}
	if req.Progress != nil {
		variables["progress"] = *req.Progress
	}
	if req.Status != nil {
		variables["status"] = *req.Status
	}
	if req.Score != nil {
		variables["score"] = *req.Score
	}
	if req.StartedAt != nil {
		variables["startedAt"] = req.StartedAt
	}
	if req.CompletedAt != nil {
		variables["completedAt"] = req.CompletedAt
	}

	respBody, err := rawGraphqlRequest(tk, saveMediaListEntryMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.SaveMediaListEntryDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Entry = apiResp.Data.SaveMediaListEntry.ToProto()

	return marshalAndReturn(pbResponse, outLen)
}

// DeleteMediaListEntry deletes a list entry on AniList
//
//export DeleteMediaListEntry
func DeleteMediaListEntry(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.DeleteMediaListEntryResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.DeleteMediaListEntryRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"mediaListEntryId": req.GetEntryId()}

	respBody, err := rawGraphqlRequest(tk, deleteMediaListEntryMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.DeleteMediaListEntryDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.EntryId = req.GetEntryId()
	pbResponse.Deleted = apiResp.Data.DeleteMediaListEntry.Deleted
	return marshalAndReturn(pbResponse, outLen)
}
