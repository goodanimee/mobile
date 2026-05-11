package main

// GraphQLQuery is the JSON body sent to the AniList GraphQL endpoint.
type GraphQLQuery struct {
	Query     string                 `json:"query"`
	Variables map[string]interface{} `json:"variables"`
}

// AniListResponse is the top-level envelope returned by the AniList API.
// Only the fields used by the three exported functions are declared.
type AniListResponse struct {
	Data struct {
		MediaListCollection struct {
			HasNextChunk bool `json:"hasNextChunk"`
			Lists        []struct {
				Name    string `json:"name"`
				Status  string `json:"status"`
				Entries []struct {
					Media struct {
						ID    int32 `json:"id"`
						Title struct {
							English       string `json:"english"`
							Native        string `json:"native"`
							Romaji        string `json:"romaji"`
							UserPreferred string `json:"userPreferred"`
						} `json:"title"`
						AverageScore int32  `json:"averageScore"`
						BannerImage  string `json:"bannerImage"`
						CoverImage   struct {
							Medium     string `json:"medium"`
							Large      string `json:"large"`
							ExtraLarge string `json:"extraLarge"`
							Color      string `json:"color"`
						} `json:"coverImage"`
						Description string   `json:"description"`
						Duration    int32    `json:"duration"`
						Episodes    int32    `json:"episodes"`
						Format      string   `json:"format"`
						Genres      []string `json:"genres"`
						IsAdult     bool     `json:"isAdult"`
						IsFavourite bool     `json:"isFavourite"`
						Popularity  int32    `json:"popularity"`
						Season      string   `json:"season"`
						SeasonYear  int32    `json:"seasonYear"`
						Status      string   `json:"status"`
						Synonyms    []string `json:"synonyms"`
						MeanScore   int32    `json:"meanScore"`
						Favourites  int32    `json:"favourites"`
						SiteUrl     string   `json:"siteUrl"`
						StartDate   struct {
							Day   *int32 `json:"day"`
							Month *int32 `json:"month"`
							Year  *int32 `json:"year"`
						} `json:"startDate"`
						EndDate struct {
							Day   *int32 `json:"day"`
							Month *int32 `json:"month"`
							Year  *int32 `json:"year"`
						} `json:"endDate"`
						Trailer struct {
							ID        string `json:"id"`
							Site      string `json:"site"`
							Thumbnail string `json:"thumbnail"`
						} `json:"trailer"`
					} `json:"media"`
					Progress  int32   `json:"progress"`
					Repeat    int32   `json:"repeat"`
					Status    string  `json:"status"`
					Score     float64 `json:"score"`
					StartedAt struct {
						Day   *int32 `json:"day"`
						Month *int32 `json:"month"`
						Year  *int32 `json:"year"`
					} `json:"startedAt"`
					CompletedAt struct {
						Day   *int32 `json:"day"`
						Month *int32 `json:"month"`
						Year  *int32 `json:"year"`
					} `json:"completedAt"`
				} `json:"entries"`
			} `json:"lists"`
		} `json:"MediaListCollection"`
		Viewer struct {
			ID        int32  `json:"id"`
			Name      string `json:"name"`
			CreatedAt int32  `json:"createdAt"`
			Avatar    struct {
				Medium string `json:"medium"`
			} `json:"avatar"`
		} `json:"Viewer"`
		SaveMediaListEntry struct {
			ID        int32   `json:"id"`
			Status    string  `json:"status"`
			Progress  int32   `json:"progress"`
			Score     float64 `json:"score"`
			Repeat    int32   `json:"repeat"`
			StartedAt struct {
				Day   *int32 `json:"day"`
				Month *int32 `json:"month"`
				Year  *int32 `json:"year"`
			} `json:"startedAt"`
			CompletedAt struct {
				Day   *int32 `json:"day"`
				Month *int32 `json:"month"`
				Year  *int32 `json:"year"`
			} `json:"completedAt"`
		} `json:"SaveMediaListEntry"`
	} `json:"data"`
	Errors []struct {
		Message string `json:"message"`
	} `json:"errors"`
}
