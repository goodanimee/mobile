package models

// MediaListEntry represents a media list entry
type MediaListEntry struct {
	ID          int32            `json:"id"`
	Status      *MediaListStatus `json:"status"`
	Progress    int32            `json:"progress"`
	Score       float64          `json:"score"`
	Repeat      int32            `json:"repeat"`
	StartedAt   FuzzyDate        `json:"startedAt"`
	CompletedAt FuzzyDate        `json:"completedAt"`
}

// SaveMediaListEntryDTO represents the DTO for saving a list entry
type SaveMediaListEntryDTO struct {
	SaveMediaListEntry MediaListEntry `json:"SaveMediaListEntry"`
}

// DeleteMediaListEntry represents the response when deleting a list entry
type DeleteMediaListEntry struct {
	Deleted bool `json:"deleted"`
}

// DeleteMediaListEntryDTO represents the DTO for deleting a list entry
type DeleteMediaListEntryDTO struct {
	DeleteMediaListEntry DeleteMediaListEntry `json:"DeleteMediaListEntry"`
}
