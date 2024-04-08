import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_flutter_https_request_get/models/http_provider.dart';
import 'package:provider/provider.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<HttpProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("GET - STATEFUL"),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Consumer<HttpProvider>(
                  builder: (context, value, child) => Image.network(
                    (value.data["avatar"] == null) ? "https://via.placeholder.com/150" : value.data["avatar"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Consumer<HttpProvider>(
                builder: (context, value, child) => Text(
                  (value.data["id"] == null) ? "ID : Belum ada data" : "ID : ${value.data["id"]}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const FittedBox(child: Text("Name : ", style: TextStyle(fontSize: 20))),
            FittedBox(
              child: Consumer<HttpProvider>(
                builder: (context, value, child) => Text(
                  (value.data["first_name"] == null) && (value.data["last_name"] == null) ? "Belum ada data" : value.data["first_name"] + " " + value.data["last_name"],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const FittedBox(child: Text("Email : ", style: TextStyle(fontSize: 20))),
            FittedBox(
              child: Consumer<HttpProvider>(
                builder: (context, value, child) => Text(
                  (value.data["email"] == null) ? "Belum ada data" : value.data["email"],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    dataProvider.connectAPI((1 + Random().nextInt(10)).toString(), context);
                  },
                  child: const Text(
                    "GET DATA",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    dataProvider.deleteData(context);
                  },
                  child: const Text(
                    "DELETE DATA",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}