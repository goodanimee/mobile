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

	pb "goodanime-backend/proto"

	"google.golang.org/protobuf/proto"
)

// rawGraphqlRequest sends GraphQL query and returns raw body
func rawGraphqlRequest(token, query string, variables map[string]interface{}) ([]byte, error) {
	q := GraphQLQuery{Query: query, Variables: variables}
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

// graphqlRequest sends GraphQL query or mutation to AniList
func graphqlRequest(token, query string, variables map[string]interface{}) (*AniListResponse, error) {
	respBody, err := rawGraphqlRequest(token, query, variables)
	if err != nil {
		return nil, err
	}

	var aniResp AniListResponse
	if err := json.Unmarshal(respBody, &aniResp); err != nil {
		return nil, fmt.Errorf("failed to parse response: %w", err)
	}
	if len(aniResp.Errors) > 0 {
		return nil, fmt.Errorf("anilist error: %s", aniResp.Errors[0].Message)
	}
	return &aniResp, nil
}

// fuzzyDate converts nullable fields to pb.FuzzyDate
func fuzzyDate(year, month, day *int32) *pb.FuzzyDate {
	if year == nil {
		return nil
	}
	d := &pb.FuzzyDate{Year: *year}
	if month != nil {
		d.Month = *month
	}
	if day != nil {
		d.Day = *day
	}
	return d
}

// fuzzyDateInput converts pb.FuzzyDateInput to JSON map
func fuzzyDateInput(d *pb.FuzzyDateInput) map[string]interface{} {
	m := map[string]interface{}{"year": nil, "month": nil, "day": nil}
	if d.Year != nil {
		m["year"] = *d.Year
	}
	if d.Month != nil {
		m["month"] = *d.Month
	}
	if d.Day != nil {
		m["day"] = *d.Day
	}
	return m
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
