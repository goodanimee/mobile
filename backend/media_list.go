package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	_ "embed"
	"fmt"
	"unsafe"

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

	aniResp, err := graphqlRequest(tk, mediaListQuery, map[string]interface{}{
		"userId": uID,
		"type":   "ANIME",
		"sort":   []string{"SCORE_DESC"},
	})
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	col := &pb.MediaListCollection{
		HasNextChunk: aniResp.Data.MediaListCollection.HasNextChunk,
	}

	for _, list := range aniResp.Data.MediaListCollection.Lists {
		pbList := &pb.MediaList{
			Name:   list.Name,
			Status: list.Status,
		}

		for _, entry := range list.Entries {
			pbEntry := &pb.MediaListEntry{
				Progress:    entry.Progress,
				Repeat:      entry.Repeat,
				Status:      entry.Status,
				Score:       entry.Score,
				Id:          entry.Id,
				StartedAt:   fuzzyDate(entry.StartedAt.Year, entry.StartedAt.Month, entry.StartedAt.Day),
				CompletedAt: fuzzyDate(entry.CompletedAt.Year, entry.CompletedAt.Month, entry.CompletedAt.Day),
				Media: &pb.Media{
					Id:           entry.Media.ID,
					AverageScore: entry.Media.AverageScore,
					Episodes:     entry.Media.Episodes,
					Format:       entry.Media.Format,
					IsAdult:      entry.Media.IsAdult,
					IsFavourite:  entry.Media.IsFavourite,
					Title: &pb.Title{
						UserPreferred: entry.Media.Title.UserPreferred,
					},
					CoverImage: &pb.CoverImage{
						Large: entry.Media.CoverImage.Large,
						Color: entry.Media.CoverImage.Color,
					},
				},
			}
			pbList.Entries = append(pbList.Entries, pbEntry)
		}
		col.Lists = append(col.Lists, pbList)
	}

	pbResponse.Collection = col
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

	variables := map[string]interface{}{"mediaId": req.MediaId}
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
		variables["startedAt"] = fuzzyDateInput(req.StartedAt)
	}
	if req.CompletedAt != nil {
		variables["completedAt"] = fuzzyDateInput(req.CompletedAt)
	}

	aniResp, err := graphqlRequest(tk, saveMediaListEntryMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	s := aniResp.Data.SaveMediaListEntry
	pbResponse.Id = s.ID
	pbResponse.Status = s.Status
	pbResponse.Progress = s.Progress
	pbResponse.Score = s.Score
	pbResponse.Repeat = s.Repeat
	pbResponse.StartedAt = fuzzyDate(s.StartedAt.Year, s.StartedAt.Month, s.StartedAt.Day)
	pbResponse.CompletedAt = fuzzyDate(s.CompletedAt.Year, s.CompletedAt.Month, s.CompletedAt.Day)

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

	aniResp, err := graphqlRequest(tk, deleteMediaListEntryMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	if len(aniResp.Errors) > 0 {
		pbResponse.Error = aniResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.EntryId = req.GetEntryId()
	pbResponse.Deleted = aniResp.Data.DeleteMediaListEntry.Deleted
	return marshalAndReturn(pbResponse, outLen)
}
