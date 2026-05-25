package main

/*
#include <stdlib.h>
#include <stdint.h>
*/
import "C"

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"goodanime-backend/models"

	"google.golang.org/protobuf/proto"
)

// rawGraphqlRequest sends GraphQL query and returns raw body
func rawGraphqlRequest(token, query string, variables map[string]any) ([]byte, error) {
	q := models.GraphQLQuery{Query: query, Variables: variables}
	body, err := json.Marshal(q)
	if err != nil {
		return nil, fmt.Errorf("failed to marshal request: %w", err)
	}

	req, err := http.NewRequest("POST", "https://graphql.anilist.co", bytes.NewBuffer(body))
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")
	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}

	resp, err := (&http.Client{}).Do(req)
	if err != nil {
		return nil, fmt.Errorf("request failed: %w", err)
	}
	defer resp.Body.Close()

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response: %w", err)
	}

	return respBody, nil
}

// marshalAndReturn marshals protobuf message to C buffer
func marshalAndReturn(msg proto.Message, outLen *C.int) *C.uint8_t {
	data, err := proto.Marshal(msg)
	if err != nil {
		*outLen = 0
		return nil
	}
	*outLen = C.int(len(data))
	return (*C.uint8_t)(C.CBytes(data))
}
