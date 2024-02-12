import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:lista_de_tarefas_new/app/data/models/models.dart';
import 'package:lista_de_tarefas_new/app/data/blocs/blocs.dart';
import 'package:lista_de_tarefas_new/app/pages/pages.dart';

void main() {
  group('Testes para quando é feito a inclusão de uma nova tarefa', () {
    late final TaskBloc taskBloc;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({});

      taskBloc = TaskBloc();
    });

    tearDownAll(() {
      taskBloc.close();
    });

    Future<void> loadPage(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: TaskEditPage(
            taskBloc: taskBloc,
          ),
        ),
      );
    }

    testWidgets('Verifica se iniciou os campos da store de forma correta', (widgetTester) async {
      await loadPage(widgetTester);

      final TextFormField titleWidget = widgetTester.widget<TextFormField>(find.byType(TextFormField).first);

      expect(titleWidget.initialValue, '');

      final TextFormField detailsWidget = widgetTester.widget<TextFormField>(find.byType(TextFormField).at(1));

      expect(detailsWidget.initialValue, '');

      final Checkbox isDoneWidget = widgetTester.widget<Checkbox>(find.byType(Checkbox).first);

      expect(isDoneWidget.value, isFalse);

      final ElevatedButton buttonWidget = widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton).first);

      expect(buttonWidget.enabled, isFalse);
    });

    testWidgets('Verifica se após a edição do título, se o campo de save habilitou', (widgetTester) async {
      await loadPage(widgetTester);

      final Finder titleFinder = find.byType(TextFormField).first;

      await widgetTester.enterText(titleFinder, 'teste');
      await widgetTester.pumpAndSettle();

      final ElevatedButton buttonWidget = widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton).first);

      expect(buttonWidget.enabled, isTrue);
    });

    testWidgets('Verifica se após incluir e apagar um texto do título, se  o botão de salvar volta a ficar desabilitado', (widgetTester) async {
      await loadPage(widgetTester);

      final Finder titleFinder = find.byType(TextFormField).first;

      await widgetTester.enterText(titleFinder, 'teste');
      await widgetTester.pumpAndSettle();

      ElevatedButton buttonWidget = widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton).first);

      expect(buttonWidget.enabled, isTrue);

      await widgetTester.enterText(titleFinder, '');
      await widgetTester.pumpAndSettle();

      buttonWidget = widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton).first);

      expect(buttonWidget.enabled, isFalse);
    });
  });

  group('Testes para quando é feito a edição de uma nova tarefa', () {
    late final TaskBloc taskBloc;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({});

      taskBloc = TaskBloc();
    });

    tearDownAll(() {
      taskBloc.close();
    });

    Future<void> loadPage(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: TaskEditPage(
            taskBloc: taskBloc,
            task: TaskModel(
              id: DateTime.now().toIso8601String(),
              title: 'título',
              details: 'detalhes',
              isDone: true,
            ),
          ),
        ),
      );
    }

    testWidgets('Verifica se iniciou os campos da store de forma correta', (widgetTester) async {
      await loadPage(widgetTester);

      final TextFormField titleWidget = widgetTester.widget<TextFormField>(find.byType(TextFormField).first);

      expect(titleWidget.initialValue, 'título');

      final TextFormField detailsWidget = widgetTester.widget<TextFormField>(find.byType(TextFormField).at(1));

      expect(detailsWidget.initialValue, 'detalhes');

      final Checkbox isDoneWidget = widgetTester.widget<Checkbox>(find.byType(Checkbox).first);

      expect(isDoneWidget.value, isTrue);

      final ElevatedButton buttonWidget = widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton).first);

      expect(buttonWidget.enabled, isTrue);
    });

    testWidgets('Verifica se após apagar o texto do título, se o botão de salvar ficar desabilitado', (widgetTester) async {
      await loadPage(widgetTester);

      final Finder titleFinder = find.byType(TextFormField).first;

      await widgetTester.enterText(titleFinder, '');
      await widgetTester.pumpAndSettle();

      final ElevatedButton buttonWidget = widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton).first);

      expect(buttonWidget.enabled, isFalse);
    });
  });
}
