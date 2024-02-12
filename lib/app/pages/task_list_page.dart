import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../data/blocs/blocs.dart';
import './widgets/widgets.dart';
import './pages.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late final TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = TaskBloc();

    _taskBloc.add(GetTasks());
  }

  @override
  void dispose() {
    _taskBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Lista de tarefas'),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: _taskBloc,
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskErrorState) {
            return Center(
              child: TextButton(
                onPressed: () => _taskBloc.add(GetTasks()),
                child: const Text(
                  'Houve um erro ao executar a ação, clique aqui para recarregar a tela.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          } else {
            final list = state.tasks;

            if (list.isEmpty) {
              return const Center(
                child: Text('Nenhuma tarefa localizada, adicione algumas tarefas.'),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return TaskTileWidget(taskBloc: _taskBloc, task: list[index]);
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskEditPage(taskBloc: _taskBloc),
          ),
        ),
      ),
    );
  }
}
