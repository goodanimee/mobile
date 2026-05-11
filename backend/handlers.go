package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	"encoding/json"
	"fmt"
	"unsafe"

	pb "goodanime-backend/proto"

	"google.golang.org/protobuf/proto"
)

// FetchMediaList fetches the authenticated user's anime media list from AniList,
// marshals it into a FetchMediaListResponse protobuf, and returns it as a
// C-allocated byte buffer. The caller must free the buffer with FreeBuffer.
//
// Parameters:
//   - userId: AniList user ID to fetch lists for.
//   - token:  Bearer token for the authenticated request.
//   - outLen: Written with the byte length of the returned buffer.
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
				StartedAt:   fuzzyDate(entry.StartedAt.Year, entry.StartedAt.Month, entry.StartedAt.Day),
				CompletedAt: fuzzyDate(entry.CompletedAt.Year, entry.CompletedAt.Month, entry.CompletedAt.Day),
				Media: &pb.Media{
					Id:           entry.Media.ID,
					AverageScore: entry.Media.AverageScore,
					BannerImage:  entry.Media.BannerImage,
					Description:  entry.Media.Description,
					Duration:     entry.Media.Duration,
					Episodes:     entry.Media.Episodes,
					Format:       entry.Media.Format,
					Genres:       entry.Media.Genres,
					IsAdult:      entry.Media.IsAdult,
					IsFavourite:  entry.Media.IsFavourite,
					Popularity:   entry.Media.Popularity,
					Season:       entry.Media.Season,
					SeasonYear:   entry.Media.SeasonYear,
					Status:       entry.Media.Status,
					Synonyms:    entry.Media.Synonyms,
					MeanScore:   entry.Media.MeanScore,
					Favourites:  entry.Media.Favourites,
					SiteUrl:     entry.Media.SiteUrl,
					StartDate:   fuzzyDate(entry.Media.StartDate.Year, entry.Media.StartDate.Month, entry.Media.StartDate.Day),
					EndDate:     fuzzyDate(entry.Media.EndDate.Year, entry.Media.EndDate.Month, entry.Media.EndDate.Day),
					Title: &pb.Title{
						English:       entry.Media.Title.English,
						Native:        entry.Media.Title.Native,
						Romaji:        entry.Media.Title.Romaji,
						UserPreferred: entry.Media.Title.UserPreferred,
					},
					CoverImage: &pb.CoverImage{
						Medium:     entry.Media.CoverImage.Medium,
						Large:      entry.Media.CoverImage.Large,
						ExtraLarge: entry.Media.CoverImage.ExtraLarge,
						Color:      entry.Media.CoverImage.Color,
					},
					Trailer: &pb.Trailer{
						Id:        entry.Media.Trailer.ID,
						Site:      entry.Media.Trailer.Site,
						Thumbnail: entry.Media.Trailer.Thumbnail,
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

// FetchViewer fetches the authenticated user's profile from AniList,
// marshals it into a FetchViewerResponse protobuf, and returns it as a
// C-allocated byte buffer. The caller must free the buffer with FreeBuffer.
//
// Parameters:
//   - token:  Bearer token for the authenticated request.
//   - outLen: Written with the byte length of the returned buffer.
//
//export FetchViewer
func FetchViewer(token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchViewerResponse{}

	aniResp, err := graphqlRequest(tk, viewerQuery, nil)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	v := aniResp.Data.Viewer
	pbResponse.Viewer = &pb.Viewer{
		Id:           v.ID,
		Name:         v.Name,
		CreatedAt:    v.CreatedAt,
		AvatarMedium: v.Avatar.Medium,
	}
	return marshalAndReturn(pbResponse, outLen)
}

// SaveMediaListEntry saves or updates an anime list entry on AniList.
// The request payload is a protobuf-encoded SaveMediaListEntryRequest.
// Returns a C-allocated byte buffer containing a SaveMediaListEntryResponse.
// The caller must free the buffer with FreeBuffer.
//
// Parameters:
//   - reqPtr: Pointer to the serialised SaveMediaListEntryRequest bytes.
//   - reqLen: Length of the request byte buffer.
//   - token:  Bearer token for the authenticated request.
//   - outLen: Written with the byte length of the returned buffer.
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

	// We can optionally check for anilist errors here, but for now we'll just pass the JSON string.
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

