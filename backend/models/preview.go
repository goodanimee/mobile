package models

import (
	"encoding/json"
	"fmt"
	"strings"

	pb "goodanime-backend/proto"
)

const (
	maxPreviewBatchWeight  = 50
	maxPreviewBatchAliases = 12
)

type previewAliasSpec struct {
	alias   string
	varName string
	varDecl string
	varVal  any
	body    string
	weight  int
}

// PreviewGraphQLBatch holds a single coalesced GraphQL query and its variables.
type PreviewGraphQLBatch struct {
	Query     string
	Variables map[string]any
	Aliases   []string
}

type previewUserDTO struct {
	ID     int32  `json:"id"`
	Name   string `json:"name"`
	Avatar struct {
		Large  string `json:"large"`
		Medium string `json:"medium"`
	} `json:"avatar"`
	Statistics struct {
		Anime struct {
			Count int32 `json:"count"`
		} `json:"anime"`
		Manga struct {
			Count int32 `json:"count"`
		} `json:"manga"`
	} `json:"statistics"`
}

func (u *previewUserDTO) toProto() *pb.UserProfile {
	if u == nil || u.ID <= 0 {
		return nil
	}
	return &pb.UserProfile{
		Id:   u.ID,
		Name: u.Name,
		Avatar: &pb.UserAvatar{
			Large:  u.Avatar.Large,
			Medium: u.Avatar.Medium,
		},
		AnimeCount: u.Statistics.Anime.Count,
		MangaCount: u.Statistics.Manga.Count,
	}
}

// PreviewAliasPageDTO represents a single aliased Page result inside a bulk preview response.
type PreviewAliasPageDTO struct {
	Media      []*MediaMin       `json:"media"`
	Characters []*Character      `json:"characters"`
	Staff      []*Staff          `json:"staff"`
	Studios    []*Studio         `json:"studios"`
	Users      []*previewUserDTO `json:"users"`
}

func dedupePositiveInts(ids []int32) []int32 {
	seen := make(map[int32]struct{}, len(ids))
	out := make([]int32, 0, len(ids))
	for _, id := range ids {
		if id <= 0 {
			continue
		}
		if _, ok := seen[id]; ok {
			continue
		}
		seen[id] = struct{}{}
		out = append(out, id)
	}
	return out
}

func dedupeUsernames(names []string) []string {
	seen := make(map[string]struct{}, len(names))
	out := make([]string, 0, len(names))
	for _, raw := range names {
		trimmed := strings.TrimSpace(raw)
		if trimmed == "" {
			continue
		}
		key := strings.ToLower(trimmed)
		if _, ok := seen[key]; ok {
			continue
		}
		seen[key] = struct{}{}
		out = append(out, trimmed)
	}
	return out
}

func chunkInts(ids []int32, size int) [][]int32 {
	if len(ids) == 0 {
		return nil
	}
	var chunks [][]int32
	for start := 0; start < len(ids); start += size {
		end := start + size
		if end > len(ids) {
			end = len(ids)
		}
		chunks = append(chunks, ids[start:end])
	}
	return chunks
}

// BuildPreviewBatches constructs minimal aliased GraphQL queries for resolving entity previews.
func BuildPreviewBatches(req *pb.ResolveAnilistPreviewsRequest) []PreviewGraphQLBatch {
	if req == nil {
		return nil
	}

	var specs []previewAliasSpec

	for idx, chunk := range chunkInts(dedupePositiveInts(req.MediaIds), maxPreviewBatchWeight) {
		alias := fmt.Sprintf("m%d", idx)
		specs = append(specs, previewAliasSpec{
			alias:   alias,
			varName: alias,
			varDecl: fmt.Sprintf("$%s: [Int]", alias),
			varVal:  chunk,
			weight:  len(chunk),
			body: fmt.Sprintf(
				`%s: Page(page: 1, perPage: %d) { media(id_in: $%s) { id type format episodes chapters averageScore coverImage { medium large extraLarge color } title { english native romaji userPreferred } } }`,
				alias, len(chunk), alias,
			),
		})
	}

	for idx, chunk := range chunkInts(dedupePositiveInts(req.CharacterIds), maxPreviewBatchWeight) {
		alias := fmt.Sprintf("c%d", idx)
		specs = append(specs, previewAliasSpec{
			alias:   alias,
			varName: alias,
			varDecl: fmt.Sprintf("$%s: [Int]", alias),
			varVal:  chunk,
			weight:  len(chunk),
			body: fmt.Sprintf(
				`%s: Page(page: 1, perPage: %d) { characters(id_in: $%s) { id favourites name { full native userPreferred } image { large medium } } }`,
				alias, len(chunk), alias,
			),
		})
	}

	for idx, chunk := range chunkInts(dedupePositiveInts(req.StaffIds), maxPreviewBatchWeight) {
		alias := fmt.Sprintf("s%d", idx)
		specs = append(specs, previewAliasSpec{
			alias:   alias,
			varName: alias,
			varDecl: fmt.Sprintf("$%s: [Int]", alias),
			varVal:  chunk,
			weight:  len(chunk),
			body: fmt.Sprintf(
				`%s: Page(page: 1, perPage: %d) { staff(id_in: $%s) { id favourites primaryOccupations name { full native userPreferred } image { large medium } } }`,
				alias, len(chunk), alias,
			),
		})
	}

	for idx, chunk := range chunkInts(dedupePositiveInts(req.StudioIds), maxPreviewBatchWeight) {
		alias := fmt.Sprintf("st%d", idx)
		specs = append(specs, previewAliasSpec{
			alias:   alias,
			varName: alias,
			varDecl: fmt.Sprintf("$%s: [Int]", alias),
			varVal:  chunk,
			weight:  len(chunk),
			body: fmt.Sprintf(
				`%s: Page(page: 1, perPage: %d) { studios(id_in: $%s) { id name favourites } }`,
				alias, len(chunk), alias,
			),
		})
	}

	for idx, uid := range dedupePositiveInts(req.UserIds) {
		alias := fmt.Sprintf("uid%d", idx)
		specs = append(specs, previewAliasSpec{
			alias:   alias,
			varName: alias,
			varDecl: fmt.Sprintf("$%s: Int", alias),
			varVal:  uid,
			weight:  2,
			body: fmt.Sprintf(
				`%s: Page(page: 1, perPage: 1) { users(id: $%s) { id name avatar { large medium } statistics { anime { count } manga { count } } } }`,
				alias, alias,
			),
		})
	}

	for idx, uname := range dedupeUsernames(req.Usernames) {
		alias := fmt.Sprintf("un%d", idx)
		specs = append(specs, previewAliasSpec{
			alias:   alias,
			varName: alias,
			varDecl: fmt.Sprintf("$%s: String", alias),
			varVal:  uname,
			weight:  2,
			body: fmt.Sprintf(
				`%s: Page(page: 1, perPage: 1) { users(name: $%s) { id name avatar { large medium } statistics { anime { count } manga { count } } } }`,
				alias, alias,
			),
		})
	}

	if len(specs) == 0 {
		return nil
	}

	var batches []PreviewGraphQLBatch
	var curSpecs []previewAliasSpec
	curWeight := 0

	flush := func() {
		if len(curSpecs) == 0 {
			return
		}
		var decls []string
		var bodies []string
		var aliases []string
		vars := make(map[string]any, len(curSpecs))
		for _, sp := range curSpecs {
			decls = append(decls, sp.varDecl)
			bodies = append(bodies, "  "+sp.body)
			aliases = append(aliases, sp.alias)
			vars[sp.varName] = sp.varVal
		}
		query := fmt.Sprintf(
			"query ResolveAnilistPreviews(%s) {\n%s\n}",
			strings.Join(decls, ", "),
			strings.Join(bodies, "\n"),
		)
		batches = append(batches, PreviewGraphQLBatch{
			Query:     query,
			Variables: vars,
			Aliases:   aliases,
		})
		curSpecs = nil
		curWeight = 0
	}

	for _, sp := range specs {
		if len(curSpecs) > 0 && (curWeight+sp.weight > maxPreviewBatchWeight || len(curSpecs) >= maxPreviewBatchAliases) {
			flush()
		}
		curSpecs = append(curSpecs, sp)
		curWeight += sp.weight
	}
	flush()

	return batches
}

