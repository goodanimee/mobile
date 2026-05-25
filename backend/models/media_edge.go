package models

import pb "goodanime-backend/proto"

// ToProto converts MediaEdge to its protobuf representation.
func (e *MediaEdge) ToProto() *pb.MediaEdge {
	if e == nil {
		return nil
	}
	return &pb.MediaEdge{
		RelationType: e.RelationType,
		Node:         e.Node.ToProto(),
	}
}

// ToProto converts MediaConnection to its protobuf representation.
func (c *MediaConnection) ToProto() *pb.MediaConnection {
	if c == nil {
		return nil
	}
	res := &pb.MediaConnection{}
	for _, edge := range c.Edges {
		res.Edges = append(res.Edges, edge.ToProto())
	}
	return res
}

// MediaEdge represents a link between two media
type MediaEdge struct {
	RelationType string    `json:"relationType"`
	Node         *MediaMin `json:"node"`
}

// MediaConnection represents a paginated list of media relations
type MediaConnection struct {
	Edges []MediaEdge `json:"edges"`
}
