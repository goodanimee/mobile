package models

import pb "goodanime-backend/proto"

func (s *Studio) ToProto() *pb.Studio {
	if s == nil {
		return nil
	}
	return &pb.Studio{
		Id:   s.ID,
		Name: s.Name,
	}
}

func (e *StudioEdge) ToProto() *pb.StudioEdge {
	if e == nil {
		return nil
	}
	return &pb.StudioEdge{
		IsMain: e.IsMain,
		Node:   e.Node.ToProto(),
	}
}

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
