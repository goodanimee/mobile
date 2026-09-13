import '../models/common.dart';
import '../models/media.dart';
import '../models/media_activity.dart';
import '../models/media_character.dart';
import '../models/media_recommendation.dart';
import '../models/media_review.dart';
import '../models/media_staff.dart';
import '../models/media_studio.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// API class for media-related operations
class MediaApi {
  /// Fetches full media details by using a media ID
  static Future<Media> fetchMediaDetails(
    FetchMediaDetailsRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchMediaDetails',
      request.writeToBuffer(),
      token,
    );
    final response = FetchMediaDetailsResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return Media.fromProto(response.media);
  }

  /// Fetches media characters
  /// Fetches media characters
  static Future<CharacterConnection> fetchMediaCharacters(
    FetchMediaCharactersRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchMediaCharacters',
      request.writeToBuffer(),
      token,
    );
    final response = FetchMediaCharactersResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return CharacterConnection.fromProto(response.media.characters);
  }

  /// Fetches media staff
  static Future<StaffConnection> fetchMediaStaff(
    FetchMediaStaffRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchMediaStaff',
      request.writeToBuffer(),
      token,
    );
    final response = FetchMediaStaffResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return StaffConnection.fromProto(response.media.staff);
  }

  /// Fetches media recommendations
  static Future<RecommendationConnection> fetchMediaRecommendations(
    FetchMediaRecommendationsRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchMediaRecommendations',
      request.writeToBuffer(),
      token,
    );
    final response = FetchMediaRecommendationsResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return RecommendationConnection.fromProto(response.media.recommendations);
  }

  /// Fetches media reviews
  static Future<ReviewConnection> fetchMediaReviews(
    FetchMediaReviewsRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchMediaReviews',
      request.writeToBuffer(),
      token,
    );
    final response = FetchMediaReviewsResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return ReviewConnection.fromProto(response.media.reviews);
  }

  /// Toggles the favourite status of an anime
  static Future<ToggleFavouriteAnimeResponse> toggleFavouriteAnime(
    ToggleFavouriteAnimeRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'ToggleFavouriteAnime',
      request.writeToBuffer(),
      token,
    );
    final response = ToggleFavouriteAnimeResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }

  /// Toggles the favourite status of a manga.
  static Future<ToggleFavouriteMangaResponse> toggleFavouriteManga(
    ToggleFavouriteMangaRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'ToggleFavouriteManga',
      request.writeToBuffer(),
      token,
    );
    final response = ToggleFavouriteMangaResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }

  /// Toggles the like status of an activity
  static Future<ToggleActivityLikeResponse> toggleActivityLike(
    ToggleActivityLikeRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'ToggleActivityLike',
      request.writeToBuffer(),
      token,
    );
    final response = ToggleActivityLikeResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }

  /// Rates a media review.
  static Future<ReviewNode> rateReview(
    RateReviewRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'RateReview',
      request.writeToBuffer(),
      token,
    );
    final response = RateReviewResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return ReviewNode.fromProto(response.review);
  }

  /// Fetches paginated recent activities for a media ID.
  static Future<ListActivityConnection> fetchMediaActivities(
    FetchMediaActivitiesRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchMediaActivities',
      request.writeToBuffer(),
      token,
    );
    final response = FetchMediaActivitiesResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return ListActivityConnection(
      pageInfo: PageInfo.fromProto(response.pageInfo),
      nodes: response.activities.map(ListActivity.fromProto).toList(),
    );
  }

  /// Fetches details of a studio by its ID.
  static Future<Studio> fetchStudioDetails(
    FetchStudioDetailsRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchStudioDetails',
      request.writeToBuffer(),
      token,
    );
    final response = FetchStudioDetailsResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return Studio.fromProto(response.studio);
  }

  /// Toggles the favourite status of a studio.
  static Future<ToggleFavouriteStudioResponse> toggleFavouriteStudio(
    ToggleFavouriteStudioRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'ToggleFavouriteStudio',
      request.writeToBuffer(),
      token,
    );
    final response = ToggleFavouriteStudioResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }

  /// Fetches details of a staff member by its ID.
  static Future<Staff> fetchStaffDetails(
    FetchStaffDetailsRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchStaffDetails',
      request.writeToBuffer(),
      token,
    );
    final response = FetchStaffDetailsResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return Staff.fromProto(response.staff);
  }

  /// Toggles the favourite status of a staff member.
  static Future<ToggleFavouriteStaffResponse> toggleFavouriteStaff(
    ToggleFavouriteStaffRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'ToggleFavouriteStaff',
      request.writeToBuffer(),
      token,
    );
    final response = ToggleFavouriteStaffResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }
}
