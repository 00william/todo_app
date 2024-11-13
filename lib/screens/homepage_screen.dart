import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerText = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('ToDo List App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controllerText,
                    decoration: const InputDecoration(labelText: 'New ToDo'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    final title = controllerText.text;
                    if (title.isNotEmpty) {
                      BlocProvider.of<TodoBloc>(context).add(AddTodo(title));
                      controllerText.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
              return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      subtitle: todo.status == false
                          ? const Text('Pending', style: TextStyle(color: Colors.grey))
                          : const Text('Completed', style: TextStyle(color: Colors.green),),
                      onLongPress: () {
                        BlocProvider.of<TodoBloc>(context)
                            .add(UpdateTodo(todo.title, true));
                      },
                      onTap: () {
                        if (!todo.status) {
                          BlocProvider.of<TodoBloc>(context)
                              .add(RemoveTodo(todo.title));
                        }
                      },
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
