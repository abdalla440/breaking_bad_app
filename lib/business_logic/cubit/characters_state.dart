import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/data/models/quote_model.dart';
import 'package:breaking_bad_app/data/repositories/characters_repository.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CharactersState {}

class CharactersInitialState extends CharactersState {}

class CharactersLoadingState extends CharactersState {}

class CharactersSuccessState extends CharactersState {
  List<CharacterModel> characterModel;

  CharactersSuccessState(this.characterModel);
}

class CharactersFailureState extends CharactersState {}

class QuotesLoadingState extends CharactersState {}

class QuotesSuccessState extends CharactersState {
  List<QuoteModel> quoteModel;

  QuotesSuccessState(this.quoteModel);
}

class QuotesFailureState extends CharactersState {}
