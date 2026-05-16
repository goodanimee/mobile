package models

// Viewer represents a user on the platform
type Viewer struct {
	ID        int32  `json:"id"`
	Name      string `json:"name"`
	CreatedAt int32  `json:"createdAt"`
	Avatar    struct {
		Medium string `json:"medium"`
	} `json:"avatar"`
}

// ViewerDTO represents the DTO for a viewer query
type ViewerDTO struct {
	Viewer Viewer `json:"Viewer"`
}
