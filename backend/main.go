package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"unsafe"

	pb "goodanime-backend/proto"

	"google.golang.org/protobuf/proto"
)

// GraphQLQuery is the JSON body sent to the AniList GraphQL endpoint.
type GraphQLQuery struct {
	Query     string                 `json:"query"`
	Variables map[string]interface{} `json:"variables"`
}

// AniListResponse is the top-level envelope returned by the AniList API.
// Only the fields used by the three exported functions are declared.
type AniListResponse struct {
	Data struct {
		MediaListCollection struct {
			HasNextChunk bool `json:"hasNextChunk"`
			Lists        []struct {
				Name    string `json:"name"`
				Status  string `json:"status"`
				Entries []struct {
					Media struct {
						ID    int32 `json:"id"`
						Title struct {
							English       string `json:"english"`
							Native        string `json:"native"`
							Romaji        string `json:"romaji"`
							UserPreferred string `json:"userPreferred"`
						} `json:"title"`
						AverageScore int32  `json:"averageScore"`
						BannerImage  string `json:"bannerImage"`
						CoverImage   struct {
							Medium     string `json:"medium"`
							Large      string `json:"large"`
							ExtraLarge string `json:"extraLarge"`
							Color      string `json:"color"`
						} `json:"coverImage"`
						Description string   `json:"description"`
						Duration    int32    `json:"duration"`
						Episodes    int32    `json:"episodes"`
						Format      string   `json:"format"`
						Genres      []string `json:"genres"`
						IsAdult     bool     `json:"isAdult"`
						IsFavourite bool     `json:"isFavourite"`
						Popularity  int32    `json:"popularity"`
						Season      string   `json:"season"`
						SeasonYear  int32    `json:"seasonYear"`
						Status      string   `json:"status"`
						Trailer     struct {
							ID        string `json:"id"`
							Site      string `json:"site"`
							Thumbnail string `json:"thumbnail"`
						} `json:"trailer"`
					} `json:"media"`
					Progress  int32   `json:"progress"`
					Repeat    int32   `json:"repeat"`
					Status    string  `json:"status"`
					Score     float64 `json:"score"`
					StartedAt struct {
						Day   *int32 `json:"day"`
						Month *int32 `json:"month"`
						Year  *int32 `json:"year"`
					} `json:"startedAt"`
					CompletedAt struct {
						Day   *int32 `json:"day"`
						Month *int32 `json:"month"`
						Year  *int32 `json:"year"`
					} `json:"completedAt"`
				} `json:"entries"`
			} `json:"lists"`
		} `json:"MediaListCollection"`
		Viewer struct {
			ID        int32  `json:"id"`
			Name      string `json:"name"`
			CreatedAt int32  `json:"createdAt"`
			Avatar    struct {
				Medium string `json:"medium"`
			} `json:"avatar"`
		} `json:"Viewer"`
		SaveMediaListEntry struct {
			ID       int32   `json:"id"`
			Status   string  `json:"status"`
			Progress int32   `json:"progress"`
			Score    float64 `json:"score"`
			Repeat   int32   `json:"repeat"`
			StartedAt struct {
				Day   *int32 `json:"day"`
				Month *int32 `json:"month"`
				Year  *int32 `json:"year"`
			} `json:"startedAt"`
			CompletedAt struct {
				Day   *int32 `json:"day"`
				Month *int32 `json:"month"`
				Year  *int32 `json:"year"`
			} `json:"completedAt"`
		} `json:"SaveMediaListEntry"`
	} `json:"data"`
	Errors []struct {
		Message string `json:"message"`
	} `json:"errors"`
}

const mediaListQuery = `
query MediaList($userId: Int, $type: MediaType, $sort: [MediaListSort]) {
    MediaListCollection(userId: $userId, type: $type, sort: $sort) {
        hasNextChunk
        lists {
            name
            status
            entries {
                media {
                    id
                    title {
                        english
                        native
                        romaji
                        userPreferred
                    }
                    averageScore
                    bannerImage
                    coverImage {
                        medium
                        large
                        extraLarge
                        color
                    }
                    description(asHtml: false)
                    duration
                    episodes
                    format
                    genres
                    isAdult
                    isFavourite
                    popularity
                    season
                    seasonYear
                    status
                    trailer {
                        id
                        site
                        thumbnail
                    }
                }
                progress
                repeat
                status
                score
                startedAt {
                    day
                    month
                    year
                }
                completedAt {
                    day
                    month
                    year
                }
            }
        }
    }
}
`

