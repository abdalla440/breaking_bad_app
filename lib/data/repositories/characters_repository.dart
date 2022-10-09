import 'package:breaking_bad_app/data/data_providers/characters_provider.dart';
import 'package:breaking_bad_app/data/models/character_model.dart';

class CharactersRepository {
  final CharactersProvider dataProvider;
  CharactersRepository(this.dataProvider);

  Future<List<CharacterModel>> getAllCharacters() async {
    final charactersList = await dataProvider.getAllCharacters();
    return charactersList
        .map((element) => CharacterModel.fromJson(element))
        .toList();
  }
}
