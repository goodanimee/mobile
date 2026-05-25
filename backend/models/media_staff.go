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

// ToProto converts Staff to its protobuf representation.
func (s *Staff) ToProto() *pb.Staff {
	if s == nil {
		return nil
	}
	return &pb.Staff{
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

// Staff represents a staff member
type Staff struct {
	Name       *StaffName  `json:"name"`
	Image      *StaffImage `json:"image"`
	LanguageV2 *string     `json:"languageV2"`
}

// StaffEdge represents a link between a media and a staff member
type StaffEdge struct {
	Role string `json:"role"`
	Node *Staff `json:"node"`
}

// StaffConnection represents a paginated list of staff
type StaffConnection struct {
	Edges    []StaffEdge `json:"edges"`
	PageInfo PageInfo    `json:"pageInfo"`
}
