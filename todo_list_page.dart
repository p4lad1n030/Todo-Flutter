import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

import '../widgets/Todo_List_Item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todocontroller = TextEditingController();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todocontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Adicione uma tarefa',
                            hintText: 'Oque vamos fazer?'),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = todocontroller.text;
                        setState(() {
                          Todo newTodo = Todo(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo);
                        });
                        todocontroller.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 3, 104, 16),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(
                            fontSize: 39, fontWeight: FontWeight.w200),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas pendentes',
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    ElevatedButton(
                      onPressed: showDeletedTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 182, 33, 33),
                        padding: const EdgeInsets.all(8),
                      ),
                      child: const Text(
                        'Limpar Tudo',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso!',
          style: const TextStyle(color: Color.fromARGB(255, 243, 49, 49)),
        ),
        backgroundColor: Color.fromARGB(255, 244, 228, 110),
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color.fromARGB(255, 3, 104, 16),
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeletedTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar Tudo'),
        content:
            const Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(primary: Colors.greenAccent),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            style: TextButton.styleFrom(primary: Colors.red),
            child: const Text('Apagar Tudo'),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
