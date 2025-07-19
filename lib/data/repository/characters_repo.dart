import 'package:harry_potter_app/data/model/characters_model.dart';
import 'package:harry_potter_app/data/model/quote_model.dart';
import 'package:harry_potter_app/data/web_services/web_services_character.dart';

class CharactersRepository {
  final CharacterWebServices characterWebServices;

  CharactersRepository(this.characterWebServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await characterWebServices.fetchAllCharacters();
    return characters.map((element) {
      return CharacterModel.fromJson(element);
    }).toList();
  }


  Future<List<QuoteModel>> getAllQuotes() async {
    final quotes = await characterWebServices.fetchCharacterQuotes();
    return quotes.map((element) {
      return QuoteModel.fromMap(element);
    }).toList();
  }

}
