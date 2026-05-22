package models

// Trailer represents a media trailer
type Trailer struct {
	ID        string `json:"id"`
	Site      string `json:"site"`
	Thumbnail string `json:"thumbnail"`
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
