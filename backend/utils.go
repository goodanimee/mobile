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
	"time"
	"unsafe"

	"goodanime-backend/models"

	"google.golang.org/protobuf/proto"
)

var httpClient = &http.Client{
	Timeout: 30 * time.Second,
}

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

	resp, err := httpClient.Do(req)
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

// executeGraphQL executes a GraphQL query and parses the response data into T.
func executeGraphQL[T any](token, query string, variables map[string]any) (*T, error) {
	respBody, err := rawGraphqlRequest(token, query, variables)
	if err != nil {
		return nil, err
	}

	var apiResp models.GraphQLResponse[T]
	if err := json.Unmarshal(respBody, &apiResp); err != nil {
		return nil, fmt.Errorf("failed to parse response: %w", err)
	}

	if len(apiResp.Errors) > 0 {
		return nil, fmt.Errorf("%s", apiResp.Errors[0].Message)
	}

	return &apiResp.Data, nil
}

// decodeRequest unmarshals a protobuf request message from C memory buffer.
func decodeRequest(reqPtr *C.uint8_t, reqLen C.int, req proto.Message) error {
	reqBytes := C.GoBytes(unsafe.Pointer(reqPtr), reqLen)
	if err := proto.Unmarshal(reqBytes, req); err != nil {
		return fmt.Errorf("failed to decode request: %w", err)
	}
	return nil
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
