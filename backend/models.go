package main

// GraphQLQuery is the JSON body for AniList endpoint
type GraphQLQuery struct {
	Query     string                 `json:"query"`
	Variables map[string]interface{} `json:"variables"`
}

// AniListResponse is the top-level envelope from AniList API
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
							UserPreferred string `json:"userPreferred"`
						} `json:"title"`
						AverageScore int32 `json:"averageScore"`
						CoverImage   struct {
							Large string `json:"large"`
							Color string `json:"color"`
						} `json:"coverImage"`
						Episodes    int32  `json:"episodes"`
						Format      string `json:"format"`
						IsAdult     bool   `json:"isAdult"`
						IsFavourite bool   `json:"isFavourite"`
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
