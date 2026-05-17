package models

// GraphQLQuery represents a GraphQL query and its variables
type GraphQLQuery struct {
	Query     string         `json:"query"`
	Variables map[string]any `json:"variables"`
}

// GraphQLError represents an error returned by the GraphQL API
type GraphQLError struct {
	Message string `json:"message"`
}

// GraphQLResponse represents a generic GraphQL response
type GraphQLResponse[T any] struct {
	Data   T              `json:"data"`
	Errors []GraphQLError `json:"errors"`
}

// FuzzyDate represents a date with optional day, month, and year
type FuzzyDate struct {
	Day   *int32 `json:"day"`
	Month *int32 `json:"month"`
	Year  *int32 `json:"year"`
}

// PageInfo contains pagination information
type PageInfo struct {
	HasNextPage bool  `json:"hasNextPage"`
	CurrentPage int32 `json:"currentPage"`
}

// MediaListStatus represents the status of a media list entry
type MediaListStatus string

const (
	MediaListStatusCurrent   MediaListStatus = "CURRENT"
	MediaListStatusPlanning  MediaListStatus = "PLANNING"
	MediaListStatusCompleted MediaListStatus = "COMPLETED"
	MediaListStatusDropped   MediaListStatus = "DROPPED"
	MediaListStatusPaused    MediaListStatus = "PAUSED"
	MediaListStatusRepeating MediaListStatus = "REPEATING"
)
