package main

const mediaListQuery = `
query MediaList($userId: Int, $type: MediaType, $sort: [MediaListSort]) {
    MediaListCollection(userId: $userId, type: $type, sort: $sort) {
        hasNextChunk
        lists {
            name
            status
            entries {
                media {
                    id
                    title {
                        english
                        native
                        romaji
                        userPreferred
                    }
                    averageScore
                    bannerImage
                    coverImage {
                        medium
                        large
                        extraLarge
                        color
                    }
                    description(asHtml: true)
                    duration
                    episodes
                    format
                    genres
                    isAdult
                    isFavourite
                    popularity
                    season
                    seasonYear
                    status
                    synonyms
                    meanScore
                    favourites
                    siteUrl
                    startDate {
                        day
                        month
                        year
                    }
                    endDate {
                        day
                        month
                        year
                    }
                    trailer {
                        id
                        site
                        thumbnail
                    }
                }
                progress
                repeat
                status
                score
                startedAt {
                    day
                    month
                    year
                }
                completedAt {
                    day
                    month
                    year
                }
            }
        }
    }
}
`

const viewerQuery = `
query {
    Viewer {
        id
        name
        createdAt
        avatar {
            medium
        }
    }
}
`

const saveMediaListEntryMutation = `
mutation SaveMediaListEntry(
    $mediaId: Int
    $progress: Int
    $status: MediaListStatus
    $startedAt: FuzzyDateInput
    $completedAt: FuzzyDateInput
    $score: Float
) {
    SaveMediaListEntry(
        mediaId: $mediaId
        progress: $progress
        status: $status
        startedAt: $startedAt
        completedAt: $completedAt
        score: $score
    ) {
        id
        status
        progress
        score(format: POINT_10_DECIMAL)
        repeat
        startedAt {
            day
            month
            year
        }
        completedAt {
            day
            month
            year
        }
    }
}
`

const mediaDetailsQuery = `
query Media($mediaId: Int, $notYetAired: Boolean) {
  Media(id: $mediaId) {
    id
    bannerImage
    nextAiringEpisode {
      airingAt
      episode
      timeUntilAiring
    }
    ...mediaFullFields
    airingSchedule(notYetAired: $notYetAired) {
      pageInfo { ...pageInfoFields }
      edges {
        id
        node {
          airingAt
          episode
          id
          mediaId
          timeUntilAiring
        }
      }
    }
    mediaListEntry {
      mediaId
      progress
      repeat
      score(format: POINT_10_DECIMAL)
      startedAt { ...fuzzyDateFields }
      completedAt { ...fuzzyDateFields }
      status
      private
    }
    nextAiringEpisode {
      airingAt
      episode
      timeUntilAiring
      mediaId
    }
    rankings {
      allTime
      context
      format
      id
      rank
      season
      type
      year
    }
    externalLinks {
      color
      icon
      id
      isDisabled
      language
      notes
      site
      siteId
      type
      url
    }
    studios {
      edges {
        isMain
        node {
          id
          name
          siteUrl
        }
      }
      pageInfo { ...pageInfoFields }
    }
    streamingEpisodes {
      site
      thumbnail
      title
      url
    }
    tags {
      category
      id
      isAdult
      isGeneralSpoiler
      isMediaSpoiler
      name
      rank
    }
    stats {
      scoreDistribution {
        amount
        score
      }
      statusDistribution {
        status
        amount
      }
    }
    trends {
      pageInfo { ...pageInfoFields }
      edges {
        node {
          averageScore
          episode
          inProgress
          popularity
          releasing
          trending
          date
        }
      }
    }
  }
}

fragment titleFields on MediaTitle {
  english
  native
  romaji
  userPreferred
}

fragment coverImageFields on MediaCoverImage {
  color
  extraLarge
  large
  medium
}

fragment pageInfoFields on PageInfo {
  hasNextPage
  currentPage
}

fragment fuzzyDateFields on FuzzyDate {
  day
  month
  year
}


fragment mediaFullFields on Media {
  id
  idMal
  title { ...titleFields }
  coverImage { ...coverImageFields }
  bannerImage
  description(asHtml: true)
  format
  status
  episodes
  chapters
  volumes
  duration
  season
  seasonYear
  averageScore
  meanScore
  popularity
  favourites
  source
  hashtag
  countryOfOrigin
  isAdult
  isFavourite
  isFavouriteBlocked
  isLicensed
  isLocked
  isRecommendationBlocked
  isReviewBlocked
  startDate { ...fuzzyDateFields }
  endDate { ...fuzzyDateFields }
  trailer {
    id
    site
    thumbnail
  }
  siteUrl
  trending
  type
  genres
  synonyms
}


`
const mediaStaffQuery = `
query Media($mediaId: Int, $page: Int, $perPage: Int) {
  Media(id: $mediaId) {
    id
    staff(page: $page, perPage: $perPage, sort: [RELEVANCE]) {
      pageInfo {
        currentPage
        hasNextPage
      }
      edges {
        role
        node {
          name {
            userPreferred
            full
            native
          }
          image {
            large
            medium
          }
        }
      }
    }
  }
}
`

const mediaCharactersQuery = `
query Media($mediaId: Int, $page: Int, $perPage: Int) {
  Media(id: $mediaId) {
    id
    characters(page: $page, perPage: $perPage, sort: [RELEVANCE]) {
      pageInfo {
        hasNextPage
        currentPage
      }
      edges {
        id
        role
        name
        voiceActors(sort: [RELEVANCE]) {
          image {
            large
            medium
          }
          name {
            full
          }
          languageV2
        }
        node {
          name {
            full
            native
            alternative
            alternativeSpoiler
            userPreferred
          }
          age
          gender
          dateOfBirth {
            day
            month
            year
          }
          description(asHtml: true)
          image {
            large
            medium
          }
        }
      }
    }
  }
}
`
