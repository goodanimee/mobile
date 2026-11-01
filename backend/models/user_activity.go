package models

import pb "goodanime-backend/proto"

// UserActivityUserDTO represents an activity author, messenger, or recipient.
type UserActivityUserDTO struct {
	ID     int32  `json:"id"`
	Name   string `json:"name"`
	Avatar struct {
		Large  string `json:"large"`
		Medium string `json:"medium"`
	} `json:"avatar"`
}

// ToProto converts UserActivityUserDTO to its protobuf representation.
func (u *UserActivityUserDTO) ToProto() *pb.UserActivityUser {
	if u == nil {
		return nil
	}
	return &pb.UserActivityUser{
		Id:   u.ID,
		Name: u.Name,
		Avatar: &pb.UserAvatar{
			Large:  u.Avatar.Large,
			Medium: u.Avatar.Medium,
		},
	}
}

// UserActivityDTO represents a union activity entry returned by AniList.
type UserActivityDTO struct {
	Typename   string               `json:"__typename"`
	ID         int32                `json:"id"`
	Type       string               `json:"type"`
	CreatedAt  int32                `json:"createdAt"`
	IsLiked    bool                 `json:"isLiked"`
	LikeCount  int32                `json:"likeCount"`
	ReplyCount int32                `json:"replyCount"`
	Status     string               `json:"status"`
	Progress   string               `json:"progress"`
	Text       string               `json:"text"`
	Message    string               `json:"message"`
	IsPrivate  bool                 `json:"isPrivate"`
	User       *UserActivityUserDTO `json:"user"`
	Messenger  *UserActivityUserDTO `json:"messenger"`
	Recipient  *UserActivityUserDTO `json:"recipient"`
	Media      *MediaMin            `json:"media"`
}

// ToProto converts UserActivityDTO to its protobuf representation.
func (a *UserActivityDTO) ToProto() *pb.UserActivity {
	if a == nil || a.ID <= 0 {
		return nil
	}

	author := a.User
	if author == nil {
		author = a.Messenger
	}

	textHTML := a.Text
	if textHTML == "" {
		textHTML = a.Message
	}

	actType := a.Type
	if actType == "" {
		switch a.Typename {
		case "TextActivity":
			actType = "TEXT"
		case "MessageActivity":
			actType = "MESSAGE"
		case "ListActivity":
			if a.Media != nil && a.Media.Type == "MANGA" {
				actType = "MANGA_LIST"
			} else {
				actType = "ANIME_LIST"
			}
		}
	}

	return &pb.UserActivity{
		Id:         a.ID,
		Type:       actType,
		CreatedAt:  a.CreatedAt,
		IsLiked:    a.IsLiked,
		LikeCount:  a.LikeCount,
		ReplyCount: a.ReplyCount,
		Status:     a.Status,
		Progress:   a.Progress,
		TextHtml:   textHTML,
		IsPrivate:  a.IsPrivate,
		User:       author.ToProto(),
		Recipient:  a.Recipient.ToProto(),
		Media:      a.Media.ToProto(),
	}
}

// UserActivitiesPageDTO represents the paginated GraphQL response for user activities.
type UserActivitiesPageDTO struct {
	Page struct {
		PageInfo   PageInfo          `json:"pageInfo"`
		Activities []UserActivityDTO `json:"activities"`
	} `json:"Page"`
}
