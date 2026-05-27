package models

import pb "goodanime-backend/proto"

// ToProto converts CoverImage to its protobuf representation.
func (c *CoverImage) ToProto() *pb.CoverImage {
	if c == nil {
		return nil
	}
	return &pb.CoverImage{
		Medium:     c.Medium,
		Large:      c.Large,
		ExtraLarge: c.ExtraLarge,
		Color:      c.Color,
	}
}

// ToProto converts Title to its protobuf representation.
func (t *Title) ToProto() *pb.Title {
	if t == nil {
		return nil
	}
	return &pb.Title{
		English:       t.English,
		Native:        t.Native,
		Romaji:        t.Romaji,
		UserPreferred: t.UserPreferred,
	}
}

// ToProto converts MediaMin to its protobuf representation.
func (m *MediaMin) ToProto() *pb.MediaMin {
	if m == nil {
		return nil
	}
	return &pb.MediaMin{
		Id:           m.ID,
		Title:        m.Title.ToProto(),
		AverageScore: m.AverageScore,
		CoverImage:   m.CoverImage.ToProto(),
		Episodes:     m.Episodes,
		Format:       m.Format,
		IsAdult:      m.IsAdult,
		IsFavourite:  m.IsFavourite,
		SiteUrl:      m.SiteURL,
	}
}

// CoverImage represents a media cover image
type CoverImage struct {
	Medium     string `json:"medium"`
	Large      string `json:"large"`
	ExtraLarge string `json:"extraLarge"`
	Color      string `json:"color"`
}

// Title represents the various titles for a media
type Title struct {
	English       string `json:"english"`
	Native        string `json:"native"`
	Romaji        string `json:"romaji"`
	UserPreferred string `json:"userPreferred"`
}

// MediaMin represents the minimal media data used in lists and relations
type MediaMin struct {
	ID           int32      `json:"id"`
	Title        Title      `json:"title"`
	Type         string     `json:"type"`
	AverageScore int32      `json:"averageScore"`
	CoverImage   CoverImage `json:"coverImage"`
	Episodes     int32      `json:"episodes"`
	Chapters     int32      `json:"chapters"`
	Format       string     `json:"format"`
	IsAdult      bool       `json:"isAdult"`
	IsFavourite  bool       `json:"isFavourite"`
	SiteURL      string     `json:"siteUrl"`
}
