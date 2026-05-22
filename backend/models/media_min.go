package models

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
	AverageScore int32      `json:"averageScore"`
	CoverImage   CoverImage `json:"coverImage"`
	Episodes     int32      `json:"episodes"`
	Format       string     `json:"format"`
	IsAdult      bool       `json:"isAdult"`
	IsFavourite  bool       `json:"isFavourite"`
	SiteURL      string     `json:"siteUrl"`
}
