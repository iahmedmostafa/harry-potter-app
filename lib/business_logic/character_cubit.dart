import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:harry_potter_app/data/model/characters_model.dart';
import 'package:harry_potter_app/data/model/quote_model.dart';
import 'package:harry_potter_app/data/repository/characters_repo.dart';
part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharactersRepository charactersRepository;
   List<CharacterModel> characters=[];
   List<QuoteModel> quotes=[];

  CharacterCubit(this.charactersRepository) : super(CharacterInitial());

  List<CharacterModel> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharacterLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
  List<QuoteModel> getAllQuotes(){
    charactersRepository.getAllQuotes().then((quotes){
      emit(QuotesLoaded(quotes));
      this.quotes=quotes;
    });
    return quotes;


  }

}
