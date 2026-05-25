package models

import pb "goodanime-backend/proto"

// ToProto converts Media to its protobuf representation.
func (m *Media) ToProto() *pb.Media {
	if m == nil {
		return nil
	}
	res := &pb.Media{
		Base:              m.MediaMin.ToProto(),
		Description:       m.Description,
		BannerImage:       m.BannerImage,
		Status:            m.Status,
		Genres:            m.Genres,
		Popularity:        m.Popularity,
		Season:            m.Season,
		SeasonYear:        m.SeasonYear,
		Type:              m.Type,
		Trailer:           m.Trailer.ToProto(),
		MediaListEntry:    m.MediaListEntry.ToProto(),
		Studios:           m.Studios.ToProto(),
		Staff:             m.Staff.ToProto(),
		NextAiringEpisode: m.NextAiringEpisode.ToProto(),
		Characters:        m.Characters.ToProto(),
		Relations:         m.Relations.ToProto(),
		Recommendations:   m.Recommendations.ToProto(),
		Stats:             m.Stats.ToProto(),
		Trends:            m.Trends.ToProto(),
		MeanScore:         m.MeanScore,
		Favourites:        m.Favourites,
		Synonyms:          m.Synonyms,
	}

	for _, tag := range m.Tags {
		res.Tags = append(res.Tags, tag.ToProto())
	}
	for _, el := range m.ExternalLinks {
		res.ExternalLinks = append(res.ExternalLinks, el.ToProto())
	}
	for _, se := range m.StreamingEpisodes {
		res.StreamingEpisodes = append(res.StreamingEpisodes, se.ToProto())
	}
	for _, mr := range m.Rankings {
		res.Rankings = append(res.Rankings, mr.ToProto())
	}

	return res
}

// Media represents the core media domain model
type Media struct {
	MediaMin
	Description       string                   `json:"description"`
	BannerImage       string                   `json:"bannerImage"`
	Status            string                   `json:"status"`
	Genres            []string                 `json:"genres"`
	Popularity        int32                    `json:"popularity"`
	Season            string                   `json:"season"`
	SeasonYear        int32                    `json:"seasonYear"`
	Type              string                   `json:"type"`
	Trailer           *Trailer                 `json:"trailer"`
	MediaListEntry    *MediaListEntry          `json:"mediaListEntry"`
	Studios           *StudioConnection        `json:"studios"`
	Tags              []MediaTag               `json:"tags"`
	ExternalLinks     []ExternalLink           `json:"externalLinks"`
	StreamingEpisodes []StreamingEpisode       `json:"streamingEpisodes"`
	Staff             StaffConnection          `json:"staff"`
	NextAiringEpisode *AiringSchedule          `json:"nextAiringEpisode"`
	Characters        CharacterConnection      `json:"characters"`
	Relations         MediaConnection          `json:"relations"`
	Recommendations   RecommendationConnection `json:"recommendations"`
	Rankings          []MediaRank              `json:"rankings"`
	Stats             MediaStats               `json:"stats"`
	Trends            MediaTrendConnection     `json:"trends"`
	MeanScore         *int32                   `json:"meanScore"`
	Favourites        *int32                   `json:"favourites"`
	Synonyms          []string                 `json:"synonyms"`
}

// MediaDTO represents the DTO for a media query
type MediaDTO struct {
	Media Media `json:"Media"`
}

// ToggleFavourite represents the response for a favourite toggle
type ToggleFavourite struct {
	Anime struct {
		Nodes []struct {
			ID          int32 `json:"id"`
			IsFavourite bool  `json:"isFavourite"`
		} `json:"nodes"`
	} `json:"anime"`
}

// ToggleFavouriteDTO represents the DTO for a favourite toggle mutation
type ToggleFavouriteDTO struct {
	ToggleFavourite ToggleFavourite `json:"ToggleFavourite"`
}
