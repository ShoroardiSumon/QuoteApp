// // To parse this JSON data, do
// //
// //     final quoteDatabaseModel = quoteDatabaseModelFromJson(jsonString);

// import 'dart:convert';

// List<QuoteDatabaseModel> quoteDatabaseModelFromJson(String str) => List<QuoteDatabaseModel>.from(json.decode(str).map((x) => QuoteDatabaseModel.fromJson(x)));

// String quoteDatabaseModelToJson(List<QuoteDatabaseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class QuoteDatabaseModel {
//     QuoteDatabaseModel({
//         this.id,
//         this.data,
//     });

//     int id;
//     List<Datum> data;

//     factory QuoteDatabaseModel.fromJson(Map<String, dynamic> json) => QuoteDatabaseModel(
//         id: json["id"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class Datum {
//     Datum({
//         this.text,
//         this.author,
//     });

//     String text;
//     String author;

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         text: json["text"],
//         author: json["author"],
//     );

//     Map<String, dynamic> toJson() => {
//         "text": text,
//         "author": author,
//     };
// }


// To parse this JSON data, do
//
//     final quoteDatabaseModel = quoteDatabaseModelFromJson(jsonString);

import 'dart:convert';

List<QuoteDatabaseModel> quoteDatabaseModelFromJson(String str) => List<QuoteDatabaseModel>.from(json.decode(str).map((x) => QuoteDatabaseModel.fromJson(x)));

String quoteDatabaseModelToJson(List<QuoteDatabaseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuoteDatabaseModel {
    QuoteDatabaseModel({
        this.id,
        this.data,
    });

    String id;
    List<Datum> data;

    factory QuoteDatabaseModel.fromJson(Map<String, dynamic> json) => QuoteDatabaseModel(
        id: json["id"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.text,
        this.author,
    });

    String text;
    String author;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        text: json["text"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "author": author,
    };
}
