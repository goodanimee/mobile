package models

import pb "goodanime-backend/proto"

// ToProto converts Studio to its protobuf representation.
func (s *Studio) ToProto() *pb.Studio {
	if s == nil {
		return nil
	}
	return &pb.Studio{
		Id:   s.ID,
		Name: s.Name,
	}
}

// ToProto converts StudioEdge to its protobuf representation.
func (e *StudioEdge) ToProto() *pb.StudioEdge {
	if e == nil {
		return nil
	}
	return &pb.StudioEdge{
		IsMain: e.IsMain,
		Node:   e.Node.ToProto(),
	}
}

// ToProto converts StudioConnection to its protobuf representation.
func (c *StudioConnection) ToProto() *pb.StudioConnection {
	if c == nil {
		return nil
	}
	res := &pb.StudioConnection{}
	for _, edge := range c.Edges {
		res.Edges = append(res.Edges, edge.ToProto())
	}
	return res
}

// Studio represents a production studio
type Studio struct {
	ID   int32  `json:"id"`
	Name string `json:"name"`
}

// StudioEdge represents a link between a media and a studio
type StudioEdge struct {
	IsMain bool   `json:"isMain"`
	Node   Studio `json:"node"`
}

// StudioConnection represents a list of studio edges
type StudioConnection struct {
	Edges []StudioEdge `json:"edges"`
}
