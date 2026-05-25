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

//go:embed graphql/media_details.graphql
var mediaDetailsQuery string

//go:embed graphql/media_staff.graphql
var mediaStaffQuery string

//go:embed graphql/media_characters.graphql
var mediaCharactersQuery string

//go:embed graphql/media_recommendations.graphql
var mediaRecommendationsQuery string

//go:embed graphql/media_reviews.graphql
var mediaReviewsQuery string

//go:embed graphql/media_activities.graphql
var mediaActivitiesQuery string

//go:embed graphql/toggle_favourite.graphql
var mediaToggleFavouriteMutation string

//go:embed graphql/rate_review.graphql
var rateReviewMutation string

// FetchMediaDetails returns full details for a media ID
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

	variables := map[string]any{
		"mediaId":     req.MediaId,
		"notYetAired": true,
	}

	respBody, err := rawGraphqlRequest(tk, mediaDetailsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.MediaDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = apiResp.Data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaStaff returns paginated staff for a media ID
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

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	respBody, err := rawGraphqlRequest(tk, mediaStaffQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.MediaDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = apiResp.Data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaCharacters returns paginated characters for a media ID
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

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	respBody, err := rawGraphqlRequest(tk, mediaCharactersQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.MediaDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = apiResp.Data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaRecommendations returns paginated recommendations for a media ID
//
//export FetchMediaRecommendations
func FetchMediaRecommendations(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaRecommendationsResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchMediaRecommendationsRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	respBody, err := rawGraphqlRequest(tk, mediaRecommendationsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.MediaDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = apiResp.Data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaReviews returns paginated reviews for a media ID
//
//export FetchMediaReviews
func FetchMediaReviews(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaReviewsResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchMediaReviewsRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	respBody, err := rawGraphqlRequest(tk, mediaReviewsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.MediaDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = apiResp.Data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// ToggleFavouriteAnime toggles favourite status of an anime on AniList
//
//export ToggleFavouriteAnime
func ToggleFavouriteAnime(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleFavouriteAnimeResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.ToggleFavouriteAnimeRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"animeId": req.AnimeId}

	respBody, err := rawGraphqlRequest(tk, mediaToggleFavouriteMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.ToggleFavouriteDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	s := apiResp.Data.ToggleFavourite

	if len(s.Anime.Nodes) == 0 {
		pbResponse.Error = "Empty response from AniList"
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.AnimeId = req.AnimeId
	pbResponse.IsFavourite = s.Anime.Nodes[0].IsFavourite
	return marshalAndReturn(pbResponse, outLen)
}

// RateReview rates a review on AniList.
//
//export RateReview
func RateReview(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.RateReviewResponse{}
	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.RateReviewRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	var ratingStr string
	switch req.Rating {
	case pb.ReviewUserRating_REVIEW_USER_RATING_UP_VOTE:
		ratingStr = "UP_VOTE"
	case pb.ReviewUserRating_REVIEW_USER_RATING_DOWN_VOTE:
		ratingStr = "DOWN_VOTE"
	default:
		ratingStr = "NO_VOTE"
	}
	variables := map[string]any{
		"reviewId": req.ReviewId,
		"rating":   ratingStr,
	}
	respBody, err := rawGraphqlRequest(tk, rateReviewMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}
	var apiResp models.GraphQLResponse[models.RateReviewDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}
	pbResponse.Review = apiResp.Data.RateReview.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaActivities returns paginated recent activities for a media ID.
//
//export FetchMediaActivities
func FetchMediaActivities(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaActivitiesResponse{}

	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	var req pb.FetchMediaActivitiesRequest
	if err := proto.Unmarshal(reqBytes, &req); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to decode request: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	respBody, err := rawGraphqlRequest(tk, mediaActivitiesQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	var apiResp models.GraphQLResponse[models.PageDTO]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		pbResponse.Error = fmt.Sprintf("failed to parse response: %v", err)
		return marshalAndReturn(pbResponse, outLen)
	}
	if len(apiResp.Errors) > 0 {
		pbResponse.Error = apiResp.Errors[0].Message
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.PageInfo = apiResp.Data.Page.PageInfo.ToProto()
	for _, act := range apiResp.Data.Page.Activities {
		pbResponse.Activities = append(pbResponse.Activities, act.ToProto())
	}
	return marshalAndReturn(pbResponse, outLen)
}
