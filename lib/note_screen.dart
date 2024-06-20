import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_project/add_edit_screen.dart';
import 'package:todo_app_project/block.dart';
import 'package:todo_app_project/note_model.dart';
import 'package:todo_app_project/taskSearchdelegate.dart';
class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              BlocProvider.of<TaskBloc>(context).add(LoadTasks());
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              final state = BlocProvider.of<TaskBloc>(context).state;
              if (state is TaskLoadSuccess) {
                showSearch(
                  context: context,
                  delegate: TaskSearchDelegate(state.tasks),
                );
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadSuccess) {
            List<Task> tasks = state.tasks;
            tasks.sort((a, b) => a.priority.compareTo(b.priority));

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddEditTaskScreen(task: task),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Failed to load tasks'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditTaskScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
