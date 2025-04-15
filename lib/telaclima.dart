
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/clima.dart';

class TelaClima extends StatefulWidget {
  const TelaClima({super.key});

  @override
  TelaClimaState createState() => TelaClimaState();
}

class TelaClimaState extends State<TelaClima> {
  Clima clima = Clima();
  String isSucessful = "Feito Com sucesso";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> docs =
        firestore.collection("campinas").snapshots();
    docs.listen((snapshot) {
      var latestValue = snapshot.docs.first.data();
      for (var doc in snapshot.docs) {
        if (doc.data()["data"] != null) {
          if (DateTime.fromMicrosecondsSinceEpoch(doc.data()["data"].microsecondsSinceEpoch)
              .isAfter(DateTime.fromMicrosecondsSinceEpoch(latestValue["data"].microsecondsSinceEpoch))) {
          latestValue = doc.data();
          }
        }
      }
      setState(() {
        clima.temperatura = latestValue["temperatura"];
        clima.umidade = latestValue["umidade"];
        DateTime date = DateTime.fromMicrosecondsSinceEpoch(latestValue["data"].microsecondsSinceEpoch)
        ;
        clima.data = "data : ${date.day}/${date.month < 10 ? "0" : ""}${date.month}/${date.year} - ${date.hour}:${date.minute < 10 ? "0" : ""}${date.minute}";  
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          children: [
            Image.asset(
              "assets/Images/clima.png",
              width: 250,
              height: 250,
            ),
            Text("temperatura : ${clima.temperatura ?? '0'}C°"),
            Text("umidade : ${clima.umidade ?? '0'}%"),
            Text(clima.data ?? ""),

          ],
        ),
      );
  }
}
