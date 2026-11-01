package models

// UserSearchDTO represents the Page response for user search.
type UserSearchDTO struct {
	Page struct {
		PageInfo FavouritePageInfoDTO `json:"pageInfo"`
		Users    []*SocialUserDTO     `json:"users"`
	} `json:"Page"`
}
