package models

import pb "goodanime-backend/proto"

// ToProto converts Studio to its protobuf representation.
func (s *Studio) ToProto() *pb.Studio {
	if s == nil {
		return nil
	}

	return &pb.Studio{
		Id:          s.ID,
		Name:        s.Name,
		IsFavourite: s.IsFavourite,
		Favourites:  s.Favourites,
		Media:       s.Media.ToProto(),
	}
}

// ToProto converts StudioMediaConnection to its protobuf representation.
func (sm *StudioMediaConnection) ToProto() *pb.StudioMediaConnection {
	if sm == nil {
		return nil
	}
	res := &pb.StudioMediaConnection{
		PageInfo: sm.PageInfo.ToProto(),
	}
	for _, node := range sm.Nodes {
		res.Nodes = append(res.Nodes, node.ToProto())
	}
	return res
}

// ToProto converts Studio to its protobuf representation.
func (s *StudioMin) ToProto() *pb.StudioMin {
	if s == nil {
		return nil
	}
	return &pb.StudioMin{
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

// StudioMin represents a minimal production studio
type StudioMin struct {
	ID   int32  `json:"id"`
	Name string `json:"name"`
}

// StudioEdge represents a link between a media and a studio
type StudioEdge struct {
	IsMain bool      `json:"isMain"`
	Node   StudioMin `json:"node"`
}

// StudioConnection represents a list of studio edges
type StudioConnection struct {
	Edges []StudioEdge `json:"edges"`
}

// Studio represents a production studio
type Studio struct {
	ID          int32                  `json:"id"`
	Name        string                 `json:"name"`
	Favourites  *int32                 `json:"favourites"`
	IsFavourite *bool                  `json:"isFavourite"`
	Media       *StudioMediaConnection `json:"media"`
}

// StudioMediaConnection represents a list of media associated with a studio
type StudioMediaConnection struct {
	PageInfo PageInfo   `json:"pageInfo"`
	Nodes    []MediaMin `json:"nodes"`
}

type StudioDTO struct {
	Studio Studio `json:"Studio"`
}

type StudioSearchDTO struct {
	Page struct {
		PageInfo PageInfo  `json:"pageInfo"`
		Studios  []*Studio `json:"studios"`
	} `json:"Page"`
}
