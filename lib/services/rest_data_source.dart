import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quoteApp/model_classes/quote_model.dart';

class RestDataSource{
  
  List<QuoteModel> _quoteModelList;
  List<QuoteModel> quoteModelFromJson(String str) => List<QuoteModel>.from(
      json.decode(str).map((x) => QuoteModel.fromJson(x)));

  Future<List<QuoteModel>> fetchQuote() async {
    final response = await http.get('https://type.fit/api/quotes');
    _quoteModelList = quoteModelFromJson(response.body.toString());
    print(_quoteModelList.length);

    // DatabaseHelper helper = DatabaseHelper.instance;
    // for (int i = 0; i < _quoteModelList.length; i++) {
    //   QuoteDB quoteDB = QuoteDB();
    //   quoteDB.author = _quoteModelList[i].author ?? 'No Author';
    //   quoteDB.text = _quoteModelList[i].text ?? 'No Quote';
    //   int id = await helper.insertQuote(quoteDB);
    //   print('ID =====');
    //   print(id);
    // }
    return _quoteModelList;
  }
}