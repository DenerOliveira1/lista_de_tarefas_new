import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lista_de_tarefas_new/app/data/blocs/blocs.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final TaskBloc taskBloc;

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});

    taskBloc = TaskBloc();
  });

  group('Testar os states do bloc', () {
    test('Verificar se o status inicial do bloc é TaskInitialState', () {
      expect(taskBloc.state.runtimeType, equals(TaskInitialState));
    });

    test('Verificar se o status do bloc é TaskLoadingState', () {
      taskBloc.emit(TaskLoadingState());
      expect(taskBloc.state.runtimeType, equals(TaskLoadingState));
    });

    test('Verificar se o status do bloc é TaskLoadedState', () {
      taskBloc.emit(TaskLoadedState(tasks: []));
      expect(taskBloc.state.runtimeType, equals(TaskLoadedState));
    });

    test('Verificar se o status do bloc é TaskErrorState', () {
      taskBloc.emit(TaskErrorState(exception: ''));
      expect(taskBloc.state.runtimeType, equals(TaskErrorState));
    });
  });
}
