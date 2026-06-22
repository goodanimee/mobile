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

//go:embed graphql/media_search.graphql
var mediaSearchQuery string

func toFuzzyDateInt(y int32) int32 {
	if y > 0 && y <= 9999 {
		return y * 10000
	}
	return y
}

type mediaSearchDTO struct {
	Page struct {
		PageInfo models.PageInfo    `json:"pageInfo"`
		Media    []*models.MediaMin `json:"media"`
	} `json:"Page"`
}

// FetchMediaSearch searches for media on AniList.
//
//export FetchMediaSearch
func FetchMediaSearch(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaSearchResponse{}
	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchMediaSearchRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
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
	if req.MinAverageScore != nil && req.MaxAverageScore != nil {
		if *req.MinAverageScore < *req.MaxAverageScore {
			variables["minAverageScore"] = (*req.MinAverageScore)*10 - 1
			variables["maxAverageScore"] = (*req.MaxAverageScore)*10 + 1
		} else {
			variables["averageScore"] = (*req.MinAverageScore) * 10
		}
	} else if req.MinAverageScore != nil {
		variables["minAverageScore"] = (*req.MinAverageScore)*10 - 1
	} else if req.MaxAverageScore != nil {
		variables["maxAverageScore"] = (*req.MaxAverageScore)*10 + 1
	} else if req.AverageScore != nil {
		variables["averageScore"] = (*req.AverageScore) * 10
	}
	if req.Season != nil {
		variables["season"] = *req.Season
	}
	if req.MinStartDate != nil && req.MaxStartDate != nil {
		if *req.MinStartDate < *req.MaxStartDate {
			variables["minStartDate"] = toFuzzyDateInt(*req.MinStartDate) - 1
			variables["maxStartDate"] = toFuzzyDateInt(*req.MaxStartDate) + 1
		} else {
			variables["startDate"] = toFuzzyDateInt(*req.MinStartDate)
		}
	} else if req.MinStartDate != nil {
		variables["minStartDate"] = toFuzzyDateInt(*req.MinStartDate) - 1
	} else if req.MaxStartDate != nil {
		variables["maxStartDate"] = toFuzzyDateInt(*req.MaxStartDate) + 1
	} else if req.StartDate != nil {
		variables["startDate"] = toFuzzyDateInt(*req.StartDate)
	}
	if req.MinEpisodes != nil && req.MaxEpisodes != nil {
		if *req.MinEpisodes < *req.MaxEpisodes {
			variables["minEpisodes"] = *req.MinEpisodes - 1
			variables["maxEpisodes"] = *req.MaxEpisodes + 1
		} else {
			variables["episodes"] = *req.MinEpisodes
		}
	} else if req.MinEpisodes != nil {
		variables["minEpisodes"] = *req.MinEpisodes - 1
	} else if req.MaxEpisodes != nil {
		variables["maxEpisodes"] = *req.MaxEpisodes + 1
	} else if req.Episodes != nil {
		variables["episodes"] = *req.Episodes
	}
	if req.MinDuration != nil && req.MaxDuration != nil {
		if *req.MinDuration < *req.MaxDuration {
			variables["minDuration"] = *req.MinDuration - 1
			variables["maxDuration"] = *req.MaxDuration + 1
		} else {
			variables["duration"] = *req.MinDuration
		}
	} else if req.MinDuration != nil {
		variables["minDuration"] = *req.MinDuration - 1
	} else if req.MaxDuration != nil {
		variables["maxDuration"] = *req.MaxDuration + 1
	} else if req.Duration != nil {
		variables["duration"] = *req.Duration
	}
	if req.MinChapters != nil && req.MaxChapters != nil {
		if *req.MinChapters < *req.MaxChapters {
			variables["minChapters"] = *req.MinChapters - 1
			variables["maxChapters"] = *req.MaxChapters + 1
		} else {
			variables["chapters"] = *req.MinChapters
		}
	} else if req.MinChapters != nil {
		variables["minChapters"] = *req.MinChapters - 1
	} else if req.MaxChapters != nil {
		variables["maxChapters"] = *req.MaxChapters + 1
	} else if req.Chapters != nil {
		variables["chapters"] = *req.Chapters
	}
	if req.MinVolumes != nil && req.MaxVolumes != nil {
		if *req.MinVolumes < *req.MaxVolumes {
			variables["minVolumes"] = *req.MinVolumes - 1
			variables["maxVolumes"] = *req.MaxVolumes + 1
		} else {
			variables["volumes"] = *req.MinVolumes
		}
	} else if req.MinVolumes != nil {
		variables["minVolumes"] = *req.MinVolumes - 1
	} else if req.MaxVolumes != nil {
		variables["maxVolumes"] = *req.MaxVolumes + 1
	} else if req.Volumes != nil {
		variables["volumes"] = *req.Volumes
	}
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
	respBody, err := rawGraphqlRequest(tk, mediaSearchQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}
	var apiResp models.GraphQLResponse[mediaSearchDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}
	var pbMedia []*pb.MediaMin
	for _, m := range apiResp.Data.Page.Media {
		if m != nil {
			pbMedia = append(pbMedia, m.ToProto())
		}
	}
	pbResponse.Media = pbMedia
	pbResponse.PageInfo = apiResp.Data.Page.PageInfo.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}
