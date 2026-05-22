package models

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