// MergePreviewBatchData decodes aliased Page results into dst while deduplicating by entity ID.
func MergePreviewBatchData(
	aliases []string,
	pages map[string]PreviewAliasPageDTO,
	dst *pb.ResolveAnilistPreviewsResponse,
) {
	if dst == nil || len(pages) == 0 {
		return
	}

	seenMedia := make(map[int32]struct{}, len(dst.Media))
	for _, m := range dst.Media {
		seenMedia[m.Id] = struct{}{}
	}
	seenChars := make(map[int32]struct{}, len(dst.Characters))
	for _, c := range dst.Characters {
		if c.Id != nil {
			seenChars[*c.Id] = struct{}{}
		}
	}
	seenStaff := make(map[int32]struct{}, len(dst.Staff))
	for _, s := range dst.Staff {
		seenStaff[s.Id] = struct{}{}
	}
	seenStudios := make(map[int32]struct{}, len(dst.Studios))
	for _, st := range dst.Studios {
		seenStudios[st.Id] = struct{}{}
	}
	seenUsers := make(map[int32]struct{}, len(dst.Users))
	for _, u := range dst.Users {
		seenUsers[u.Id] = struct{}{}
	}

	for _, alias := range aliases {
		page, ok := pages[alias]
		if !ok {
			continue
		}
		for _, m := range page.Media {
			if m == nil || m.ID <= 0 {
				continue
			}
			if _, exists := seenMedia[m.ID]; exists {
				continue
			}
			seenMedia[m.ID] = struct{}{}
			dst.Media = append(dst.Media, m.ToProto())
		}
		for _, c := range page.Characters {
			if c == nil || c.ID <= 0 {
				continue
			}
			if _, exists := seenChars[c.ID]; exists {
				continue
			}
			seenChars[c.ID] = struct{}{}
			dst.Characters = append(dst.Characters, c.ToProto())
		}
		for _, s := range page.Staff {
			if s == nil || s.ID <= 0 {
				continue
			}
			if _, exists := seenStaff[s.ID]; exists {
				continue
			}
			seenStaff[s.ID] = struct{}{}
			dst.Staff = append(dst.Staff, s.ToProto())
		}
		for _, st := range page.Studios {
			if st == nil || st.ID <= 0 {
				continue
			}
			if _, exists := seenStudios[st.ID]; exists {
				continue
			}
			seenStudios[st.ID] = struct{}{}
			dst.Studios = append(dst.Studios, st.ToProto())
		}
		for _, u := range page.Users {
			protoUser := u.toProto()
			if protoUser == nil {
				continue
			}
			if _, exists := seenUsers[protoUser.Id]; exists {
				continue
			}
			seenUsers[protoUser.Id] = struct{}{}
			dst.Users = append(dst.Users, protoUser)
		}
	}
}

// DecodePreviewBatchJSON unmarshals a raw GraphQL data payload into a map of aliased pages.
func DecodePreviewBatchJSON(raw json.RawMessage) (map[string]PreviewAliasPageDTO, error) {
	var pages map[string]PreviewAliasPageDTO
	if err := json.Unmarshal(raw, &pages); err != nil {
		return nil, err
	}
	return pages, nil
}
