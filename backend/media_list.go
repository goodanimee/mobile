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

//go:embed graphql/update_anime_custom_lists.graphql
var updateAnimeCustomListsMutation string

//go:embed graphql/update_manga_custom_lists.graphql
var updateMangaCustomListsMutation string

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
	if req.Private != nil {
		variables["private"] = *req.Private
	}
	if req.HiddenFromStatusLists != nil {
		variables["hiddenFromStatusLists"] = *req.HiddenFromStatusLists
	}
	if req.Notes != nil {
		variables["notes"] = *req.Notes
	}
	if req.CustomLists != nil {
		lists := req.CustomLists.CustomLists
		if lists == nil {
			lists = []string{}
		}
		variables["customLists"] = lists
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

// UpdateCustomLists updates custom lists on AniList
//
//export UpdateCustomLists
func UpdateCustomLists(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.UpdateCustomListsResponse{}

	var req pb.UpdateCustomListsRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"customLists": req.CustomLists,
	}

	mutation := updateAnimeCustomListsMutation
	if req.MediaType == "MANGA" {
		mutation = updateMangaCustomListsMutation
	}

	data, err := executeGraphQL[models.UpdateUserDTO](tk, mutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if data.UpdateUser.MediaListOptions != nil {
		if data.UpdateUser.MediaListOptions.AnimeList != nil {
			pbResponse.AnimeCustomLists = data.UpdateUser.MediaListOptions.AnimeList.CustomLists
		}
		if data.UpdateUser.MediaListOptions.MangaList != nil {
			pbResponse.MangaCustomLists = data.UpdateUser.MediaListOptions.MangaList.CustomLists
		}
	}

	return marshalAndReturn(pbResponse, outLen)
}
