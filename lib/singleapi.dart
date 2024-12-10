import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingleApi extends StatefulWidget {
  const SingleApi({super.key});

  @override
  State<SingleApi> createState() => _SingleApiState();
}

class _SingleApiState extends State<SingleApi> {
  Future<SingleApiModel?> getMethod() async {
    var link = "https://reqres.in/api/users/2";
    final respond = await http.get(Uri.parse(link));
    var res = jsonDecode(respond.body);
    var datas = SingleApiModel.fromJson(res);
    return datas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Single API"),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: getMethod(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text("error");
          } else {
            return Container(
             height: 50,
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    //radius: 200,
                    backgroundImage: NetworkImage(
                        snapshot.data!.data!.avatar.toString(),
                        scale: 50),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    snapshot.data!.data!.id.toString(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            snapshot.data!.data!.firstName.toString(),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            snapshot.data!.data!.lastName.toString(),
                          ),
                        ],
                      ),
                      Text(
                        snapshot.data!.data!.email.toString(),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

SingleApiModel singleApiModelFromJson(String str) =>
    SingleApiModel.fromJson(json.decode(str));

String singleApiModelToJson(SingleApiModel data) => json.encode(data.toJson());

class SingleApiModel {
  Data? data;
  Support? support;

  SingleApiModel({
    this.data,
    this.support,
  });

  factory SingleApiModel.fromJson(Map<String, dynamic> json) => SingleApiModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        support:
            json["support"] == null ? null : Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "support": support?.toJson(),
      };
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Data({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
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
