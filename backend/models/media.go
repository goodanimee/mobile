package models

// Trailer represents a media trailer
type Trailer struct {
	ID        string `json:"id"`
	Site      string `json:"site"`
	Thumbnail string `json:"thumbnail"`
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

// Studio represents a production studio
type Studio struct {
	ID   int32  `json:"id"`
	Name string `json:"name"`
}

// StudioEdge represents a link between a media and a studio
type StudioEdge struct {
	IsMain bool   `json:"isMain"`
	Node   Studio `json:"node"`
}

// MediaTag represents a descriptive tag for a media
type MediaTag struct {
	ID               int32  `json:"id"`
	IsGeneralSpoiler bool   `json:"isGeneralSpoiler"`
	IsMediaSpoiler   bool   `json:"isMediaSpoiler"`
	Name             string `json:"name"`
	Rank             int32  `json:"rank"`
}

// ExternalLink represents a link to an external site
type ExternalLink struct {
	Language string `json:"language"`
	Site     string `json:"site"`
	URL      string `json:"url"`
}

// MediaEdge represents a link between two media
type MediaEdge struct {
	RelationType string    `json:"relationType"`
	Node         *MediaMin `json:"node"`
}

// MediaConnection represents a paginated list of media relations
type MediaConnection struct {
	Edges []MediaEdge `json:"edges"`
}

// CharacterName represents the names of a character
type CharacterName struct {
	Full               string   `json:"full"`
	Native             *string  `json:"native"`
	UserPreferred      *string  `json:"userPreferred"`
	Alternative        []string `json:"alternative"`
	AlternativeSpoiler []string `json:"alternativeSpoiler"`
}

// CharacterImage represents the images of a character
type CharacterImage struct {
	Large  *string `json:"large"`
	Medium *string `json:"medium"`
}

// Character represents a character in a media
type Character struct {
	Name        *CharacterName  `json:"name"`
	Image       *CharacterImage `json:"image"`
	Gender      *string         `json:"gender"`
	Age         *string         `json:"age"`
	DateOfBirth *FuzzyDate      `json:"dateOfBirth"`
	Description *string         `json:"description"`
}

// CharacterEdge represents a link between a media and a character
type CharacterEdge struct {
	ID          int32      `json:"id"`
	Role        string     `json:"role"`
	Name        string     `json:"name"`
	Node        *Character `json:"node"`
	VoiceActors []Staff    `json:"voiceActors"`
}

// CharacterConnection represents a paginated list of characters
type CharacterConnection struct {
	Edges    []CharacterEdge `json:"edges"`
	PageInfo PageInfo        `json:"pageInfo"`
}

// StaffName represents the names of a staff member
type StaffName struct {
	Full          string  `json:"full"`
	Native        *string `json:"native"`
	UserPreferred *string `json:"userPreferred"`
}

// StaffImage represents the images of a staff member
type StaffImage struct {
	Large  *string `json:"large"`
	Medium *string `json:"medium"`
}

// Staff represents a staff member
type Staff struct {
	Name       *StaffName  `json:"name"`
	Image      *StaffImage `json:"image"`
	LanguageV2 *string     `json:"languageV2"`
}

// StaffEdge represents a link between a media and a staff member
type StaffEdge struct {
	Role string `json:"role"`
	Node *Staff `json:"node"`
}

// StaffConnection represents a paginated list of staff
type StaffConnection struct {
	Edges    []StaffEdge `json:"edges"`
	PageInfo PageInfo    `json:"pageInfo"`
}

// Recommendation represents a recommended media
type Recommendation struct {
	Rating              int32     `json:"rating"`
	MediaRecommendation *MediaMin `json:"mediaRecommendation"`
}

// RecommendationConnection represents a paginated list of recommendations
type RecommendationConnection struct {
	Edges    []RecommendationEdge `json:"edges"`
	PageInfo PageInfo             `json:"pageInfo"`
}

// RecommendationEdge represents a recommendation edge
type RecommendationEdge struct {
	Node Recommendation `json:"node"`
}

// AiringSchedule represents an airing episode
type AiringSchedule struct {
	AiringAt        int32 `json:"airingAt"`
	Episode         int32 `json:"episode"`
	TimeUntilAiring int32 `json:"timeUntilAiring"`
}

// StreamingEpisode represents a streaming link for an episode
type StreamingEpisode struct {
	Thumbnail string `json:"thumbnail"`
	Title     string `json:"title"`
	URL       string `json:"url"`
}

// MediaRank represents a ranking for a media
type MediaRank struct {
	AllTime bool   `json:"allTime"`
	Rank    int32  `json:"rank"`
	Type    string `json:"type"`
	Season  string `json:"season"`
	Year    int32  `json:"year"`
}

// MediaStats represents statistics for a media
type MediaStats struct {
	ScoreDistribution []struct {
		Amount int32 `json:"amount"`
		Score  int32 `json:"score"`
	} `json:"scoreDistribution"`
	StatusDistribution []struct {
		Amount int32  `json:"amount"`
		Status string `json:"status"`
	} `json:"statusDistribution"`
}

// MediaTrend represents a trend data point
type MediaTrend struct {
	AverageScore int32 `json:"averageScore"`
	Date         int32 `json:"date"`
	InProgress   int32 `json:"inProgress"`
	Popularity   int32 `json:"popularity"`
}

// MediaTrendConnection represents a list of trends
type MediaTrendConnection struct {
	Nodes []MediaTrend `json:"nodes"`
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

// Media represents the core media domain model
type Media struct {
	MediaMin
	Description    string          `json:"description"`
	BannerImage    string          `json:"bannerImage"`
	Status         string          `json:"status"`
	Genres         []string        `json:"genres"`
	Popularity     int32           `json:"popularity"`
	Season         string          `json:"season"`
	SeasonYear     int32           `json:"seasonYear"`
	Type           string          `json:"type"`
	Trailer        *Trailer        `json:"trailer"`
	MediaListEntry *MediaListEntry `json:"mediaListEntry"`
	Studios        struct {
		Edges []StudioEdge `json:"edges"`
	} `json:"studios"`
	Tags              []MediaTag               `json:"tags"`
	ExternalLinks     []ExternalLink           `json:"externalLinks"`
	StreamingEpisodes []StreamingEpisode       `json:"streamingEpisodes"`
	Staff             StaffConnection          `json:"staff"`
	NextAiringEpisode *AiringSchedule          `json:"nextAiringEpisode"`
	Characters        CharacterConnection      `json:"characters"`
	Relations         MediaConnection          `json:"relations"`
	Recommendations   RecommendationConnection `json:"recommendations"`
	Rankings          []MediaRank              `json:"rankings"`
	Stats             MediaStats               `json:"stats"`
	Trends            MediaTrendConnection     `json:"trends"`
	MeanScore         *int32                   `json:"meanScore"`
	Favourites        *int32                   `json:"favourites"`
	Synonyms          []string                 `json:"synonyms"`
}

// MediaDTO represents the DTO for a media query
type MediaDTO struct {
	Media Media `json:"Media"`
}

// ToggleFavourite represents the response for a favourite toggle
type ToggleFavourite struct {
	Anime struct {
		Nodes []struct {
			ID          int32 `json:"id"`
			IsFavourite bool  `json:"isFavourite"`
		} `json:"nodes"`
	} `json:"anime"`
}

// ToggleFavouriteDTO represents the DTO for a favourite toggle mutation
type ToggleFavouriteDTO struct {
	ToggleFavourite ToggleFavourite `json:"ToggleFavourite"`
}
