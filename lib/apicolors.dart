import 'package:apicolors/models/colorsmodel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ColorsApi extends StatefulWidget {
  const ColorsApi({Key? key}) : super(key: key);

  @override
  State<ColorsApi> createState() => _ColorsApiState();
}

class _ColorsApiState extends State<ColorsApi> {
  Future<ColorApiNew> getData() async {
    var url = "https://reqres.in/api/unknown";
    var response = await http.get(Uri.parse(url));
    var res = jsonDecode(response.body);
    final data = ColorApiNew.fromJson(res);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Api"),
        flexibleSpace: const FlexibleSpaceBar(),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: fromHex(
                    snapshot.data!.data![index].color.toString(),
                  ),
                  leading: Text(
                    snapshot.data!.data![index].id.toString(),
                  ),
                  title: Text(
                    snapshot.data!.data![index].name.toString(),
                  ),
                  subtitle: Text(
                    snapshot.data!.data![index].year.toString(),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!.data![index].pantoneValue.toString(),
                      ),
                      Text(
                        snapshot.data!.data![index].color.toString(),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.data!.length,
            );
          }
        },
      ),
    );
  }
}

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
