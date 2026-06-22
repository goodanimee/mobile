package models

// GenreCollectionDTO represents the response containing GenreCollection.
type GenreCollectionDTO struct {
	GenreCollection []string `json:"GenreCollection"`
}

// MediaTagCollectionDTO represents the response containing MediaTagCollection.
type MediaTagCollectionDTO struct {
	MediaTagCollection []MediaTag `json:"MediaTagCollection"`
}
