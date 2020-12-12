import 'dart:convert';

List<QuoteModel> quoteModelFromJson(String str) => List<QuoteModel>.from(json.decode(str).map((x) => QuoteModel.fromJson(x)));

String quoteModelToJson(List<QuoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuoteModel {
    QuoteModel({
        this.text,
        this.author,
    });

    String text;
    String author;

    factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        text: json["text"],
        author: json["author"] == null ? null : json["author"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "author": author == null ? null : author,
    };
}
