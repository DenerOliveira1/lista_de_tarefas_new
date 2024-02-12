import 'package:bloc/bloc.dart';

import '../services/services.dart';
import './blocs.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState>{
  final TaskService _taskService = TaskService();

  TaskBloc() : super(TaskInitialState()){
    on<GetTasks>(_onGetTask);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
  }

  _onGetTask(GetTasks event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoadingState());

      emit(TaskLoadedState(tasks: await _taskService.getTasks()));
    } on Exception {
      emit(TaskErrorState(exception: 'Erro ao carregar tarefas'));
    }
  }

  _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      await _taskService.addTask(task: event.task);
      emit(TaskLoadedState(tasks: await _taskService.getTasks()));
    } on Exception {
      emit(TaskErrorState(exception: 'Erro ao adicionar tarefa'));
    }
  }

  _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    try {
      await _taskService.updateTask(task: event.task);
      emit(TaskLoadedState(tasks: await _taskService.getTasks()));
    } on Exception {
      emit(TaskErrorState(exception: 'Erro ao atualizar tarefa'));
    }
  }

  _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) async {
    try {
      await _taskService.removeTask(task: event.task);
      emit(TaskLoadedState(tasks: await _taskService.getTasks()));
    } on Exception {
      emit(TaskErrorState(exception: 'Erro ao remover tarefa'));
    }
  }
}