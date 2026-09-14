import '../models/media_character.dart';
import '../proto/api.pb.dart';
import 'ffi_core.dart';

/// API class for character-related operations
class CharacterApi {
  /// Fetches character details by using character ID
  static Future<Character> fetchCharacterDetails(
    FetchCharacterDetailsRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'FetchCharacterDetails',
      request.writeToBuffer(),
      token,
    );
    final response = FetchCharacterDetailsResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return Character.fromProto(response.character);
  }

  /// Toggles the favourite status of a character
  static Future<ToggleFavouriteCharacterResponse> toggleFavouriteCharacter(
    ToggleFavouriteCharacterRequest request,
    String token,
  ) async {
    final bytes = await FfiCore.executeProtoCall(
      'ToggleFavouriteCharacter',
      request.writeToBuffer(),
      token,
    );
    final response = ToggleFavouriteCharacterResponse.fromBuffer(bytes);
    if (response.error.isNotEmpty) throw Exception(response.error);
    return response;
  }
}
