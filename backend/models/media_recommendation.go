package models

import pb "goodanime-backend/proto"

// ToProto converts Recommendation to its protobuf representation.
func (r *Recommendation) ToProto() *pb.Recommendation {
	if r == nil {
		return nil
	}
	return &pb.Recommendation{
		Rating:              r.Rating,
		MediaRecommendation: r.MediaRecommendation.ToProto(),
	}
}

// ToProto converts RecommendationEdge to its protobuf representation.
func (e *RecommendationEdge) ToProto() *pb.RecommendationEdge {
	if e == nil {
		return nil
	}
	return &pb.RecommendationEdge{
		Node: e.Node.ToProto(),
	}
}

// ToProto converts RecommendationConnection to its protobuf representation.
func (c *RecommendationConnection) ToProto() *pb.RecommendationConnection {
	if c == nil {
		return nil
	}
	res := &pb.RecommendationConnection{
		PageInfo: c.PageInfo.ToProto(),
	}
	for _, edge := range c.Edges {
		res.Edges = append(res.Edges, edge.ToProto())
	}
	return res
}

// Recommendation represents a recommended media
type Recommendation struct {
	Rating              int32     `json:"rating"`
	MediaRecommendation *MediaMin `json:"mediaRecommendation"`
}

// RecommendationEdge represents a recommendation edge
type RecommendationEdge struct {
	Node Recommendation `json:"node"`
}

// RecommendationConnection represents a paginated list of recommendations
type RecommendationConnection struct {
	Edges    []RecommendationEdge `json:"edges"`
	PageInfo PageInfo             `json:"pageInfo"`
}
