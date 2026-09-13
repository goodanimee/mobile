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

//go:embed graphql/toggle_favourite_anime.graphql
var toggleFavouriteAnimeMutation string

//go:embed graphql/toggle_favourite_manga.graphql
var toggleFavouriteMangaMutation string

//go:embed graphql/toggle_activity_like.graphql
var toggleActivityLikeMutation string

//go:embed graphql/rate_review.graphql
var rateReviewMutation string

// FetchMediaDetails returns full details for a media ID
//
//export FetchMediaDetails
func FetchMediaDetails(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaDetailsResponse{}

	var req pb.FetchMediaDetailsRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId":     req.MediaId,
		"notYetAired": true,
	}

	data, err := executeGraphQL[models.MediaDTO](tk, mediaDetailsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaStaff returns paginated staff for a media ID
//
//export FetchMediaStaff
func FetchMediaStaff(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaStaffResponse{}

	var req pb.FetchMediaStaffRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	data, err := executeGraphQL[models.MediaDTO](tk, mediaStaffQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaCharacters returns paginated characters for a media ID
//
//export FetchMediaCharacters
func FetchMediaCharacters(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaCharactersResponse{}

	var req pb.FetchMediaCharactersRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	data, err := executeGraphQL[models.MediaDTO](tk, mediaCharactersQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaRecommendations returns paginated recommendations for a media ID
//
//export FetchMediaRecommendations
func FetchMediaRecommendations(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaRecommendationsResponse{}

	var req pb.FetchMediaRecommendationsRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	data, err := executeGraphQL[models.MediaDTO](tk, mediaRecommendationsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaReviews returns paginated reviews for a media ID
//
//export FetchMediaReviews
func FetchMediaReviews(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaReviewsResponse{}

	var req pb.FetchMediaReviewsRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	data, err := executeGraphQL[models.MediaDTO](tk, mediaReviewsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Media = data.Media.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// ToggleFavouriteAnime toggles favourite status of an anime on AniList
//
//export ToggleFavouriteAnime
func ToggleFavouriteAnime(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleFavouriteAnimeResponse{}

	var req pb.ToggleFavouriteAnimeRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"animeId": req.AnimeId}

	data, err := executeGraphQL[models.ToggleFavouriteDTO](tk, toggleFavouriteAnimeMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	s := data.ToggleFavourite
	pbResponse.AnimeId = req.AnimeId
	if len(s.Anime.Nodes) == 0 {
		pbResponse.IsFavourite = false
	} else {
		pbResponse.IsFavourite = s.Anime.Nodes[0].IsFavourite
	}

	return marshalAndReturn(pbResponse, outLen)
}

// ToggleFavouriteManga toggles the favourite status of a manga on AniList.
//
//export ToggleFavouriteManga
func ToggleFavouriteManga(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleFavouriteMangaResponse{}

	var req pb.ToggleFavouriteMangaRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"mangaId": req.MangaId}

	data, err := executeGraphQL[models.ToggleFavouriteMangaDTO](tk, toggleFavouriteMangaMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	s := data.ToggleFavourite
	pbResponse.MangaId = req.MangaId
	if len(s.Manga.Nodes) == 0 {
		pbResponse.IsFavourite = false
	} else {
		pbResponse.IsFavourite = s.Manga.Nodes[0].IsFavourite
	}

	return marshalAndReturn(pbResponse, outLen)
}

// ToggleActivityLike toggles the like status of an activity on AniList
//
//export ToggleActivityLike
func ToggleActivityLike(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleActivityLikeResponse{}

	var req pb.ToggleActivityLikeRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"activityId": req.ActivityId}

	data, err := executeGraphQL[models.ToggleActivityLikeDTO](tk, toggleActivityLikeMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.ActivityId = req.ActivityId
	for _, user := range data.ToggleActivityLike {
		pbResponse.LikedUserIds = append(pbResponse.LikedUserIds, user.ID)
	}
	return marshalAndReturn(pbResponse, outLen)
}

// RateReview rates a review on AniList.
//
//export RateReview
func RateReview(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.RateReviewResponse{}

	var req pb.RateReviewRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
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

	data, err := executeGraphQL[models.RateReviewDTO](tk, rateReviewMutation, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Review = data.RateReview.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// FetchMediaActivities returns paginated recent activities for a media ID.
//
//export FetchMediaActivities
func FetchMediaActivities(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchMediaActivitiesResponse{}

	var req pb.FetchMediaActivitiesRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"mediaId": req.MediaId,
		"page":    req.Page,
		"perPage": req.PerPage,
	}

	data, err := executeGraphQL[models.PageDTO](tk, mediaActivitiesQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.PageInfo = data.Page.PageInfo.ToProto()
	for _, act := range data.Page.Activities {
		pbResponse.Activities = append(pbResponse.Activities, act.ToProto())
	}
	return marshalAndReturn(pbResponse, outLen)
}
