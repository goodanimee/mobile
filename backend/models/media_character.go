package models

import pb "goodanime-backend/proto"

// ToProto converts CharacterName to its protobuf representation.
func (n *CharacterName) ToProto() *pb.CharacterName {
	if n == nil {
		return nil
	}
	return &pb.CharacterName{
		Full:               n.Full,
		Native:             n.Native,
		UserPreferred:      n.UserPreferred,
		Alternative:        n.Alternative,
		AlternativeSpoiler: n.AlternativeSpoiler,
	}
}

// ToProto converts CharacterImage to its protobuf representation.
func (i *CharacterImage) ToProto() *pb.CharacterImage {
	if i == nil {
		return nil
	}
	return &pb.CharacterImage{
		Large:  i.Large,
		Medium: i.Medium,
	}
}

// ToProto converts CharacterMin to its protobuf representation.
func (c *CharacterMin) ToProto() *pb.CharacterMin {
	if c == nil {
		return nil
	}
	return &pb.CharacterMin{
		Id:    c.ID,
		Name:  c.Name.ToProto(),
		Image: c.Image.ToProto(),
	}
}

// ToProto converts Character to its protobuf representation.
func (c *Character) ToProto() *pb.Character {
	if c == nil {
		return nil
	}
	res := &pb.Character{
		Id:                 &c.ID,
		Name:               c.Name.ToProto(),
		Image:              c.Image.ToProto(),
		Gender:             c.Gender,
		Age:                c.Age,
		BloodType:          c.BloodType,
		DateOfBirth:        c.DateOfBirth.ToProto(),
		Description:        c.Description,
		IsFavourite:        c.IsFavourite,
		SiteUrl:            c.SiteUrl,
		Favourites:         c.Favourites,
		IsFavouriteBlocked: c.IsFavouriteBlocked,
	}
	if c.Media != nil {
		res.Media = c.Media.ToProto()
	}
	return res
}

// ToProto converts CharacterMediaEdge to its protobuf representation.
func (e *CharacterMediaEdge) ToProto() *pb.CharacterMediaEdge {
	if e == nil {
		return nil
	}
	res := &pb.CharacterMediaEdge{
		CharacterRole: e.CharacterRole,
	}
	if e.Node != nil {
		res.Node = e.Node.ToProto()
	}
	for _, va := range e.VoiceActors {
		res.VoiceActors = append(res.VoiceActors, va.ToProto())
	}
	return res
}

// ToProto converts CharacterMediaConnection to its protobuf representation.
func (c *CharacterMediaConnection) ToProto() *pb.CharacterMediaConnection {
	if c == nil {
		return nil
	}
	res := &pb.CharacterMediaConnection{
		PageInfo: c.PageInfo.ToProto(),
	}
	for _, edge := range c.Edges {
		res.Edges = append(res.Edges, edge.ToProto())
	}
	return res
}

// ToProto converts CharacterEdge to its protobuf representation.
func (e *CharacterEdge) ToProto() *pb.CharacterEdge {
	if e == nil {
		return nil
	}
	return &pb.CharacterEdge{
		Id:   e.ID,
		Role: e.Role,
		Name: e.Name,
		Node: e.Node.ToProto(),
	}
}

// ToProto converts CharacterConnection to its protobuf representation.
func (c *CharacterConnection) ToProto() *pb.CharacterConnection {
	if c == nil {
		return nil
	}
	res := &pb.CharacterConnection{
		PageInfo: c.PageInfo.ToProto(),
	}
	for _, edge := range c.Edges {
		res.Edges = append(res.Edges, edge.ToProto())
	}
	return res
}

// CharacterName represents the names of a character
type CharacterName struct {
	Full               string   `json:"full"`
	Native             *string  `json:"native"`
	UserPreferred      *string  `json:"userPreferred"`
	Alternative        []string `json:"alternative"`
	AlternativeSpoiler []string `json:"alternativeSpoiler"`
}

// CharacterImage represents the images of a character
type CharacterImage struct {
	Large  *string `json:"large"`
	Medium *string `json:"medium"`
}

// CharacterMin represents minimal character info
type CharacterMin struct {
	ID    int32           `json:"id"`
	Name  *CharacterName  `json:"name"`
	Image *CharacterImage `json:"image"`
}

// Character represents detailed character information
type Character struct {
	ID                 int32                     `json:"id"`
	Name               *CharacterName            `json:"name"`
	Image              *CharacterImage           `json:"image"`
	Gender             *string                   `json:"gender"`
	Age                *string                   `json:"age"`
	BloodType          *string                   `json:"bloodType"`
	DateOfBirth        *FuzzyDate                `json:"dateOfBirth"`
	Description        *string                   `json:"description"`
	IsFavourite        *bool                     `json:"isFavourite"`
	SiteUrl            *string                   `json:"siteUrl"`
	Favourites         *int32                    `json:"favourites"`
	IsFavouriteBlocked *bool                     `json:"isFavouriteBlocked"`
	Media              *CharacterMediaConnection `json:"media"`
}

// CharacterMediaEdge represents a media appearance for a character
type CharacterMediaEdge struct {
	CharacterRole *string    `json:"characterRole"`
	Node          *MediaMin  `json:"node"`
	VoiceActors   []StaffMin `json:"voiceActors"`
}

// CharacterMediaConnection represents a paginated list of media appearances
type CharacterMediaConnection struct {
	Edges    []CharacterMediaEdge `json:"edges"`
	PageInfo PageInfo             `json:"pageInfo"`
}

// CharacterEdge represents a link between a media and a character
type CharacterEdge struct {
	ID   int32         `json:"id"`
	Role string        `json:"role"`
	Name string        `json:"name"`
	Node *CharacterMin `json:"node"`
}

// CharacterConnection represents a paginated list of characters
type CharacterConnection struct {
	Edges    []CharacterEdge `json:"edges"`
	PageInfo PageInfo        `json:"pageInfo"`
}

// CharacterDTO represents the root response for character details
type CharacterDTO struct {
	Character Character `json:"Character"`
}

// CharacterToggleFavouriteDTO represents the response for character favorite toggling
type CharacterToggleFavouriteDTO struct {
	ToggleFavourite struct {
		Characters struct {
			Nodes []struct {
				ID int32 `json:"id"`
			} `json:"nodes"`
		} `json:"characters"`
	} `json:"ToggleFavourite"`
}
