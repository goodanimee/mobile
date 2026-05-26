package models

import pb "goodanime-backend/proto"

// ToProto converts Trailer to its protobuf representation.
func (t *Trailer) ToProto() *pb.Trailer {
	if t == nil {
		return nil
	}
	return &pb.Trailer{
		Id:        t.ID,
		Site:      t.Site,
		Thumbnail: t.Thumbnail,
	}
}

// ToProto converts MediaTag to its protobuf representation.
func (t *MediaTag) ToProto() *pb.MediaTag {
	if t == nil {
		return nil
	}
	return &pb.MediaTag{
		Id:               t.ID,
		IsGeneralSpoiler: t.IsGeneralSpoiler,
		IsMediaSpoiler:   t.IsMediaSpoiler,
		Name:             t.Name,
		Rank:             t.Rank,
	}
}

// ToProto converts ExternalLink to its protobuf representation.
func (e *ExternalLink) ToProto() *pb.ExternalLink {
	if e == nil {
		return nil
	}
	return &pb.ExternalLink{
		Language: e.Language,
		Site:     e.Site,
		Url:      e.URL,
	}
}

// ToProto converts AiringSchedule to its protobuf representation.
func (a *AiringSchedule) ToProto() *pb.AiringSchedule {
	if a == nil {
		return nil
	}
	return &pb.AiringSchedule{
		AiringAt:        a.AiringAt,
		Episode:         a.Episode,
		TimeUntilAiring: a.TimeUntilAiring,
	}
}

// ToProto converts StreamingEpisode to its protobuf representation.
func (s *StreamingEpisode) ToProto() *pb.StreamingEpisode {
	if s == nil {
		return nil
	}
	return &pb.StreamingEpisode{
		Thumbnail: s.Thumbnail,
		Title:     s.Title,
		Url:       s.URL,
	}
}

// ToProto converts MediaRank to its protobuf representation.
func (r *MediaRank) ToProto() *pb.MediaRank {
	if r == nil {
		return nil
	}
	return &pb.MediaRank{
		AllTime: r.AllTime,
		Rank:    r.Rank,
		Type:    r.Type,
		Season:  r.Season,
		Year:    r.Year,
	}
}

// ToProto converts MediaStats to its protobuf representation.
func (s *MediaStats) ToProto() *pb.MediaStats {
	if s == nil {
		return nil
	}
	res := &pb.MediaStats{}
	for _, sd := range s.ScoreDistribution {
		res.ScoreDistribution = append(res.ScoreDistribution, &pb.ScoreDistribution{
			Amount: sd.Amount,
			Score:  sd.Score,
		})
	}
	for _, sd := range s.StatusDistribution {
		res.StatusDistribution = append(res.StatusDistribution, &pb.StatusDistribution{
			Amount: sd.Amount,
			Status: sd.Status,
		})
	}
	return res
}

// Trailer represents a media trailer
type Trailer struct {
	ID        string `json:"id"`
	Site      string `json:"site"`
	Thumbnail string `json:"thumbnail"`
}

// MediaTag represents a descriptive tag for a media
type MediaTag struct {
	ID               int32  `json:"id"`
	IsGeneralSpoiler bool   `json:"isGeneralSpoiler"`
	IsMediaSpoiler   bool   `json:"isMediaSpoiler"`
	Name             string `json:"name"`
	Rank             int32  `json:"rank"`
}

// ExternalLink represents a link to an external site
type ExternalLink struct {
	Language string `json:"language"`
	Site     string `json:"site"`
	URL      string `json:"url"`
}

// AiringSchedule represents an airing episode
type AiringSchedule struct {
	AiringAt        int32 `json:"airingAt"`
	Episode         int32 `json:"episode"`
	TimeUntilAiring int32 `json:"timeUntilAiring"`
}

// StreamingEpisode represents a streaming link for an episode
type StreamingEpisode struct {
	Thumbnail string `json:"thumbnail"`
	Title     string `json:"title"`
	URL       string `json:"url"`
}

// MediaRank represents a ranking for a media
type MediaRank struct {
	AllTime bool   `json:"allTime"`
	Rank    int32  `json:"rank"`
	Type    string `json:"type"`
	Season  string `json:"season"`
	Year    int32  `json:"year"`
}

// MediaStats represents statistics for a media
type MediaStats struct {
	ScoreDistribution []struct {
		Amount int32 `json:"amount"`
		Score  int32 `json:"score"`
	} `json:"scoreDistribution"`
	StatusDistribution []struct {
		Amount int32  `json:"amount"`
		Status string `json:"status"`
	} `json:"statusDistribution"`
}
