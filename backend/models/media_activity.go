package models

import pb "goodanime-backend/proto"

// ListActivity represents a list activity node.
type ListActivity struct {
	Id        int32   `json:"id"`
	CreatedAt int32   `json:"createdAt"`
	IsLiked   bool    `json:"isLiked"`
	LikeCount int32   `json:"likeCount"`
	Progress  string  `json:"progress"`
	Status    string  `json:"status"`
	User      *Viewer `json:"user"`
}

// ToProto converts ListActivity to its protobuf representation.
func (la *ListActivity) ToProto() *pb.ListActivity {
	if la == nil {
		return nil
	}
	return &pb.ListActivity{
		Id:        la.Id,
		CreatedAt: la.CreatedAt,
		IsLiked:   la.IsLiked,
		LikeCount: la.LikeCount,
		Progress:  la.Progress,
		Status:    la.Status,
		User:      la.User.ToProto(),
	}
}

// PageActivities represents activities and page info.
type PageActivities struct {
	PageInfo   PageInfo       `json:"pageInfo"`
	Activities []ListActivity `json:"activities"`
}

// PageDTO represents the DTO for a page query.
type PageDTO struct {
	Page PageActivities `json:"Page"`
}

// ToggleActivityLike represents the response for a like toggle on an activity
type ToggleActivityLike struct {
	ID int32 `json:"id"`
}

// ToggleActivityLikeDTO represents the DTO for a like toggle mutation
type ToggleActivityLikeDTO struct {
	ToggleActivityLike []ToggleActivityLike `json:"ToggleLike"`
}

