package models

import pb "goodanime-backend/proto"

func (t *MediaTrend) ToProto() *pb.MediaTrend {
	if t == nil {
		return nil
	}
	return &pb.MediaTrend{
		AverageScore: t.AverageScore,
		Date:         t.Date,
		InProgress:   t.InProgress,
		Popularity:   t.Popularity,
	}
}

func (c *MediaTrendConnection) ToProto() *pb.MediaTrendConnection {
	if c == nil {
		return nil
	}
	res := &pb.MediaTrendConnection{}
	for _, node := range c.Nodes {
		res.Nodes = append(res.Nodes, node.ToProto())
	}
	return res
}

// MediaTrend represents a trend data point
type MediaTrend struct {
	AverageScore int32 `json:"averageScore"`
	Date         int32 `json:"date"`
	InProgress   int32 `json:"inProgress"`
	Popularity   int32 `json:"popularity"`
}

// MediaTrendConnection represents a list of trends
type MediaTrendConnection struct {
	Nodes []MediaTrend `json:"nodes"`
}
