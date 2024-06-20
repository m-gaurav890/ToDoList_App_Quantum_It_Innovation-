import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_project/note_screen.dart';
import 'package:todo_app_project/repository.dart';
import 'package:todo_app_project/block.dart';

void main() {
  final taskRepository = TaskRepository();
  runApp(MyApp(taskRepository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;

  MyApp({required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(taskRepository)..add(LoadTasks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TaskScreen(),
      ),
    );
  }
}