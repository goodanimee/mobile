package models

// Recommendation represents a recommended media
type Recommendation struct {
	Rating              int32     `json:"rating"`
	MediaRecommendation *MediaMin `json:"mediaRecommendation"`
}

// RecommendationEdge represents a recommendation edge
type RecommendationEdge struct {
	Node Recommendation `json:"node"`
}

// RecommendationConnection represents a paginated list of recommendations
type RecommendationConnection struct {
	Edges    []RecommendationEdge `json:"edges"`
	PageInfo PageInfo             `json:"pageInfo"`
}
