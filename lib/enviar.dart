import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnviarDados extends StatefulWidget {
  const EnviarDados({super.key});

  @override
  State<EnviarDados> createState() => _EnviarDadosState();
}

class _EnviarDadosState extends State<EnviarDados> {
  final TextEditingController temperaturaController = TextEditingController();
  final TextEditingController umidadeController = TextEditingController();
  final TextEditingController pressaoController = TextEditingController();
  final TextEditingController ventoController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendData() async {
    try {
      if (temperaturaController.text.isEmpty ||
          umidadeController.text.isEmpty ||
          pressaoController.text.isEmpty ||
          ventoController.text.isEmpty && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Preencha todos os campos"),
          duration: Duration(seconds: 2),
        ));

        return;
      }
      await firestore.collection("campinas").doc(Random().nextInt(100000000).toString()).set({
        "temperatura": double.parse(temperaturaController.text),
        "umidade": double.parse(umidadeController.text),
        "pressao": double.parse(pressaoController.text),
        "data": DateTime.now(),
        "vento": double.parse(ventoController.text),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Dados enviados com sucesso"),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Erro ao enviar dados : ${e.toString()}"),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 50,
            children: [
              Text(
                "Dados",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: temperaturaController,
                  decoration: InputDecoration(
                labelText: "Temperatura",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              )),
              TextField(
                controller: umidadeController,
                  decoration: InputDecoration(
                labelText: "Umidade",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              )),
              TextField(
                controller: pressaoController,
                  decoration: InputDecoration(
                labelText: "Pressão",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              )),
              TextField(
                controller: ventoController,
                keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                labelText: "Vento",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              )),
              ElevatedButton(onPressed: () => sendData(), child: Text("Enviar"))
            ],
          )),
    );
  }
}
