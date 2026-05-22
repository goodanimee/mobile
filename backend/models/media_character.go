package models

// CharacterName represents the names of a character
type CharacterName struct {
	Full               string   `json:"full"`
	Native             *string  `json:"native"`
	UserPreferred      *string  `json:"userPreferred"`
	Alternative        []string `json:"alternative"`
	AlternativeSpoiler []string `json:"alternativeSpoiler"`
}

// CharacterImage represents the images of a character
type CharacterImage struct {
	Large  *string `json:"large"`
	Medium *string `json:"medium"`
}

// Character represents a character in a media
type Character struct {
	Name        *CharacterName  `json:"name"`
	Image       *CharacterImage `json:"image"`
	Gender      *string         `json:"gender"`
	Age         *string         `json:"age"`
	DateOfBirth *FuzzyDate      `json:"dateOfBirth"`
	Description *string         `json:"description"`
}

// CharacterEdge represents a link between a media and a character
type CharacterEdge struct {
	ID          int32      `json:"id"`
	Role        string     `json:"role"`
	Name        string     `json:"name"`
	Node        *Character `json:"node"`
	VoiceActors []Staff    `json:"voiceActors"`
}

// CharacterConnection represents a paginated list of characters
type CharacterConnection struct {
	Edges    []CharacterEdge `json:"edges"`
	PageInfo PageInfo        `json:"pageInfo"`
}
