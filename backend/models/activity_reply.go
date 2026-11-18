package models

import pb "goodanime-backend/proto"

// ActivityReplyDTO represents a reply to an activity.
type ActivityReplyDTO struct {
	ID         int32                `json:"id"`
	UserID     int32                `json:"userId"`
	ActivityID int32                `json:"activityId"`
	Text       string               `json:"text"`
	CreatedAt  int32                `json:"createdAt"`
	LikeCount  int32                `json:"likeCount"`
	IsLiked    bool                 `json:"isLiked"`
	User       *UserActivityUserDTO `json:"user"`
}

// ToProto converts ActivityReplyDTO to its protobuf representation.
func (r *ActivityReplyDTO) ToProto() *pb.ActivityReply {
	if r == nil || r.ID <= 0 {
		return nil
	}
	return &pb.ActivityReply{
		Id:         r.ID,
		UserId:     r.UserID,
		ActivityId: r.ActivityID,
		Text:       r.Text,
		CreatedAt:  r.CreatedAt,
		LikeCount:  r.LikeCount,
		IsLiked:    r.IsLiked,
		User:       r.User.ToProto(),
	}
}

// ActivityRepliesPageDTO represents the paginated GraphQL response for activity replies.
type ActivityRepliesPageDTO struct {
	Page struct {
		PageInfo        FavouritePageInfoDTO `json:"pageInfo"`
		ActivityReplies []ActivityReplyDTO   `json:"activityReplies"`
	} `json:"Page"`
}

// SaveActivityReplyDTO represents the GraphQL response for SaveActivityReply mutation.
type SaveActivityReplyDTO struct {
	SaveActivityReply *ActivityReplyDTO `json:"SaveActivityReply"`
}

// ToggleActivityReplyLikeDTO represents the GraphQL response for ToggleLike on an activity reply.
type ToggleActivityReplyLikeDTO struct {
	ToggleLike []ToggleActivityLike `json:"ToggleLike"`
}
