package models

import (
	"encoding/json"
	"testing"
)

func TestUserStatisticsDTO_ToProto(t *testing.T) {
	jsonData := `{
		"User": {
			"statistics": {
				"anime": {
					"count": 42,
					"meanScore": 81.5,
					"standardDeviation": 12.3,
					"minutesWatched": 10240,
					"episodesWatched": 450,
					"chaptersRead": 0,
					"volumesRead": 0,
					"scores": [
						{"score": 8, "count": 15, "meanScore": 80.0, "minutesWatched": 3200, "chaptersRead": 0},
						{"score": 9, "count": 10, "meanScore": 90.0, "minutesWatched": 2100, "chaptersRead": 0}
					],
					"lengths": [
						{"length": "12", "count": 20, "meanScore": 82.0, "minutesWatched": 5000, "chaptersRead": 0}
					],
					"statuses": [
						{"status": "COMPLETED", "count": 35, "meanScore": 83.0, "minutesWatched": 9000, "chaptersRead": 0}
					],
					"formats": [
						{"format": "TV", "count": 30, "meanScore": 82.5, "minutesWatched": 8500, "chaptersRead": 0}
					],
					"releaseYears": [
						{"releaseYear": 2021, "count": 12, "meanScore": 84.0, "minutesWatched": 3000, "chaptersRead": 0}
					]
				},
				"manga": {
					"count": 18,
					"meanScore": 76.2,
					"standardDeviation": 9.8,
					"minutesWatched": 0,
					"episodesWatched": 0,
					"chaptersRead": 350,
					"volumesRead": 28,
					"scores": [
						{"score": 7, "count": 8, "meanScore": 70.0, "minutesWatched": 0, "chaptersRead": 120}
					],
					"lengths": [],
					"statuses": [],
					"formats": [],
					"releaseYears": []
				}
			}
		}
	}`

	var dto UserStatisticsResponseDTO
	if err := json.Unmarshal([]byte(jsonData), &dto); err != nil {
		t.Fatalf("Failed to unmarshal JSON: %v", err)
	}

	protoStats := dto.ToProto()
	if protoStats == nil {
		t.Fatal("Expected non-nil protoStats")
	}

	if protoStats.Anime == nil {
		t.Fatal("Expected non-nil Anime stats")
	}
	if protoStats.Anime.Count != 42 {
		t.Errorf("Expected Anime.Count 42, got %d", protoStats.Anime.Count)
	}
	if protoStats.Anime.MeanScore != 81.5 {
		t.Errorf("Expected Anime.MeanScore 81.5, got %f", protoStats.Anime.MeanScore)
	}
	if protoStats.Anime.MinutesWatched != 10240 {
		t.Errorf("Expected Anime.MinutesWatched 10240, got %d", protoStats.Anime.MinutesWatched)
	}
	if len(protoStats.Anime.Scores) != 2 {
		t.Fatalf("Expected 2 scores, got %d", len(protoStats.Anime.Scores))
	}
	if protoStats.Anime.Scores[0].Score != 8 || protoStats.Anime.Scores[0].Count != 15 {
		t.Errorf("Unexpected score stat: %+v", protoStats.Anime.Scores[0])
	}
	if len(protoStats.Anime.Lengths) != 1 || protoStats.Anime.Lengths[0].Length != "12" {
		t.Errorf("Unexpected length stat: %+v", protoStats.Anime.Lengths)
	}
	if len(protoStats.Anime.Statuses) != 1 || protoStats.Anime.Statuses[0].Status != "COMPLETED" {
		t.Errorf("Unexpected status stat: %+v", protoStats.Anime.Statuses)
	}
	if len(protoStats.Anime.Formats) != 1 || protoStats.Anime.Formats[0].Format != "TV" {
		t.Errorf("Unexpected format stat: %+v", protoStats.Anime.Formats)
	}
	if len(protoStats.Anime.ReleaseYears) != 1 || protoStats.Anime.ReleaseYears[0].ReleaseYear != 2021 {
		t.Errorf("Unexpected release year stat: %+v", protoStats.Anime.ReleaseYears)
	}

	if protoStats.Manga == nil {
		t.Fatal("Expected non-nil Manga stats")
	}
	if protoStats.Manga.Count != 18 {
		t.Errorf("Expected Manga.Count 18, got %d", protoStats.Manga.Count)
	}
	if protoStats.Manga.ChaptersRead != 350 {
		t.Errorf("Expected Manga.ChaptersRead 350, got %d", protoStats.Manga.ChaptersRead)
	}
}

func TestUserStatisticsDTO_NilHandling(t *testing.T) {
	var dto *UserStatisticsResponseDTO
	if dto.ToProto() != nil {
		t.Error("Expected nil proto from nil dto")
	}

	var mediaDto *UserMediaStatisticsDTO
	if mediaDto.ToProto() != nil {
		t.Error("Expected nil proto from nil mediaDto")
	}
}
