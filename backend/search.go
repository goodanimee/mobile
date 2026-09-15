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

//go:embed graphql/media_search.graphql
var mediaSearchQuery string

type mediaSearchDTO struct {
	Page struct {
		PageInfo models.PageInfo    `json:"pageInfo"`
		Media    []*models.MediaMin `json:"media"`
	} `json:"Page"`
}

func setIntRangeFilter(vars map[string]any, min, max, exact *int32, keyMin, keyMax, keyExact string, multiplier int32) {
	if min != nil && max != nil {
		if *min < *max {
			vars[keyMin] = (*min)*multiplier - 1
			vars[keyMax] = (*max)*multiplier + 1
		} else {
			vars[keyExact] = (*min) * multiplier
		}
	} else if min != nil {
		vars[keyMin] = (*min)*multiplier - 1
	} else if max != nil {
		vars[keyMax] = (*max)*multiplier + 1
	} else if exact != nil {
		vars[keyExact] = (*exact) * multiplier
	}
}

// FetchMediaSearch searches for media on AniList.
//
//export FetchMediaSearch
func FetchMediaSearch(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaSearchResponse{}

	var req pb.FetchMediaSearchRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"page": req.Page,
	}
	if req.Query != nil && *req.Query != "" {
		variables["query"] = *req.Query
	}
	if req.Type != nil {
		variables["type"] = *req.Type
	}
	if req.Format != nil {
		variables["format"] = *req.Format
	}
	if req.FormatNot != nil {
		variables["formatNot"] = *req.FormatNot
	}
	if len(req.FormatIn) > 0 {
		variables["formatIn"] = req.FormatIn
	}
	if len(req.FormatNotIn) > 0 {
		variables["formatNotIn"] = req.FormatNotIn
	}
	if req.Status != nil {
		variables["status"] = *req.Status
	}
	if req.OnList != nil {
		variables["onList"] = *req.OnList
	}

	setIntRangeFilter(variables, req.MinAverageScore, req.MaxAverageScore, req.AverageScore, "minAverageScore", "maxAverageScore", "averageScore", 10)

	if req.Season != nil {
		variables["season"] = *req.Season
	}
	if req.MinStartDate != nil || req.MaxStartDate != nil {
		if req.MinStartDate != nil {
			variables["minStartDate"] = (*req.MinStartDate-1)*10000 + 1231
		}
		if req.MaxStartDate != nil {
			variables["maxStartDate"] = (*req.MaxStartDate+1)*10000 + 101
		}
	} else if req.StartDate != nil {
		variables["minStartDate"] = (*req.StartDate-1)*10000 + 1231
		variables["maxStartDate"] = (*req.StartDate+1)*10000 + 101
	}

	setIntRangeFilter(variables, req.MinEpisodes, req.MaxEpisodes, req.Episodes, "minEpisodes", "maxEpisodes", "episodes", 1)
	setIntRangeFilter(variables, req.MinDuration, req.MaxDuration, req.Duration, "minDuration", "maxDuration", "duration", 1)
	setIntRangeFilter(variables, req.MinChapters, req.MaxChapters, req.Chapters, "minChapters", "maxChapters", "chapters", 1)
	setIntRangeFilter(variables, req.MinVolumes, req.MaxVolumes, req.Volumes, "minVolumes", "maxVolumes", "volumes", 1)

	if req.IsAdult != nil {
		variables["isAdult"] = *req.IsAdult
	}
	if len(req.GenreIn) > 0 {
		variables["genreIn"] = req.GenreIn
	}
	if len(req.GenreNotIn) > 0 {
		variables["genreNotIn"] = req.GenreNotIn
	}
	if len(req.TagIn) > 0 {
		variables["tagIn"] = req.TagIn
	}
	if len(req.TagNotIn) > 0 {
		variables["tagNotIn"] = req.TagNotIn
	}
	if req.MinimumTagRank != nil && (len(req.TagIn) > 0 || len(req.TagNotIn) > 0) {
		variables["minimumTagRank"] = *req.MinimumTagRank
	}
	if len(req.Sort) > 0 {
		variables["sort"] = []string{req.Sort[0]}
	}

	data, err := executeGraphQL[mediaSearchDTO](tk, mediaSearchQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var pbMedia []*pb.MediaMin
	for _, m := range data.Page.Media {
		if m != nil {
			pbMedia = append(pbMedia, m.ToProto())
		}
	}
	pbResponse.Media = pbMedia
	pbResponse.PageInfo = data.Page.PageInfo.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

//go:embed graphql/studio_search.graphql
var studioSearchQuery string

// FetchStudioSearch searches for studios on AniList.
//
//export FetchStudioSearch
func FetchStudioSearch(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchStudioSearchResponse{}

	var req pb.FetchStudioSearchRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"page": req.Page,
	}
	if req.Query != nil && *req.Query != "" {
		variables["query"] = *req.Query
	}
	if len(req.Sort) > 0 {
		variables["sort"] = []string{req.Sort[0]}
	}

	data, err := executeGraphQL[models.StudioSearchDTO](tk, studioSearchQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var pbStudios []*pb.Studio
	for _, s := range data.Page.Studios {
		if s != nil {
			pbStudios = append(pbStudios, s.ToProto())
		}
	}
	pbResponse.Studios = pbStudios
	pbResponse.PageInfo = data.Page.PageInfo.ToProto()

	return marshalAndReturn(pbResponse, outLen)
}

//go:embed graphql/character_search.graphql
var characterSearchQuery string

// FetchCharacterSearch searches for characters on AniList.
//
//export FetchCharacterSearch
func FetchCharacterSearch(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchCharacterSearchResponse{}

	var req pb.FetchCharacterSearchRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"page": req.Page,
	}
	if req.Query != nil && *req.Query != "" {
		variables["query"] = *req.Query
	}
	if req.IsBirthday != nil {
		variables["isBirthday"] = *req.IsBirthday
	}
	if len(req.Sort) > 0 {
		variables["sort"] = []string{req.Sort[0]}
	}

	data, err := executeGraphQL[models.CharacterSearchDTO](tk, characterSearchQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var pbCharacters []*pb.Character
	for _, c := range data.Page.Characters {
		if c != nil {
			pbCharacters = append(pbCharacters, c.ToProto())
		}
	}
	pbResponse.Characters = pbCharacters
	pbResponse.PageInfo = data.Page.PageInfo.ToProto()

	return marshalAndReturn(pbResponse, outLen)
}

//go:embed graphql/staff_search.graphql
var staffSearchQuery string

// FetchStaffSearch searches for staff on AniList.
//
//export FetchStaffSearch
func FetchStaffSearch(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchStaffSearchResponse{}

	var req pb.FetchStaffSearchRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"page": req.Page,
	}
	if req.Query != nil && *req.Query != "" {
		variables["query"] = *req.Query
	}
	if req.IsBirthday != nil {
		variables["isBirthday"] = *req.IsBirthday
	}
	if len(req.Sort) > 0 {
		variables["sort"] = []string{req.Sort[0]}
	}

	data, err := executeGraphQL[models.StaffSearchDTO](tk, staffSearchQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var pbStaff []*pb.Staff
	for _, s := range data.Page.Staff {
		if s != nil {
			pbStaff = append(pbStaff, s.ToProto())
		}
	}
	pbResponse.Staff = pbStaff
	pbResponse.PageInfo = data.Page.PageInfo.ToProto()

	return marshalAndReturn(pbResponse, outLen)
}
