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

// ToProto converts Character to its protobuf representation.
func (c *Character) ToProto() *pb.Character {
	if c == nil {
		return nil
	}
	return &pb.Character{
		Name:        c.Name.ToProto(),
		Image:       c.Image.ToProto(),
		Gender:      c.Gender,
		Age:         c.Age,
		DateOfBirth: c.DateOfBirth.ToProto(),
		Description: c.Description,
	}
}

// ToProto converts CharacterEdge to its protobuf representation.
func (e *CharacterEdge) ToProto() *pb.CharacterEdge {
	if e == nil {
		return nil
	}
	res := &pb.CharacterEdge{
		Id:   e.ID,
		Role: e.Role,
		Name: e.Name,
		Node: e.Node.ToProto(),
	}
	for _, va := range e.VoiceActors {
		res.VoiceActors = append(res.VoiceActors, va.ToProto())
	}
	return res
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

// Character represents a character in a media
type Character struct {
	Name        *CharacterName  `json:"name"`
	Image       *CharacterImage `json:"image"`
	Gender      *string         `json:"gender"`
	Age         *string         `json:"age"`
	DateOfBirth *FuzzyDate      `json:"dateOfBirth"`
	Description *string         `json:"description"`
}

// CharacterEdge represents a link between a media and a character
type CharacterEdge struct {
	ID          int32      `json:"id"`
	Role        string     `json:"role"`
	Name        string     `json:"name"`
	Node        *Character `json:"node"`
	VoiceActors []StaffMin `json:"voiceActors"`
}

// CharacterConnection represents a paginated list of characters
type CharacterConnection struct {
	Edges    []CharacterEdge `json:"edges"`
	PageInfo PageInfo        `json:"pageInfo"`
}
