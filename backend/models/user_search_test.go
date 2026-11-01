package models

import (
	"encoding/json"
	"testing"
)

func TestUserSearchDTO_UnmarshalAndToProto(t *testing.T) {
	jsonData := `{
		"Page": {
			"pageInfo": {
				"hasNextPage": true,
				"currentPage": 1,
				"total": 42
			},
			"users": [
				{
					"id": 12345,
					"name": "TestUser",
					"avatar": {
						"large": "https://example.com/large.jpg",
						"medium": "https://example.com/medium.jpg"
					},
					"isFollowing": true,
					"isFollower": false
				}
			]
		}
	}`

	var dto UserSearchDTO
	if err := json.Unmarshal([]byte(jsonData), &dto); err != nil {
		t.Fatalf("Failed to unmarshal UserSearchDTO: %v", err)
	}

	pageInfo := dto.Page.PageInfo.ToProto()
	if !pageInfo.HasNextPage || pageInfo.CurrentPage != 1 {
		t.Errorf("Unexpected pageInfo: %+v", pageInfo)
	}

	if len(dto.Page.Users) != 1 {
		t.Fatalf("Expected 1 user, got %d", len(dto.Page.Users))
	}

	pbUser := dto.Page.Users[0].ToProto()
	if pbUser.Id != 12345 || pbUser.Name != "TestUser" || !pbUser.IsFollowing || pbUser.IsFollower {
		t.Errorf("Unexpected pbUser: %+v", pbUser)
	}
}
