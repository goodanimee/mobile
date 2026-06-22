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

	"goodanime-backend/models"
	pb "goodanime-backend/proto"
)

//go:embed graphql/genres.graphql
var genresQuery string

//go:embed graphql/tags.graphql
var tagsQuery string

// FetchGenres returns all possible media genres from AniList
//
//export FetchGenres
func FetchGenres(token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchGenresResponse{}

	respBody, err := rawGraphqlRequest(tk, genresQuery, nil)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.GenreCollectionDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Genres = apiResp.Data.GenreCollection
	return marshalAndReturn(pbResponse, outLen)
}

// FetchTags returns all possible media tags from AniList
//
//export FetchTags
func FetchTags(token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchTagsResponse{}

	respBody, err := rawGraphqlRequest(tk, tagsQuery, nil)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.MediaTagCollectionDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	for _, tag := range apiResp.Data.MediaTagCollection {
		pbResponse.Tags = append(pbResponse.Tags, tag.ToProto())
	}
	return marshalAndReturn(pbResponse, outLen)
}
