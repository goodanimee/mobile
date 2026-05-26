package models

import pb "goodanime-backend/proto"

// ToProto converts ReviewNode to its protobuf representation.
func (r *ReviewNode) ToProto() *pb.ReviewNode {
	if r == nil {
		return nil
	}
	return &pb.ReviewNode{
		Id:           r.Id,
		Score:        r.Score,
		Rating:       r.Rating,
		RatingAmount: r.RatingAmount,
		Summary:      r.Summary,
		UserRating:   r.mapUserRating(),
		User:         r.User.ToProto(),
		Body:         r.Body,
	}
}

func (r *ReviewNode) mapUserRating() pb.ReviewUserRating {
	switch r.UserRating {
	case "UP_VOTE":
		return pb.ReviewUserRating_REVIEW_USER_RATING_UP_VOTE
	case "DOWN_VOTE":
		return pb.ReviewUserRating_REVIEW_USER_RATING_DOWN_VOTE
	default:
		return pb.ReviewUserRating_REVIEW_USER_RATING_NO_VOTE_UNSPECIFIED
	}
}

// ToProto converts ReviewConnection to its protobuf representation.
func (c *ReviewConnection) ToProto() *pb.ReviewConnection {
	if c == nil {
		return nil
	}
	res := &pb.ReviewConnection{
		PageInfo: c.PageInfo.ToProto(),
	}
	for _, node := range c.Nodes {
		res.Nodes = append(res.Nodes, node.ToProto())
	}
	return res
}

// ReviewNode represents a review
type ReviewNode struct {
	Id           int32   `json:"id"`
	Score        int32   `json:"score"`
	Rating       int32   `json:"rating"`
	RatingAmount int32   `json:"ratingAmount"`
	Summary      string  `json:"summary"`
	UserRating   string  `json:"userRating"`
	User         *Viewer `json:"user"`
	Body         string  `json:"body"`
}

// ReviewConnection represents a paginated list of reviews
type ReviewConnection struct {
	Nodes    []ReviewNode `json:"nodes"`
	PageInfo PageInfo     `json:"pageInfo"`
}

// RateReviewDTO represents the rate review response DTO.
type RateReviewDTO struct {
	RateReview ReviewNode `json:"RateReview"`
}
