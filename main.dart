import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListPage(),
    ); //pelo q entendi o scaffold é equivalente ao html root ou seja todos os componentes da tela devem estar dentro do scaffold
  }
}

// para criar as paginas do nosso app criamos separadas da classe MyApp e é uma boa pratica crias todas as paginas separadas
// a classe esta dentro da pasta pages
