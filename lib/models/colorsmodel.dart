import 'dart:convert';

ColorApiNew colorApiNewFromJson(String str) =>
    ColorApiNew.fromJson(json.decode(str));

String colorApiNewToJson(ColorApiNew data) => json.encode(data.toJson());

class ColorApiNew {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Datum>? data;
  Support? support;

  ColorApiNew({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory ColorApiNew.fromJson(Map<String, dynamic> json) => ColorApiNew(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        support:
            json["support"] == null ? null : Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "support": support?.toJson(),
      };
}

class Datum {
  int? id;
  String? name;
  int? year;
  String? color;
  String? pantoneValue;

  Datum({
    this.id,
    this.name,
    this.year,
    this.color,
    this.pantoneValue,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        color: json["color"],
        pantoneValue: json["pantone_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year": year,
        "color": color,
        "pantone_value": pantoneValue,
      };
}

class Support {
  String? url;
  String? text;

  Support({
    this.url,
    this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
