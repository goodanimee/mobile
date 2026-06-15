package models

import pb "goodanime-backend/proto"

// ToProto converts StaffName to its protobuf representation.
func (n *StaffName) ToProto() *pb.StaffName {
	if n == nil {
		return nil
	}
	return &pb.StaffName{
		Full:          n.Full,
		Native:        n.Native,
		UserPreferred: n.UserPreferred,
	}
}

// ToProto converts StaffImage to its protobuf representation.
func (i *StaffImage) ToProto() *pb.StaffImage {
	if i == nil {
		return nil
	}
	return &pb.StaffImage{
		Large:  i.Large,
		Medium: i.Medium,
	}
}

// ToProto converts StaffMin to its protobuf representation.
func (s *StaffMin) ToProto() *pb.StaffMin {
	if s == nil {
		return nil
	}
	return &pb.StaffMin{
		Id:         s.ID,
		Name:       s.Name.ToProto(),
		Image:      s.Image.ToProto(),
		LanguageV2: s.LanguageV2,
	}
}

// ToProto converts StaffEdge to its protobuf representation.
func (e *StaffEdge) ToProto() *pb.StaffEdge {
	if e == nil {
		return nil
	}
	return &pb.StaffEdge{
		Role: e.Role,
		Node: e.Node.ToProto(),
	}
}

// ToProto converts StaffConnection to its protobuf representation.
func (c *StaffConnection) ToProto() *pb.StaffConnection {
	if c == nil {
		return nil
	}
	res := &pb.StaffConnection{
		PageInfo: c.PageInfo.ToProto(),
	}
	for _, edge := range c.Edges {
		res.Edges = append(res.Edges, edge.ToProto())
	}
	return res
}

// StaffName represents the names of a staff member
type StaffName struct {
	Full          string  `json:"full"`
	Native        *string `json:"native"`
	UserPreferred *string `json:"userPreferred"`
}

// StaffImage represents the images of a staff member
type StaffImage struct {
	Large  *string `json:"large"`
	Medium *string `json:"medium"`
}

// StaffMin represents a minimal staff member
type StaffMin struct {
	ID         int32       `json:"id"`
	Name       *StaffName  `json:"name"`
	Image      *StaffImage `json:"image"`
	LanguageV2 *string     `json:"languageV2"`
}

// StaffEdge represents a link between a media and a staff member
type StaffEdge struct {
	Role string    `json:"role"`
	Node *StaffMin `json:"node"`
}

// StaffConnection represents a paginated list of staff
type StaffConnection struct {
	Edges    []StaffEdge `json:"edges"`
	PageInfo PageInfo    `json:"pageInfo"`
}

// StaffCharacterName represents the simplified name of a voiced character
type StaffCharacterName struct {
	UserPreferred *string `json:"userPreferred"`
}

// StaffCharacterImage represents the simplified image of a voiced character
type StaffCharacterImage struct {
	Large  *string `json:"large"`
	Medium *string `json:"medium"`
}

// StaffCharacter represents a simplified voiced character
type StaffCharacter struct {
	ID    int32                `json:"id"`
	Name  *StaffCharacterName  `json:"name"`
	Image *StaffCharacterImage `json:"image"`
}

// StaffCharacterMediaEdge represents the connection edge between a staff and a character/media role
type StaffCharacterMediaEdge struct {
	CharacterRole *string          `json:"characterRole"`
	Node          *MediaMin        `json:"node"`
	Characters    []StaffCharacter `json:"characters"`
}

// StaffCharacterMediaConnection represents the pagination connection for character media roles
type StaffCharacterMediaConnection struct {
	Edges    []StaffCharacterMediaEdge `json:"edges"`
	PageInfo PageInfo                  `json:"pageInfo"`
}

// StaffMediaEdge represents the connection edge for media staffed by the staff member
type StaffMediaEdge struct {
	StaffRole *string   `json:"staffRole"`
	Node      *MediaMin `json:"node"`
}

// StaffMediaConnection represents the pagination connection for staffed media
type StaffMediaConnection struct {
	Edges    []StaffMediaEdge `json:"edges"`
	PageInfo PageInfo         `json:"pageInfo"`
}

