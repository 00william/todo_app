import 'package:flutter_application_1/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  AddTodo(this.title);
}

class RemoveTodo extends TodoEvent {
  final String title;
  RemoveTodo(this.title);
}

class UpdateTodo extends TodoEvent {
  final String title;
  final bool completed;
  UpdateTodo(this.title, this.completed);
}

class TodoState {
  final List<TodoModel> todos;

  TodoState(this.todos);
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([])) {
    on<AddTodo>((event, emit) {
      final newTodo = List<TodoModel>.from(state.todos)
        ..add(TodoModel(index: state.todos.length, title: event.title));
      emit(TodoState(newTodo));
    });

    on<RemoveTodo>((event, emit) {
      final index = state.todos.indexWhere((todo) => todo.title == event.title);
      final newTodos = List<TodoModel>.from(state.todos)..removeAt(index);
      emit(TodoState(newTodos));
    });

    on<UpdateTodo>((event, emit) {
      final index = state.todos.indexWhere((todo) => todo.title == event.title);
      final newTodos = List<TodoModel>.from(state.todos);
      newTodos[index].status = event.completed;
      emit(TodoState(newTodos));
    });
  }
}
