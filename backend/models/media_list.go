package models

import pb "goodanime-backend/proto"

func (m *MediaListEntryWithMedia) ToProto() *pb.MediaListEntryWithMedia {
	if m == nil {
		return nil
	}
	return &pb.MediaListEntryWithMedia{
		Entry: m.MediaListEntry.ToProto(),
		Media: m.Media.ToProto(),
	}
}

func (c *MediaListCollection) ToProto() *pb.MediaListCollection {
	if c == nil {
		return nil
	}
	res := &pb.MediaListCollection{
		HasNextChunk: c.HasNextChunk,
	}
	for _, g := range c.Lists {
		group := &pb.MediaListGroup{
			Name:   g.Name,
			Status: g.Status.ToProto(),
		}
		for _, e := range g.Entries {
			group.Entries = append(group.Entries, e.ToProto())
		}
		res.Lists = append(res.Lists, group)
	}
	return res
}

// MediaListEntryWithMedia extends MediaListEntry to include the minimal media object
type MediaListEntryWithMedia struct {
	MediaListEntry
	Media MediaMin `json:"media"`
}

// MediaListCollection represents a collection of media lists for a user
type MediaListCollection struct {
	HasNextChunk bool `json:"hasNextChunk"`
	Lists        []struct {
		Name    string                    `json:"name"`
		Status  *MediaListStatus          `json:"status"`
		Entries []MediaListEntryWithMedia `json:"entries"`
	} `json:"lists"`
}

// MediaListDTO represents the DTO for a media list collection query
type MediaListDTO struct {
	MediaListCollection MediaListCollection `json:"MediaListCollection"`
}
