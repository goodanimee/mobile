package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	_ "embed"

	"goodanime-backend/models"
	pb "goodanime-backend/proto"
)

//go:embed graphql/character_details.graphql
var characterDetailsQuery string

//go:embed graphql/toggle_favourite_character.graphql
var toggleFavouriteCharacterMutation string

// FetchCharacterDetails fetches details of a character by its ID.
//
//export FetchCharacterDetails
func FetchCharacterDetails(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.FetchCharacterDetailsResponse{}

	var req pb.FetchCharacterDetailsRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{
		"characterId": req.CharacterId,
		"mediaPage":   req.Page,
	}

	data, err := executeGraphQL[models.CharacterDTO](tk, characterDetailsQuery, variables)
	if err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.Character = data.Character.ToProto()
	return marshalAndReturn(pbResponse, outLen)
}

// ToggleFavouriteCharacter toggles the favourite status of a character.
//
//export ToggleFavouriteCharacter
func ToggleFavouriteCharacter(reqPtr *C.uint8_t, reqLen C.int, token *C.char, outLen *C.int) *C.uint8_t {
	tk := C.GoString(token)
	pbResponse := &pb.ToggleFavouriteCharacterResponse{}

	var req pb.ToggleFavouriteCharacterRequest
	if err := decodeRequest(reqPtr, reqLen, &req); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	variables := map[string]any{"id": req.CharacterId}

	if _, err := executeGraphQL[any](tk, toggleFavouriteCharacterMutation, variables); err != nil {
		pbResponse.Error = err.Error()
		return marshalAndReturn(pbResponse, outLen)
	}

	pbResponse.CharacterId = req.CharacterId
	return marshalAndReturn(pbResponse, outLen)
}
