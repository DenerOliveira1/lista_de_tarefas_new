// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on TaskStoreBase, Store {
  Computed<String?>? _$titleErrorComputed;

  @override
  String? get titleError =>
      (_$titleErrorComputed ??= Computed<String?>(() => super.titleError,
              name: 'TaskStoreBase.titleError'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: 'TaskStoreBase.isFormValid'))
          .value;
  Computed<VoidCallback?>? _$editPressedComputed;

  @override
  VoidCallback? get editPressed => (_$editPressedComputed ??=
          Computed<VoidCallback?>(() => super.editPressed,
              name: 'TaskStoreBase.editPressed'))
      .value;

  late final _$idAtom = Atom(name: 'TaskStoreBase.id', context: context);

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$titleAtom = Atom(name: 'TaskStoreBase.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$detailsAtom =
      Atom(name: 'TaskStoreBase.details', context: context);

  @override
  String get details {
    _$detailsAtom.reportRead();
    return super.details;
  }

  @override
  set details(String value) {
    _$detailsAtom.reportWrite(value, super.details, () {
      super.details = value;
    });
  }

  late final _$isDoneAtom =
      Atom(name: 'TaskStoreBase.isDone', context: context);

  @override
  bool get isDone {
    _$isDoneAtom.reportRead();
    return super.isDone;
  }

  @override
  set isDone(bool value) {
    _$isDoneAtom.reportWrite(value, super.isDone, () {
      super.isDone = value;
    });
  }

  late final _$_editAsyncAction =
      AsyncAction('TaskStoreBase._edit', context: context);

  @override
  Future<void> _edit() {
    return _$_editAsyncAction.run(() => super._edit());
  }

  late final _$TaskStoreBaseActionController =
      ActionController(name: 'TaskStoreBase', context: context);

  @override
  void setTitle(String value) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDetails(String value) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.setDetails');
    try {
      return super.setDetails(value);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsDone(bool? value) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.setIsDone');
    try {
      return super.setIsDone(value);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
title: ${title},
details: ${details},
isDone: ${isDone},
titleError: ${titleError},
isFormValid: ${isFormValid},
editPressed: ${editPressed}
    ''';
  }
}
