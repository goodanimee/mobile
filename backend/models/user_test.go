package models

import (
	"encoding/json"
	"testing"
)

func TestUserFollowingPageDTOToProto(t *testing.T) {
	rawJSON := `{
		"Page": {
			"pageInfo": {
				"hasNextPage": true,
				"currentPage": 1,
				"total": 12
			},
			"following": [
				{
					"id": 101,
					"name": "alice",
					"avatar": {
						"large": "https://img.com/a_lg.jpg",
						"medium": "https://img.com/a_med.jpg"
					},
					"isFollowing": true,
					"isFollower": false
				},
				null
			]
		}
	}`

	var dto UserFollowingPageDTO
	if err := json.Unmarshal([]byte(rawJSON), &dto); err != nil {
		t.Fatalf("unexpected unmarshal error: %v", err)
	}

	if !dto.Page.PageInfo.HasNextPage || dto.Page.PageInfo.Total != 12 {
		t.Fatalf("unexpected page info: %+v", dto.Page.PageInfo)
	}

	var validUsers []*SocialUserDTO
	for _, u := range dto.Page.Following {
		if u != nil {
			validUsers = append(validUsers, u)
		}
	}
	if len(validUsers) != 1 {
		t.Fatalf("expected 1 valid user, got %d", len(validUsers))
	}

	pbUser := validUsers[0].ToProto()
	if pbUser == nil || pbUser.Id != 101 || pbUser.Name != "alice" || !pbUser.IsFollowing || pbUser.IsFollower {
		t.Fatalf("unexpected proto user: %+v", pbUser)
	}
	if pbUser.Avatar == nil || pbUser.Avatar.Large != "https://img.com/a_lg.jpg" {
		t.Fatalf("unexpected avatar: %+v", pbUser.Avatar)
	}
}

func TestUserFollowersPageDTOToProto(t *testing.T) {
	rawJSON := `{
		"Page": {
			"pageInfo": {
				"hasNextPage": false,
				"currentPage": 1,
				"total": 1
			},
			"followers": [
				{
					"id": 202,
					"name": "bob",
					"avatar": { "large": "", "medium": "" },
					"isFollowing": false,
					"isFollower": true
				}
			]
		}
	}`

	var dto UserFollowersPageDTO
	if err := json.Unmarshal([]byte(rawJSON), &dto); err != nil {
		t.Fatalf("unexpected unmarshal error: %v", err)
	}

	if len(dto.Page.Followers) != 1 {
		t.Fatalf("expected 1 follower, got %d", len(dto.Page.Followers))
	}

	pbUser := dto.Page.Followers[0].ToProto()
	if pbUser.Id != 202 || pbUser.Name != "bob" || pbUser.IsFollowing || !pbUser.IsFollower {
		t.Fatalf("unexpected proto follower: %+v", pbUser)
	}
}
