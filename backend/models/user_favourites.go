package models

import pb "goodanime-backend/proto"

// FavouritePageInfoDTO represents pagination metadata including total item count.
type FavouritePageInfoDTO struct {
	HasNextPage bool  `json:"hasNextPage"`
	CurrentPage int32 `json:"currentPage"`
	Total       int32 `json:"total"`
}

// ToProto converts FavouritePageInfoDTO to its PageInfo protobuf representation.
func (p *FavouritePageInfoDTO) ToProto() *pb.PageInfo {
	if p == nil {
		return nil
	}
	return &pb.PageInfo{
		HasNextPage: p.HasNextPage,
		CurrentPage: p.CurrentPage,
	}
}

// FavouriteMediaConnectionDTO represents a paginated media favourites connection.
type FavouriteMediaConnectionDTO struct {
	PageInfo FavouritePageInfoDTO `json:"pageInfo"`
	Nodes    []*MediaMin          `json:"nodes"`
}

// ToProto converts FavouriteMediaConnectionDTO to its protobuf representation.
func (c *FavouriteMediaConnectionDTO) ToProto() *pb.FavouriteMediaConnection {
	if c == nil {
		return nil
	}
	nodes := make([]*pb.MediaMin, 0, len(c.Nodes))
	for _, node := range c.Nodes {
		if pbNode := node.ToProto(); pbNode != nil {
			nodes = append(nodes, pbNode)
		}
	}
	total := c.PageInfo.Total
	if total < int32(len(nodes)) {
		total = int32(len(nodes))
	}
	return &pb.FavouriteMediaConnection{
		PageInfo: c.PageInfo.ToProto(),
		Total:    total,
		Nodes:    nodes,
	}
}

// FavouriteCharacterConnectionDTO represents a paginated character favourites connection.
type FavouriteCharacterConnectionDTO struct {
	PageInfo FavouritePageInfoDTO `json:"pageInfo"`
	Nodes    []*Character         `json:"nodes"`
}

// ToProto converts FavouriteCharacterConnectionDTO to its protobuf representation.
func (c *FavouriteCharacterConnectionDTO) ToProto() *pb.FavouriteCharacterConnection {
	if c == nil {
		return nil
	}
	nodes := make([]*pb.Character, 0, len(c.Nodes))
	for _, node := range c.Nodes {
		if pbNode := node.ToProto(); pbNode != nil {
			nodes = append(nodes, pbNode)
		}
	}
	total := c.PageInfo.Total
	if total < int32(len(nodes)) {
		total = int32(len(nodes))
	}
	return &pb.FavouriteCharacterConnection{
		PageInfo: c.PageInfo.ToProto(),
		Total:    total,
		Nodes:    nodes,
	}
}

// FavouriteStaffConnectionDTO represents a paginated staff favourites connection.
type FavouriteStaffConnectionDTO struct {
	PageInfo FavouritePageInfoDTO `json:"pageInfo"`
	Nodes    []*Staff             `json:"nodes"`
}

// ToProto converts FavouriteStaffConnectionDTO to its protobuf representation.
func (c *FavouriteStaffConnectionDTO) ToProto() *pb.FavouriteStaffConnection {
	if c == nil {
		return nil
	}
	nodes := make([]*pb.Staff, 0, len(c.Nodes))
	for _, node := range c.Nodes {
		if pbNode := node.ToProto(); pbNode != nil {
			nodes = append(nodes, pbNode)
		}
	}
	total := c.PageInfo.Total
	if total < int32(len(nodes)) {
		total = int32(len(nodes))
	}
	return &pb.FavouriteStaffConnection{
		PageInfo: c.PageInfo.ToProto(),
		Total:    total,
		Nodes:    nodes,
	}
}

// FavouriteStudioConnectionDTO represents a paginated studio favourites connection.
type FavouriteStudioConnectionDTO struct {
	PageInfo FavouritePageInfoDTO `json:"pageInfo"`
	Nodes    []*Studio            `json:"nodes"`
}

// ToProto converts FavouriteStudioConnectionDTO to its protobuf representation.
func (c *FavouriteStudioConnectionDTO) ToProto() *pb.FavouriteStudioConnection {
	if c == nil {
		return nil
	}
	nodes := make([]*pb.Studio, 0, len(c.Nodes))
	for _, node := range c.Nodes {
		if pbNode := node.ToProto(); pbNode != nil {
			nodes = append(nodes, pbNode)
		}
	}
	total := c.PageInfo.Total
	if total < int32(len(nodes)) {
		total = int32(len(nodes))
	}
	return &pb.FavouriteStudioConnection{
		PageInfo: c.PageInfo.ToProto(),
		Total:    total,
		Nodes:    nodes,
	}
}

// UserFavouritesDataDTO represents the nested favourites container on a User.
type UserFavouritesDataDTO struct {
	Anime      *FavouriteMediaConnectionDTO     `json:"anime"`
	Manga      *FavouriteMediaConnectionDTO     `json:"manga"`
	Characters *FavouriteCharacterConnectionDTO `json:"characters"`
	Staff      *FavouriteStaffConnectionDTO     `json:"staff"`
	Studios    *FavouriteStudioConnectionDTO    `json:"studios"`
}

// ToProto converts UserFavouritesDataDTO to its protobuf representation.
func (f *UserFavouritesDataDTO) ToProto() *pb.UserFavourites {
	if f == nil {
		return nil
	}
	return &pb.UserFavourites{
		Anime:      f.Anime.ToProto(),
		Manga:      f.Manga.ToProto(),
		Characters: f.Characters.ToProto(),
		Staff:      f.Staff.ToProto(),
		Studios:    f.Studios.ToProto(),
	}
}

// UserFavouritesDTO represents the GraphQL response payload for user favourites queries.
type UserFavouritesDTO struct {
	User *struct {
		Favourites *UserFavouritesDataDTO `json:"favourites"`
	} `json:"User"`
}

// ToProto converts UserFavouritesDTO to its protobuf representation.
func (u *UserFavouritesDTO) ToProto() *pb.UserFavourites {
	if u == nil || u.User == nil {
		return nil
	}
	return u.User.Favourites.ToProto()
}
