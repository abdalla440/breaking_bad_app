import 'package:breaking_bad_app/helpers/dio_helper.dart';
import 'package:dio/dio.dart';

class CharactersProvider {
  /// this class is responsible of getting data from the api
  /// and return it as List<dynamic>
  CharactersProvider() {
    DioHelper.init();
  }
  Future<List<dynamic>> getAllCharacters() async {
    /// get response from api and return it's data (List<dynamic>) as result
    Response response = await DioHelper.getData(url: 'characters', query: {});
    return response.data;
  }
}