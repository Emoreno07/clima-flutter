import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => HistoricoState();
}

class HistoricoState extends State<Historico> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
            stream: firestore.collection("campinas").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("Sem dados"));
              }
              List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    DateTime date = DateTime.fromMicrosecondsSinceEpoch(
                        data["data"].microsecondsSinceEpoch);
                    double temperatura = (data["temperatura"] ?? 0).toDouble();
                    double umidade = (data["umidade"] ?? 0).toDouble();
                    return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: ListTile(
                            title: Text(
                                "Temperatura: ${temperatura.toString()} °C"),
                            subtitle: Text(
                                "Umidade: ${umidade.toString()} %\nData: ${date.day}/${date.month}/${date.year}"),
                            leading: Icon(Icons.thermostat),
                            onTap: () {
                              // Ação ao clicar na lista
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: Colors.blue, width: 1.5))));
                  });
            }));
  }
}
