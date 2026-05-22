package models

// Media represents the core media domain model
type Media struct {
	MediaMin
	Description       string                   `json:"description"`
	BannerImage       string                   `json:"bannerImage"`
	Status            string                   `json:"status"`
	Genres            []string                 `json:"genres"`
	Popularity        int32                    `json:"popularity"`
	Season            string                   `json:"season"`
	SeasonYear        int32                    `json:"seasonYear"`
	Type              string                   `json:"type"`
	Trailer           *Trailer                 `json:"trailer"`
	MediaListEntry    *MediaListEntry          `json:"mediaListEntry"`
	Studios           *StudioConnection        `json:"studios"`
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
