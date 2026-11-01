package models

import (
	"encoding/json"
	"testing"
)

func TestUserFavouritesDTOToProtoAllCategories(t *testing.T) {
	rawJSON := `{
		"User": {
			"favourites": {
				"anime": {
					"pageInfo": { "hasNextPage": true, "currentPage": 1, "total": 42 },
					"nodes": [
						null,
						{
							"id": 21,
							"type": "ANIME",
							"title": { "english": "One Piece", "userPreferred": "One Piece" },
							"averageScore": 88,
							"format": "TV"
						}
					]
				},
				"manga": {
					"pageInfo": { "hasNextPage": false, "currentPage": 1, "total": 0 },
					"nodes": []
				},
				"characters": {
					"pageInfo": { "hasNextPage": false, "currentPage": 1, "total": 1 },
					"nodes": [
						{
							"id": 40,
							"name": { "full": "Monkey D. Luffy", "userPreferred": "Monkey D. Luffy" },
							"favourites": 50000
						}
					]
				},
				"staff": {
					"pageInfo": { "hasNextPage": false, "currentPage": 1, "total": 1 },
					"nodes": [
						{
							"id": 96879,
							"name": { "full": "Eiichiro Oda", "userPreferred": "Eiichiro Oda" },
							"primaryOccupations": ["Mangaka"],
							"favourites": 25000
						}
					]
				},
				"studios": {
					"pageInfo": { "hasNextPage": false, "currentPage": 1, "total": 1 },
					"nodes": [
						{
							"id": 18,
							"name": "Toei Animation",
							"favourites": 4200
						}
					]
				}
			}
		}
	}`

	var dto UserFavouritesDTO
	if err := json.Unmarshal([]byte(rawJSON), &dto); err != nil {
		t.Fatalf("unexpected unmarshal error: %v", err)
	}

	protoFavs := dto.ToProto()
	if protoFavs == nil {
		t.Fatal("expected non-nil UserFavourites proto")
	}

	if protoFavs.Anime == nil || len(protoFavs.Anime.Nodes) != 1 {
		t.Fatalf("expected 1 non-nil anime node, got %+v", protoFavs.Anime)
	}
	if protoFavs.Anime.Total != 42 || !protoFavs.Anime.PageInfo.HasNextPage {
		t.Fatalf("unexpected anime pagination: %+v", protoFavs.Anime)
	}
	if protoFavs.Manga == nil || len(protoFavs.Manga.Nodes) != 0 {
		t.Fatalf("expected empty manga connection, got %+v", protoFavs.Manga)
	}
	if protoFavs.Characters == nil || len(protoFavs.Characters.Nodes) != 1 || protoFavs.Characters.Nodes[0].GetId() != 40 {
		t.Fatalf("unexpected characters connection: %+v", protoFavs.Characters)
	}
	if protoFavs.Staff == nil || len(protoFavs.Staff.Nodes) != 1 || protoFavs.Staff.Nodes[0].PrimaryOccupations[0] != "Mangaka" {
		t.Fatalf("unexpected staff connection: %+v", protoFavs.Staff)
	}
	if protoFavs.Studios == nil || len(protoFavs.Studios.Nodes) != 1 || protoFavs.Studios.Nodes[0].Name != "Toei Animation" {
		t.Fatalf("unexpected studios connection: %+v", protoFavs.Studios)
	}
}

func TestUserFavouritesDTOSingleCategoryPagination(t *testing.T) {
	rawJSON := `{
		"User": {
			"favourites": {
				"characters": {
					"pageInfo": { "hasNextPage": false, "currentPage": 2, "total": 0 },
					"nodes": [
						{
							"id": 62,
							"name": { "full": "Roronoa Zoro" }
						}
					]
				}
			}
		}
	}`

	var dto UserFavouritesDTO
	if err := json.Unmarshal([]byte(rawJSON), &dto); err != nil {
		t.Fatalf("unexpected unmarshal error: %v", err)
	}

	protoFavs := dto.ToProto()
	if protoFavs == nil {
		t.Fatal("expected non-nil UserFavourites proto")
	}
	if protoFavs.Anime != nil || protoFavs.Manga != nil || protoFavs.Staff != nil || protoFavs.Studios != nil {
		t.Fatalf("expected unqueried categories to remain nil, got %+v", protoFavs)
	}
	if protoFavs.Characters == nil || protoFavs.Characters.PageInfo.CurrentPage != 2 {
		t.Fatalf("expected page 2 characters connection, got %+v", protoFavs.Characters)
	}
	if protoFavs.Characters.Total != 1 {
		t.Fatalf("expected total floor clamped to node count 1, got %d", protoFavs.Characters.Total)
	}
}
