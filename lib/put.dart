import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Put extends StatefulWidget {
  final String id;
  final double temperatura;
  final double umidade;
  final double pressao;
  final String vento;
  const Put({
    super.key,
    required this.id,
    required this.temperatura,
    required this.umidade,
    required this.pressao,
    required this.vento,
  });
  @override
  State<Put> createState() => _PutState();
}

class _PutState extends State<Put> {
  final TextEditingController temperaturaController = TextEditingController();
  final TextEditingController umidadeController = TextEditingController();
  final TextEditingController pressaoController = TextEditingController();
  final TextEditingController ventoController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    temperaturaController.text = widget.temperatura.toString();
    umidadeController.text = widget.umidade.toString();
    pressaoController.text = widget.pressao.toString();
    ventoController.text = widget.vento.toString();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Atualizar dados"),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 50,
            children: [
              TextField(
                controller: temperaturaController,
                decoration: InputDecoration(labelText: "Temperatura",border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),),
              ),
              TextField(
                controller: umidadeController,
                decoration:  InputDecoration(labelText: "Umidade",border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),),
              ),
              TextField(
                controller: pressaoController,
                decoration: InputDecoration(labelText: "Pressão",border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),),
                
              ),
              TextField(
                controller: ventoController,
                decoration: InputDecoration(labelText: "Vento",border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await firestore.collection("campinas").doc(widget.id).update({
                      "temperatura": double.parse(temperaturaController.text),
                      "umidade": double.parse(umidadeController.text),
                      "pressao": double.parse(pressaoController.text),
                      "vento": double.parse(ventoController.text),
                    });
                    if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Dados atualizados com sucesso"),
                      duration: Duration(seconds: 2),
                    ));
                      Navigator.pop(context);
                    }
                    
                    
                  },
                  child: Text("Atualizar dados")),
            ],
          ),
        ),
      ),
    );
  }
}