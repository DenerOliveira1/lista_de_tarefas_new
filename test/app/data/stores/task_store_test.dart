import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lista_de_tarefas_new/app/data/models/models.dart';
import 'package:lista_de_tarefas_new/app/data/stores/stores.dart';
import 'package:lista_de_tarefas_new/app/data/blocs/blocs.dart';

void main() {
  group('Testa os tipos de dados das variáveis', () {
    late final TaskBloc taskBloc;
    late final TaskStore taskStore;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({});

      taskBloc = TaskBloc();
      taskStore = TaskStore(taskBloc: taskBloc);
    });

    test('Testa se o id é to tipo String?', () => expect(taskStore.id, isA<String?>()));

    test('Testa se o title é do tipo String', () => expect(taskStore.title, isA<String>()));

    test('Testa se o details é do tipo String', () => expect(taskStore.details, isA<String>()));

    test('Testa se o isDone é do tipo bool', () => expect(taskStore.isDone, isA<bool>()));
  });

  group('Verificar as variáveis na criação da Store quando não é passado nenhuma task', () {
    late final TaskBloc taskBloc;
    late final TaskStore taskStore;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({});

      taskBloc = TaskBloc();
      taskStore = TaskStore(taskBloc: taskBloc);
    });

    test('Testa se o id nullo', () => expect(taskStore.id, isNull));

    test('Testa se o title é vazio', () => expect(taskStore.title, isEmpty));

    test('Testa se o details é vazio', () => expect(taskStore.details, isEmpty));

    test('Testa se o isDone é falso', () => expect(taskStore.isDone, isFalse));
  });

  group('Verificar as variáveis na criação da Store quando é passado uma task', () {
    late final TaskBloc taskBloc;
    late final TaskStore taskStore;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({});

      taskBloc = TaskBloc();
      taskStore = TaskStore(
        taskBloc: taskBloc,
        task: TaskModel(
          id: DateTime.now().toIso8601String(),
          title: 'título',
          details: 'detalhes',
          isDone: true,
        ),
      );
    });

    test('Testa se o id não é vazio', () => expect(taskStore.id, isNotEmpty));

    test('Testa se o title não é vazio', () => expect(taskStore.title, isNotEmpty));

    test('Testa se o details não é vazio', () => expect(taskStore.details, isNotEmpty));

    test('Testa se o isDone é true', () => expect(taskStore.isDone, isTrue));
  });
}
