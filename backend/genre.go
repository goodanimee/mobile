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

	data, err := executeGraphQL[models.GenreCollectionDTO](tk, genresQuery, nil)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Genres = data.GenreCollection
	return marshalAndReturn(pbResponse, outLen)
}

// FetchTags returns all possible media tags from AniList
//
//export FetchTags
func FetchTags(token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchTagsResponse{}

	data, err := executeGraphQL[models.MediaTagCollectionDTO](tk, tagsQuery, nil)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	for _, tag := range data.MediaTagCollection {
		pbResponse.Tags = append(pbResponse.Tags, tag.ToProto())
	}
	return marshalAndReturn(pbResponse, outLen)
}
