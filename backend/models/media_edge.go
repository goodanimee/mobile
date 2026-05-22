package models

// MediaEdge represents a link between two media
type MediaEdge struct {
	RelationType string    `json:"relationType"`
	Node         *MediaMin `json:"node"`
}

// MediaConnection represents a paginated list of media relations
type MediaConnection struct {
	Edges []MediaEdge `json:"edges"`
}
