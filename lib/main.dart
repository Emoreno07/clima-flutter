import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/enviar.dart';
import 'package:untitled/historico.dart';
import 'package:untitled/telaclima.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Clima"),
          ),
          body: const Nav()),
    );
  }
}

class Nav extends StatefulWidget {
  const Nav({super.key});
  @override
  State<Nav> createState() => NavState();
}

class NavState extends State<Nav> {
  List<Widget> pages = [
    TelaClima(),
    Historico(),
    EnviarDados()
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Histórico"),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: "Enviar"),
        ],
      ),
      body: pages.elementAt(_selectedIndex),
    );
  }
}