// Staff represents detailed information for a staff member
type Staff struct {
	ID                 int32                          `json:"id"`
	Name               *StaffName                     `json:"name"`
	Image              *StaffImage                    `json:"image"`
	Description        *string                        `json:"description"`
	Favourites         *int32                         `json:"favourites"`
	IsFavourite        *bool                          `json:"isFavourite"`
	Age                *int32                         `json:"age"`
	Gender             *string                        `json:"gender"`
	YearsActive        []int32                        `json:"yearsActive"`
	HomeTown           *string                        `json:"homeTown"`
	BloodType          *string                        `json:"bloodType"`
	PrimaryOccupations []string                       `json:"primaryOccupations"`
	DateOfBirth        *FuzzyDate                     `json:"dateOfBirth"`
	DateOfDeath        *FuzzyDate                     `json:"dateOfDeath"`
	Language           *string                        `json:"language"`
	CharacterMedia     *StaffCharacterMediaConnection `json:"characterMedia"`
	StaffMedia         *StaffMediaConnection          `json:"staffMedia"`
}

// StaffDTO represents the data transfer object wrapper for Staff details
type StaffDTO struct {
	Staff Staff `json:"Staff"`
}

// ToProto converts StaffCharacterName to its protobuf representation.
func (s *StaffCharacterName) ToProto() *pb.StaffCharacterName {
	if s == nil {
		return nil
	}
	return &pb.StaffCharacterName{
		UserPreferred: s.UserPreferred,
	}
}

// ToProto converts StaffCharacterImage to its protobuf representation.
func (s *StaffCharacterImage) ToProto() *pb.StaffCharacterImage {
	if s == nil {
		return nil
	}
	return &pb.StaffCharacterImage{
		Large:  s.Large,
		Medium: s.Medium,
	}
}

// ToProto converts StaffCharacter to its protobuf representation.
func (s *StaffCharacter) ToProto() *pb.StaffCharacter {
	if s == nil {
		return nil
	}
	return &pb.StaffCharacter{
		Id:    s.ID,
		Name:  s.Name.ToProto(),
		Image: s.Image.ToProto(),
	}
}

// ToProto converts StaffCharacterMediaEdge to its protobuf representation.
func (e *StaffCharacterMediaEdge) ToProto() *pb.StaffCharacterMediaEdge {
	if e == nil {
		return nil
	}
	var characters []*pb.StaffCharacter
	for _, char := range e.Characters {
		characters = append(characters, char.ToProto())
	}
	return &pb.StaffCharacterMediaEdge{
		CharacterRole: e.CharacterRole,
		Node:          e.Node.ToProto(),
		Characters:    characters,
	}
}

// ToProto converts StaffCharacterMediaConnection to its protobuf representation.
func (c *StaffCharacterMediaConnection) ToProto() *pb.StaffCharacterMediaConnection {
	if c == nil {
		return nil
	}
	var edges []*pb.StaffCharacterMediaEdge
	for _, edge := range c.Edges {
		edges = append(edges, edge.ToProto())
	}
	return &pb.StaffCharacterMediaConnection{
		Edges:    edges,
		PageInfo: c.PageInfo.ToProto(),
	}
}

// ToProto converts StaffMediaEdge to its protobuf representation.
func (e *StaffMediaEdge) ToProto() *pb.StaffMediaEdge {
	if e == nil {
		return nil
	}
	return &pb.StaffMediaEdge{
		StaffRole: e.StaffRole,
		Node:      e.Node.ToProto(),
	}
}

// ToProto converts StaffMediaConnection to its protobuf representation.
func (c *StaffMediaConnection) ToProto() *pb.StaffMediaConnection {
	if c == nil {
		return nil
	}
	var edges []*pb.StaffMediaEdge
	for _, edge := range c.Edges {
		edges = append(edges, edge.ToProto())
	}
	return &pb.StaffMediaConnection{
		Edges:    edges,
		PageInfo: c.PageInfo.ToProto(),
	}
}

// ToProto converts Staff to its protobuf representation.
func (s *Staff) ToProto() *pb.Staff {
	if s == nil {
		return nil
	}
	return &pb.Staff{
		Id:                 s.ID,
		Name:               s.Name.ToProto(),
		Image:              s.Image.ToProto(),
		Description:        s.Description,
		Favourites:         s.Favourites,
		IsFavourite:        s.IsFavourite,
		Age:                s.Age,
		Gender:             s.Gender,
		YearsActive:        s.YearsActive,
		HomeTown:           s.HomeTown,
		BloodType:          s.BloodType,
		PrimaryOccupations: s.PrimaryOccupations,
		DateOfBirth:        s.DateOfBirth.ToProto(),
		DateOfDeath:        s.DateOfDeath.ToProto(),
		Language:           s.Language,
		CharacterMedia:     s.CharacterMedia.ToProto(),
		StaffMedia:         s.StaffMedia.ToProto(),
	}
}
