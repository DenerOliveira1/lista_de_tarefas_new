import 'package:flutter_test/flutter_test.dart';

import 'package:lista_de_tarefas_new/app/data/models/models.dart';

void main() {
  group('Testa os tipos de dados das variáveis', () {
    late final TaskModel task;

    setUpAll(() {
      task = TaskModel(
        id: DateTime.now().toIso8601String(),
        title: 'título',
        details: 'detalhes',
        isDone: true,
      );
    });

    test('Testa se o id é to tipo String', () => expect(task.id, isA<String>()));

    test('Testa se o title é do tipo String', () => expect(task.title, isA<String>()));

    test('Testa se o details é do tipo String', () => expect(task.details, isA<String>()));

    test('Testa se o isDone é do tipo bool', () => expect(task.isDone, isA<bool>()));
  });

  group('Testa as conversões', () {
    late final TaskModel task;

    setUpAll(() {
      task = TaskModel(
        id: DateTime.now().toIso8601String(),
        title: 'título',
        details: 'detalhes',
        isDone: true,
      );
    });

    test('Testa a conversão para o tipo String', () => expect(task.toString(), isA<String>()));

    test('Testa a conversão para o tipo Json', () => expect(task.toJson(), isA<Map<String, dynamic>>()));

    test('Testa a conversão para o tipo String e depois a criação da classe pelo método fromString', () {
      String taskString = task.toString();

      TaskModel taskModel = TaskModel.fromString(taskString);

      expect(taskModel.id, task.id);
    });
  });
}