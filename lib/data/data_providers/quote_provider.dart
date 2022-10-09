import 'package:breaking_bad_app/data/models/quote_model.dart';
import 'package:breaking_bad_app/helpers/dio_helper.dart';
import 'package:dio/dio.dart';

class QuotesProvider {
  QuotesProvider() {
    DioHelper.init();
  }
  Future<List<dynamic>> getAllQuotes(String authorName) async {
    Response response = await DioHelper.getData(
      url: 'quote',
      query: {'author': authorName},
    );

    return response.data;
  }
}
