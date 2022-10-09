import '../data_providers/quote_provider.dart';
import 'package:breaking_bad_app/data/models/quote_model.dart';

class QuoteRepository {
  final QuotesProvider quotesProvider;

  QuoteRepository(this.quotesProvider);

  Future<List<QuoteModel>> getAllQuotes(String authorName) async {
    final List<dynamic> allQuotes =
        await quotesProvider.getAllQuotes(authorName);
    return allQuotes
        .map(
          (element) => QuoteModel.fromJson(element),
        )
        .toList();
  }
}
