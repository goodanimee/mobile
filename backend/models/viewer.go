package models

import pb "goodanime-backend/proto"

// ToProto converts ViewerAvatar to its protobuf representation.
func (a *ViewerAvatar) ToProto() *pb.ViewerAvatar {
	if a == nil {
		return nil
	}
	return &pb.ViewerAvatar{
		Medium: a.Medium,
	}
}

// ToProto converts Viewer to its protobuf representation.
func (v *Viewer) ToProto() *pb.Viewer {
	if v == nil {
		return nil
	}
	res := &pb.Viewer{
		Id:        v.ID,
		Name:      v.Name,
		CreatedAt: v.CreatedAt,
		Avatar:    v.Avatar.ToProto(),
	}
	if v.MediaListOptions != nil {
		if v.MediaListOptions.AnimeList != nil {
			res.AnimeCustomLists = v.MediaListOptions.AnimeList.CustomLists
		}
		if v.MediaListOptions.MangaList != nil {
			res.MangaCustomLists = v.MediaListOptions.MangaList.CustomLists
		}
	}
	return res
}

// MediaListTypeOptions represents custom lists and settings for anime or manga
type MediaListTypeOptions struct {
	CustomLists  []string `json:"customLists"`
	SectionOrder []string `json:"sectionOrder"`
}

// MediaListOptions represents list options for a user
type MediaListOptions struct {
	AnimeList *MediaListTypeOptions `json:"animeList"`
	MangaList *MediaListTypeOptions `json:"mangaList"`
}

// ViewerAvatar represents the avatar for a viewer
type ViewerAvatar struct {
	Medium string `json:"medium"`
}

// Viewer represents a user on the platform
type Viewer struct {
	ID               int32             `json:"id"`
	Name             string            `json:"name"`
	CreatedAt        int32             `json:"createdAt"`
	Avatar           ViewerAvatar      `json:"avatar"`
	MediaListOptions *MediaListOptions `json:"mediaListOptions"`
}

// ViewerDTO represents the DTO for a viewer query
type ViewerDTO struct {
	Viewer Viewer `json:"Viewer"`
}

// UpdateUserDTO represents the DTO for the UpdateUser mutation response
type UpdateUserDTO struct {
	UpdateUser struct {
		ID               int32             `json:"id"`
		MediaListOptions *MediaListOptions `json:"mediaListOptions"`
	} `json:"UpdateUser"`
}
