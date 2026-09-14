import '../api/character_api.dart';
import '../models/media_character.dart';
import '../proto/api.pb.dart';
import 'auth_service.dart';

/// Service for managing character details and favorites
class CharacterService {
  /// Fetches character details
  static Future<Character> getCharacterDetails(
    int characterId,
    int page,
  ) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = FetchCharacterDetailsRequest(
      characterId: characterId,
      page: page,
    );
    return CharacterApi.fetchCharacterDetails(req, token);
  }

  /// Toggles the favorite status of a character
  static Future<void> toggleFavouriteCharacter(int characterId) async {
    final token = await AuthService.getRawToken() ?? '';
    final req = ToggleFavouriteCharacterRequest(characterId: characterId);
    await CharacterApi.toggleFavouriteCharacter(req, token);
  }
}
