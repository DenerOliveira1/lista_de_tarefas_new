import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:lista_de_tarefas_new/app/pages/widgets/widgets.dart';
import 'package:lista_de_tarefas_new/app/data/models/models.dart';
import 'package:lista_de_tarefas_new/app/data/blocs/blocs.dart';
import 'package:lista_de_tarefas_new/app/pages/pages.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testar o app quando não há nenhum dado salvo', () {
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
        const MaterialApp(
          home: TaskListPage(),
        ),
      );
    }

    testWidgets('Verifica se retornou a mensagem para adicionar tarefas', (widgetTester) async {
      await loadPage(widgetTester);

      taskBloc.add(GetTasks());

      await widgetTester.pumpAndSettle();

      expect(find.text('Nenhuma tarefa localizada, adicione algumas tarefas.'), findsOneWidget);
    });
  });

  group('Testar o app quando há dados salvos', () {
    late final TaskBloc taskBloc;
    List<TaskModel> list = [];

    setUpAll(() {
      list.addAll(
        [
          TaskModel(id: DateTime.now().toIso8601String(), title: 'título 1', details: 'detalhes', isDone: false),
          TaskModel(id: DateTime.now().toIso8601String(), title: 'título 2', details: 'detalhes', isDone: false),
          TaskModel(id: DateTime.now().toIso8601String(), title: 'título 3', details: 'detalhes', isDone: false),
        ],
      );

      List<String> tasksString = [];

      for (TaskModel model in list) {
        tasksString.add(model.toString());
      }

      SharedPreferences.setMockInitialValues({
        'tasks': tasksString,
      });

      taskBloc = TaskBloc();
    });

    tearDownAll(() {
      taskBloc.close();
    });

    Future<void> loadPage(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: TaskListPage(),
        ),
      );
    }

    testWidgets('Verifica se exibiu as tarefas', (widgetTester) async {
      await loadPage(widgetTester);

      /// Busco as tarefas primeiro
      taskBloc.add(GetTasks());

      await widgetTester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(TaskTileWidget), findsWidgets);
    });
  });

  group('Verificar as ações ao clicar nas tarefas', () {
    late final TaskBloc taskBloc;
    List<TaskModel> list = [];

    setUpAll(() {
      list.addAll(
        [
          TaskModel(id: DateTime.now().toIso8601String(), title: 'título 1', details: 'detalhes', isDone: false),
          TaskModel(id: DateTime.now().toIso8601String(), title: 'título 2', details: 'detalhes', isDone: false),
          TaskModel(id: DateTime.now().toIso8601String(), title: 'título 3', details: 'detalhes', isDone: false),
        ],
      );

      List<String> tasksString = [];

      for (TaskModel model in list) {
        tasksString.add(model.toString());
      }

      SharedPreferences.setMockInitialValues({
        'tasks': tasksString,
      });

      taskBloc = TaskBloc();
    });

    tearDownAll(() {
      taskBloc.close();
    });

    Future<void> loadPage(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: TaskListPage(),
        ),
      );
    }

    testWidgets('Verifica se atualizou o status da tarefa', (widgetTester) async {
      await loadPage(widgetTester);

      /// Busco as tarefas primeiro
      taskBloc.add(GetTasks());

      await widgetTester.pumpAndSettle();

      /// Localizo o primneiro checkbox
      var firstTaskCheckbox = widgetTester.widget<Checkbox>(find.byType(Checkbox).first);

      /// Valido se o valor inicial é false
      expect(firstTaskCheckbox.value, isFalse);

      final Finder checkboxFinder = find.byType(Checkbox);

      /// Aqui eu clico no checkbox
      await widgetTester.tap(checkboxFinder.first);

      await widgetTester.pumpAndSettle();

      /// Pego novamente o checkbox que foi atualizado
      firstTaskCheckbox = widgetTester.widget<Checkbox>(find.byType(Checkbox).first);

      /// Verifico se o valor agora é true
      expect(firstTaskCheckbox.value, isTrue);
    });

    testWidgets('Verifica se removeu a tarefa da lista', (widgetTester) async {
      await loadPage(widgetTester);

      /// Busco as tarefas primeiro
      taskBloc.add(GetTasks());

      await widgetTester.pumpAndSettle();

      /// Busco a tarefa pelo primeiro nome
      var firstTaskText = find.text(list[0].title);

      /// Confirmo que a tarefa existe na tela
      expect(firstTaskText, findsOneWidget);

      /// Busco as tarefas na tela
      var taskListWidget = find.byType(TaskTileWidget);

      /// Confirmo que existe 3 tarefas
      expect(taskListWidget.evaluate().length, 3);

      final Finder iconButtonFinder = find.byType(IconButton);

      /// Clico em remover a tarefa
      await widgetTester.tap(iconButtonFinder.first);

      await widgetTester.pumpAndSettle();

      /// Busco as tarefas na tela
      taskListWidget = find.byType(TaskTileWidget);

      /// Confirmo que existe 3 tarefas
      expect(taskListWidget.evaluate().length, 2);

      /// Busco a tarefa pelo primeiro nome
      firstTaskText = find.text(list[0].title);

      /// Confirmo que a tarefa não existe mais na tela
      expect(firstTaskText, findsNothing);
    });

    testWidgets('Verifica ao clicar na tarefa, se abre a tela para edição', (widgetTester) async {
      await loadPage(widgetTester);

      /// Busco as tarefas primeiro
      taskBloc.add(GetTasks());

      await widgetTester.pumpAndSettle();

      /// Verifico se a página de editar tarefa não está aberta
      expect(find.byType(TaskEditPage), findsNothing);

      final taskListTile = find.byType(ListTile);

      await widgetTester.tap(taskListTile.first);

      await widgetTester.pumpAndSettle();

      /// Verifico se a página de editar tarefa está aberta
      expect(find.byType(TaskEditPage), findsOneWidget);
    });
  });

  group('Testar a opção para adicionar tarefa', () {
    Future<void> loadPage(WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: TaskListPage(),
        ),
      );
    }

    testWidgets('Verificar se o botão de adicionar tarefa está presente na tela', (widgetTester) async {
      await loadPage(widgetTester);

      final Finder floatingActionButtonFinder = find.byType(FloatingActionButton);

      expect(floatingActionButtonFinder, findsOneWidget);
    });

    testWidgets('Verificar se ao clicar no botão de adicionar tarefa, se abre uma nova página', (widgetTester) async {
      await loadPage(widgetTester);

      /// Verifico se a página de adicionar tarefa não está aberta
      expect(find.byType(TaskEditPage), findsNothing);

      final Finder floatingActionButtonFinder = find.byType(FloatingActionButton);

      await widgetTester.tap(floatingActionButtonFinder.first);

      await widgetTester.pumpAndSettle();

      /// Verifico se a página de adicionar tarefa foi aberta
      expect(find.byType(TaskEditPage), findsOneWidget);
    });
  });
}