const viewerQuery = `
query {
    Viewer {
        id
        name
        createdAt
        avatar {
            medium
        }
    }
}
`

const saveMediaListEntryMutation = `
mutation SaveMediaListEntry(
    $mediaId: Int
    $progress: Int
    $status: MediaListStatus
    $startedAt: FuzzyDateInput
    $completedAt: FuzzyDateInput
    $score: Float
) {
    SaveMediaListEntry(
        mediaId: $mediaId
        progress: $progress
        status: $status
        startedAt: $startedAt
        completedAt: $completedAt
        score: $score
    ) {
        id
        status
        progress
        score(format: POINT_10_DECIMAL)
        repeat
        startedAt {
            day
            month
            year
        }
        completedAt {
            day
            month
            year
        }
    }
}
`

// graphqlRequest sends a GraphQL query or mutation to the AniList API.
// If token is non-empty it is attached as a Bearer Authorization header.
// Returns a parsed AniListResponse or an error if the request or AniList itself fails.
func graphqlRequest(token, query string, variables map[string]interface{}) (*AniListResponse, error) {
	q := GraphQLQuery{Query: query, Variables: variables}
	body, err := json.Marshal(q)
	if err != nil {
		return nil, fmt.Errorf("failed to marshal request: %w", err)
	}

	req, err := http.NewRequest("POST", "https://graphql.anilist.co", bytes.NewBuffer(body))
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")
	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}

	resp, err := (&http.Client{}).Do(req)
	if err != nil {
		return nil, fmt.Errorf("request failed: %w", err)
	}
	defer resp.Body.Close()

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response: %w", err)
	}

	var aniResp AniListResponse
	if err := json.Unmarshal(respBody, &aniResp); err != nil {
		return nil, fmt.Errorf("failed to parse response: %w", err)
	}
	if len(aniResp.Errors) > 0 {
		return nil, fmt.Errorf("anilist error: %s", aniResp.Errors[0].Message)
	}
	return &aniResp, nil
}

// fuzzyDate converts the nullable day/month/year pointer fields from the API
// into a pb.FuzzyDate, setting only the components that are present.
func fuzzyDate(year, month, day *int32) *pb.FuzzyDate {
	if year == nil {
		return nil
	}
	d := &pb.FuzzyDate{Year: *year}
	if month != nil {
		d.Month = *month
	}
	if day != nil {
		d.Day = *day
	}
	return d
}

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

// FreeBuffer releases a byte buffer previously allocated by one of the
// exported functions. Must be called after consuming the response bytes
// to avoid memory leaks.
//
//export FreeBuffer
func FreeBuffer(ptr *C.uint8_t) {
	C.free(unsafe.Pointer(ptr))
}

// fuzzyDateInput converts a pb.FuzzyDateInput into the JSON map shape
// expected by the AniList GraphQL FuzzyDateInput scalar.
// Nil pointer fields are represented as JSON null.
func fuzzyDateInput(d *pb.FuzzyDateInput) map[string]interface{} {
	m := map[string]interface{}{"year": nil, "month": nil, "day": nil}
	if d.Year != nil {
		m["year"] = *d.Year
	}
	if d.Month != nil {
		m["month"] = *d.Month
	}
	if d.Day != nil {
		m["day"] = *d.Day
	}
	return m
}

// marshalAndReturn serialises msg to protobuf wire format, copies it into a
// C-heap buffer, writes the length to outLen, and returns the buffer pointer.
// Returns nil and sets outLen to 0 on marshal failure.
func marshalAndReturn(msg proto.Message, outLen *C.int) *C.uint8_t {
	data, err := proto.Marshal(msg)
	if err != nil {
		*outLen = 0
		return nil
	}
	*outLen = C.int(len(data))
	return (*C.uint8_t)(C.CBytes(data))
}

func main() {}
