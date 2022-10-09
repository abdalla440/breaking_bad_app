
import 'package:dio/dio.dart';

import 'data/models/character_model.dart';
import 'helpers/dio_helper.dart';

void main() async {
  final CharactersProvider dataProvider = CharactersProvider();
  // List<dynamic> data = await dataProvider.getResponseData();
  // print('data in list<dynamic> form');
  // print(data);
  final CharactersRepository charactersRepository =
      CharactersRepository(dataProvider);
  List<CharacterModel> characterData =
      await charactersRepository.getCharacterListFromDataResponse();
  print('data in list<CharacterModel> form');
  print( characterData[0].img);
}

class CharactersProvider {
  /// this class is responsible of getting data from the api
  /// and return it as List<dynamic>
  CharactersProvider() {
    DioHelper.init();
  }
  Future<List<dynamic>> getResponseData() async {
    /// get response from api and return it's data (List<dynamic>) as result
    Response response = await DioHelper.getData(url: 'characters', query: {});
    return response.data;
  }
}

class CharactersRepository {
  final CharactersProvider dataProvider;
  CharactersRepository(this.dataProvider);

  Future<List<CharacterModel>> getCharacterListFromDataResponse() async {
    final charactersList = await dataProvider.getResponseData();
    return charactersList
        .map((element) => CharacterModel.fromJson(element))
        .toList();
  }
}
// class DataRepository{
//   late Response response;
//   void getCharactersFromResponse(){
//     DataProvider().getResponseData().then((value) {
//       value.data
//     });
//   }
// }
//
// class CharactersWebServices {
//   late Dio dio;
//
//   CharactersWebServices() {
//     BaseOptions options = BaseOptions(
//       baseUrl: baseUrl,
//       receiveDataWhenStatusError: true,
//       connectTimeout: 20 * 1000, // 60 seconds,
//       receiveTimeout: 20 * 1000,
//     );
//
//     dio = Dio(options);
//   }
//
//   Future<List<dynamic>> getAllCharacters() async {
//     try {
//       Response response = await dio.get('characters');
//       print(response.data.toString());
//       return response.data;
//     } catch (e) {
//       print(e.toString());
//       return [];
//     }
//   }
//
//   Future<List<dynamic>> getCharacterQuotes(String charName) async {
//     try {
//       Response response =
//           await dio.get('quote', queryParameters: {'author': charName});
//       print(response.data.toString());
//       return response.data;
//     } catch (e) {
//       print(e.toString());
//       return [];
//     }
//   }
// }
