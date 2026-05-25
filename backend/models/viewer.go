package models

import pb "goodanime-backend/proto"

// ToProto converts ViewerAvatar to its protobuf representation.
func (a *ViewerAvatar) ToProto() *pb.ViewerAvatar {
	if a == nil {
		return nil
	}
	return &pb.ViewerAvatar{
		Medium: a.Medium,
	}
}

// ToProto converts Viewer to its protobuf representation.
func (v *Viewer) ToProto() *pb.Viewer {
	if v == nil {
		return nil
	}
	return &pb.Viewer{
		Id:        v.ID,
		Name:      v.Name,
		CreatedAt: v.CreatedAt,
		Avatar:    v.Avatar.ToProto(),
	}
}

// ViewerAvatar represents the avatar for a viewer
type ViewerAvatar struct {
	Medium string `json:"medium"`
}

// Viewer represents a user on the platform
type Viewer struct {
	ID        int32        `json:"id"`
	Name      string       `json:"name"`
	CreatedAt int32        `json:"createdAt"`
	Avatar    ViewerAvatar `json:"avatar"`
}

// ViewerDTO represents the DTO for a viewer query
type ViewerDTO struct {
	Viewer Viewer `json:"Viewer"`
}
