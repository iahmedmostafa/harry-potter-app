part of 'character_cubit.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

class CharacterLoaded extends CharacterState{

 final List<CharacterModel> characters;
 CharacterLoaded(this.characters);

}
class QuotesLoaded extends CharacterState{

 final List<QuoteModel> quotes;
 QuotesLoaded(this.quotes);

}