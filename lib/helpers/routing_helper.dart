import 'package:breaking_bad_app/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad_app/data/data_providers/characters_provider.dart';
import 'package:breaking_bad_app/data/data_providers/quote_provider.dart';
import 'package:breaking_bad_app/data/models/character_model.dart';
import 'package:breaking_bad_app/data/repositories/characters_repository.dart';
import 'package:breaking_bad_app/data/repositories/quote_repository.dart';
import 'package:breaking_bad_app/presentation/screens/character_details_screen.dart';
import 'package:breaking_bad_app/presentation/screens/home_screen.dart';
import 'package:breaking_bad_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late QuoteRepository quoteRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersProvider());
    quoteRepository = QuoteRepository(QuotesProvider());
    charactersCubit = CharactersCubit(charactersRepository, quoteRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => charactersCubit,
            child: HomeScreen(),
          ),
        );

      case characterDetails:
        final selectedCharacter = settings.arguments as CharacterModel;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                CharactersCubit(charactersRepository, quoteRepository),
            child: CharacterDetailsScreen(selectedCharacter: selectedCharacter),
          ),
        );
    }
  }
}
