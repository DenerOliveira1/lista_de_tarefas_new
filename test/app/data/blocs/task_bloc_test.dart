import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lista_de_tarefas_new/app/data/models/models.dart';
import 'package:lista_de_tarefas_new/app/data/blocs/blocs.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final TaskBloc taskBloc;
  late final TaskModel task;

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});

    taskBloc = TaskBloc();
    task = TaskModel(
      id: DateTime.now().toIso8601String(),
      title: 'título',
      details: 'detalhes',
      isDone: false,
    );
  });

  group('Testa os retornos das ações', () {
    test('Verificar se ao chamar o GetTasks, se executou os states na ordem correta', () async {
      taskBloc.add(GetTasks());
      await expectLater(taskBloc.stream, emitsInOrder([isA<TaskLoadingState>(), isA<TaskLoadedState>()]));
    });

    test('Verificar se ao chamar o AddTasks se retornou o state correto', () async {
      taskBloc.add(AddTask(task: task));
      await expectLater(taskBloc.stream, emits(isA<TaskLoadedState>()));
    });

    test('Verificar se ao chamar o UpdateTask se retornou o state correto', () async {
      taskBloc.add(UpdateTask(task: task));
      await expectLater(taskBloc.stream, emits(isA<TaskLoadedState>()));
    });

    test('Verificar se ao chamar o RemoveTask se retornou o state correto', () async {
      taskBloc.add(RemoveTask(task: task));
      await expectLater(taskBloc.stream, emits(isA<TaskLoadedState>()));
    });
  });
}
