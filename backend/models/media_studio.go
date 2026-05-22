package models

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

// StudioConnection represents a list of studio edges
type StudioConnection struct {
	Edges []StudioEdge `json:"edges"`
}
