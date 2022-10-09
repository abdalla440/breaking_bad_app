import 'package:breaking_bad_app/data/models/quote_model.dart';
import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/data/repositories/characters_repository.dart';
import 'package:breaking_bad_app/data/repositories/quote_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  final QuoteRepository quoteRepository;
  List<CharacterModel> characters = [];
  List<QuoteModel> quotes = [];
  CharactersCubit(this.charactersRepository, this.quoteRepository)
      : super(CharactersInitialState());

  List<CharacterModel> getAllCharacters() {
    emit(CharactersLoadingState());
    charactersRepository.getAllCharacters().then((value) {
      characters = value;
      emit(CharactersSuccessState(value));
    }).catchError((error) {
      print(error.toString());
      emit(CharactersFailureState());
    });
    return characters;
  }

  List<QuoteModel> getAllQuotes(String authorName) {
    emit(QuotesLoadingState());
    quoteRepository.getAllQuotes(authorName).then((value) {
      quotes = value;
      emit(QuotesSuccessState(value));
    }).catchError((error) {
      print(error.toString());
      emit(QuotesFailureState());
    });
    return quotes;
  }
}
