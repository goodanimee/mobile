package models

import pb "goodanime-backend/proto"

// UserStatisticsResponseDTO represents the top-level User statistics response.
type UserStatisticsResponseDTO struct {
	User struct {
		Statistics struct {
			Anime UserMediaStatisticsDTO `json:"anime"`
			Manga UserMediaStatisticsDTO `json:"manga"`
		} `json:"statistics"`
	} `json:"User"`
}

// UserMediaStatisticsDTO represents statistical buckets for Anime or Manga.
type UserMediaStatisticsDTO struct {
	Count             int32                    `json:"count"`
	MeanScore         float64                  `json:"meanScore"`
	StandardDeviation float64                  `json:"standardDeviation"`
	MinutesWatched    int32                    `json:"minutesWatched"`
	EpisodesWatched   int32                    `json:"episodesWatched"`
	ChaptersRead      int32                    `json:"chaptersRead"`
	VolumesRead       int32                    `json:"volumesRead"`
	Scores            []UserScoreStatDTO       `json:"scores"`
	Lengths           []UserLengthStatDTO      `json:"lengths"`
	Statuses          []UserStatusStatDTO      `json:"statuses"`
	Formats           []UserFormatStatDTO      `json:"formats"`
	ReleaseYears      []UserReleaseYearStatDTO `json:"releaseYears"`
}

// UserScoreStatDTO represents score bucket statistics.
type UserScoreStatDTO struct {
	Score          int32   `json:"score"`
	Count          int32   `json:"count"`
	MeanScore      float64 `json:"meanScore"`
	MinutesWatched int32   `json:"minutesWatched"`
	ChaptersRead   int32   `json:"chaptersRead"`
}

// UserLengthStatDTO represents length bucket statistics.
type UserLengthStatDTO struct {
	Length         string  `json:"length"`
	Count          int32   `json:"count"`
	MeanScore      float64 `json:"meanScore"`
	MinutesWatched int32   `json:"minutesWatched"`
	ChaptersRead   int32   `json:"chaptersRead"`
}

// UserStatusStatDTO represents list status bucket statistics.
type UserStatusStatDTO struct {
	Status         string  `json:"status"`
	Count          int32   `json:"count"`
	MeanScore      float64 `json:"meanScore"`
	MinutesWatched int32   `json:"minutesWatched"`
	ChaptersRead   int32   `json:"chaptersRead"`
}

// UserFormatStatDTO represents media format bucket statistics.
type UserFormatStatDTO struct {
	Format         string  `json:"format"`
	Count          int32   `json:"count"`
	MeanScore      float64 `json:"meanScore"`
	MinutesWatched int32   `json:"minutesWatched"`
	ChaptersRead   int32   `json:"chaptersRead"`
}

// UserReleaseYearStatDTO represents release year bucket statistics.
type UserReleaseYearStatDTO struct {
	ReleaseYear    int32   `json:"releaseYear"`
	Count          int32   `json:"count"`
	MeanScore      float64 `json:"meanScore"`
	MinutesWatched int32   `json:"minutesWatched"`
	ChaptersRead   int32   `json:"chaptersRead"`
}

// ToProto converts UserMediaStatisticsDTO to *pb.UserMediaStatistics.
func (d *UserMediaStatisticsDTO) ToProto() *pb.UserMediaStatistics {
	if d == nil {
		return nil
	}

	scores := make([]*pb.UserScoreStat, 0, len(d.Scores))
	for _, s := range d.Scores {
		scores = append(scores, &pb.UserScoreStat{
			Score:          s.Score,
			Count:          s.Count,
			MeanScore:      s.MeanScore / 10.0,
			MinutesWatched: s.MinutesWatched,
			ChaptersRead:   s.ChaptersRead,
		})
	}

	lengths := make([]*pb.UserLengthStat, 0, len(d.Lengths))
	for _, l := range d.Lengths {
		lengths = append(lengths, &pb.UserLengthStat{
			Length:         l.Length,
			Count:          l.Count,
			MeanScore:      l.MeanScore / 10.0,
			MinutesWatched: l.MinutesWatched,
			ChaptersRead:   l.ChaptersRead,
		})
	}

	statuses := make([]*pb.UserStatusStat, 0, len(d.Statuses))
	for _, st := range d.Statuses {
		statuses = append(statuses, &pb.UserStatusStat{
			Status:         st.Status,
			Count:          st.Count,
			MeanScore:      st.MeanScore / 10.0,
			MinutesWatched: st.MinutesWatched,
			ChaptersRead:   st.ChaptersRead,
		})
	}

	formats := make([]*pb.UserFormatStat, 0, len(d.Formats))
	for _, f := range d.Formats {
		formats = append(formats, &pb.UserFormatStat{
			Format:         f.Format,
			Count:          f.Count,
			MeanScore:      f.MeanScore / 10.0,
			MinutesWatched: f.MinutesWatched,
			ChaptersRead:   f.ChaptersRead,
		})
	}

	releaseYears := make([]*pb.UserReleaseYearStat, 0, len(d.ReleaseYears))
	for _, y := range d.ReleaseYears {
		releaseYears = append(releaseYears, &pb.UserReleaseYearStat{
			ReleaseYear:    y.ReleaseYear,
			Count:          y.Count,
			MeanScore:      y.MeanScore / 10.0,
			MinutesWatched: y.MinutesWatched,
			ChaptersRead:   y.ChaptersRead,
		})
	}

	return &pb.UserMediaStatistics{
		Count:             d.Count,
		MeanScore:         d.MeanScore / 10.0,
		StandardDeviation: d.StandardDeviation,
		MinutesWatched:    d.MinutesWatched,
		EpisodesWatched:   d.EpisodesWatched,
		ChaptersRead:      d.ChaptersRead,
		VolumesRead:       d.VolumesRead,
		Scores:            scores,
		Lengths:           lengths,
		Statuses:          statuses,
		Formats:           formats,
		ReleaseYears:      releaseYears,
	}
}

// ToProto converts UserStatisticsResponseDTO to *pb.UserStatistics.
func (d *UserStatisticsResponseDTO) ToProto() *pb.UserStatistics {
	if d == nil {
		return nil
	}
	return &pb.UserStatistics{
		Anime: d.User.Statistics.Anime.ToProto(),
		Manga: d.User.Statistics.Manga.ToProto(),
	}
}
