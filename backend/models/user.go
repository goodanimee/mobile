package models

import pb "goodanime-backend/proto"

// UserProfileDTO represents the DTO for user profile queries.
type UserProfileDTO struct {
	User struct {
		ID          int32  `json:"id"`
		Name        string `json:"name"`
		About       string `json:"about"`
		Avatar      struct {
			Large  string `json:"large"`
			Medium string `json:"medium"`
		} `json:"avatar"`
		BannerImage string `json:"bannerImage"`
		IsFollowing bool   `json:"isFollowing"`
		IsFollower  bool   `json:"isFollower"`
		CreatedAt   int32  `json:"createdAt"`
		Statistics  struct {
			Anime struct {
				Count int32 `json:"count"`
			} `json:"anime"`
			Manga struct {
				Count int32 `json:"count"`
			} `json:"manga"`
		} `json:"statistics"`
	} `json:"User"`
	Followers *struct {
		PageInfo struct {
			Total int32 `json:"total"`
		} `json:"pageInfo"`
	} `json:"followers"`
	Following *struct {
		PageInfo struct {
			Total int32 `json:"total"`
		} `json:"pageInfo"`
	} `json:"following"`
}

// UserFollowCountsDTO represents the DTO for follower and following tallies.
type UserFollowCountsDTO struct {
	Followers struct {
		PageInfo struct {
			Total int32 `json:"total"`
		} `json:"pageInfo"`
	} `json:"followers"`
	Following struct {
		PageInfo struct {
			Total int32 `json:"total"`
		} `json:"pageInfo"`
	} `json:"following"`
}

// ToggleFollowDTO represents the DTO for the ToggleFollow mutation response.
type ToggleFollowDTO struct {
	ToggleFollow struct {
		ID          int32  `json:"id"`
		Name        string `json:"name"`
		IsFollowing bool   `json:"isFollowing"`
	} `json:"ToggleFollow"`
}

// ToProto converts UserProfileDTO to its protobuf representation.
func (u *UserProfileDTO) ToProto() *pb.UserProfile {
	if u == nil {
		return nil
	}
	profile := &pb.UserProfile{
		Id:          u.User.ID,
		Name:        u.User.Name,
		About:       u.User.About,
		Avatar: &pb.UserAvatar{
			Large:  u.User.Avatar.Large,
			Medium: u.User.Avatar.Medium,
		},
		BannerImage: u.User.BannerImage,
		IsFollowing: u.User.IsFollowing,
		IsFollower:  u.User.IsFollower,
		CreatedAt:   u.User.CreatedAt,
		AnimeCount:  u.User.Statistics.Anime.Count,
		MangaCount:  u.User.Statistics.Manga.Count,
	}
	if u.Followers != nil {
		profile.FollowersCount = u.Followers.PageInfo.Total
	}
	if u.Following != nil {
		profile.FollowingCount = u.Following.PageInfo.Total
	}
	return profile
}
