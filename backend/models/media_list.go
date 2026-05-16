package models

// MediaListEntryWithMedia extends MediaListEntry to include the minimal media object
type MediaListEntryWithMedia struct {
	MediaListEntry
	Media MediaMin `json:"media"`
}

// MediaListCollection represents a collection of media lists for a user
type MediaListCollection struct {
	HasNextChunk bool `json:"hasNextChunk"`
	Lists        []struct {
		Name    string                    `json:"name"`
		Status  string                    `json:"status"`
		Entries []MediaListEntryWithMedia `json:"entries"`
	} `json:"lists"`
}

// MediaListDTO represents the DTO for a media list collection query
type MediaListDTO struct {
	MediaListCollection MediaListCollection `json:"MediaListCollection"`
}
