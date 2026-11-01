package models

import (
	"encoding/json"
	"strings"
	"testing"

	pb "goodanime-backend/proto"
)

func TestBuildPreviewBatchesCoalescesMixedEntitiesIntoSingleQuery(t *testing.T) {
	req := &pb.ResolveAnilistPreviewsRequest{
		MediaIds:     []int32{21, 16498, 21},
		CharacterIds: []int32{40},
		StaffIds:     []int32{95001},
		StudioIds:    []int32{18},
		UserIds:      []int32{42},
		Usernames:    []string{"minxi", "MINXI"},
	}

	batches := BuildPreviewBatches(req)
	if len(batches) != 1 {
		t.Fatalf("expected 1 coalesced batch, got %d", len(batches))
	}

	b := batches[0]
	if !strings.Contains(b.Query, "m0: Page(page: 1, perPage: 2)") {
		t.Errorf("expected media perPage 2 after deduplication, got query:\n%s", b.Query)
	}
	if len(b.Aliases) != 6 {
		t.Errorf("expected 6 aliases, got %d: %v", len(b.Aliases), b.Aliases)
	}
	if got := b.Variables["un0"]; got != "minxi" {
		t.Errorf("expected username variable 'minxi', got %v", got)
	}
}

func TestBuildPreviewBatchesSplitsLargeRequests(t *testing.T) {
	ids := make([]int32, 65)
	for i := range ids {
		ids[i] = int32(i + 1)
	}

	batches := BuildPreviewBatches(&pb.ResolveAnilistPreviewsRequest{
		MediaIds: ids,
	})
	if len(batches) != 2 {
		t.Fatalf("expected 2 batches for 65 media IDs, got %d", len(batches))
	}
	if len(batches[0].Variables["m0"].([]int32)) != 50 {
		t.Errorf("expected first chunk size 50")
	}
	if len(batches[1].Variables["m1"].([]int32)) != 15 {
		t.Errorf("expected second chunk size 15")
	}
}

func TestMergePreviewBatchDataDecodesAndDeduplicates(t *testing.T) {
	payload := `{
		"m0": {
			"media": [
				{
					"id": 21,
					"type": "ANIME",
					"format": "TV",
					"episodes": 1100,
					"averageScore": 88,
					"coverImage": {"large": "https://img/op.jpg", "color": "#e4a15d"},
					"title": {"userPreferred": "One Piece"}
				}
			]
		},
		"c0": {
			"characters": [
				{
					"id": 40,
					"favourites": 1200,
					"name": {"full": "Luffy", "userPreferred": "Monkey D. Luffy"},
					"image": {"large": "https://img/luffy.jpg"}
				}
			]
		},
		"un0": {
			"users": [
				{
					"id": 77,
					"name": "minxi",
					"avatar": {"large": "https://img/u77.jpg"},
					"statistics": {"anime": {"count": 150}, "manga": {"count": 30}}
				}
			]
		},
		"uid0": {
			"users": [
				{
					"id": 77,
					"name": "minxi"
				}
			]
		}
	}`

	pages, err := DecodePreviewBatchJSON(json.RawMessage(payload))
	if err != nil {
		t.Fatalf("unexpected decode error: %v", err)
	}

	var resp pb.ResolveAnilistPreviewsResponse
	MergePreviewBatchData([]string{"m0", "c0", "un0", "uid0"}, pages, &resp)

	if len(resp.Media) != 1 || resp.Media[0].Id != 21 {
		t.Fatalf("expected 1 media (id 21), got %v", resp.Media)
	}
	if len(resp.Characters) != 1 || resp.Characters[0].GetId() != 40 {
		t.Fatalf("expected 1 character (id 40), got %v", resp.Characters)
	}
	if len(resp.Users) != 1 || resp.Users[0].Id != 77 || resp.Users[0].AnimeCount != 150 {
		t.Fatalf("expected 1 deduplicated user (id 77, anime 150), got %v", resp.Users)
	}
}
