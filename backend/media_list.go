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

//go:embed graphql/media_list.graphql
var mediaListQuery string

//go:embed graphql/save_media_list_entry.graphql
var saveMediaListEntryMutation string

//go:embed graphql/delete_list_entry.graphql
var deleteMediaListEntryMutation string

// FetchMediaList returns authenticated user's media (ANIME or MANGA) list
//
//export FetchMediaList
func FetchMediaList(userId C.int, token *C.char, mediaType *C.char, outLen *C.int) *C.uint8_t {
	uID := int32(userId)
	tk := C.GoString(token)
	mT := C.GoString(mediaType)

	pbResponse := &pb.FetchMediaListResponse{}

	variables := map[string]any{
		"userId": uID,
		"type":   mT,
		"sort":   []string{"SCORE_DESC"},
	}

	data, err := executeGraphQL[models.MediaListDTO](tk, mediaListQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Collection = data.MediaListCollection.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// SaveMediaListEntry updates anime list entry on AniList
//
//export SaveMediaListEntry
func SaveMediaListEntry(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.SaveMediaListEntryResponse{}

	var req pb.SaveMediaListEntryRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
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
	if req.ProgressVolumes != nil {
		variables["progressVolumes"] = *req.ProgressVolumes
	}
	if req.Repeat != nil {
		variables["repeat"] = *req.Repeat
	}

	data, err := executeGraphQL[models.SaveMediaListEntryDTO](tk, saveMediaListEntryMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Entry = data.SaveMediaListEntry.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// DeleteMediaListEntry deletes a list entry on AniList
//
//export DeleteMediaListEntry
func DeleteMediaListEntry(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.DeleteMediaListEntryResponse{}

	var req pb.DeleteMediaListEntryRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"mediaListEntryId": req.GetEntryId()}

	data, err := executeGraphQL[models.DeleteMediaListEntryDTO](tk, deleteMediaListEntryMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.EntryId = req.GetEntryId()
	pbResponse.Deleted = data.DeleteMediaListEntry.Deleted
	return marshalAndReturn(pbResponse, outLen)
}
