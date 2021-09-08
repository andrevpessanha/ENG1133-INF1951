// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditStore on _EditStore, Store {
  Computed<bool> _$nameValidComputed;

  @override
  bool get nameValid => (_$nameValidComputed ??=
          Computed<bool>(() => super.nameValid, name: '_EditStore.nameValid'))
      .value;
  Computed<bool> _$passValidComputed;

  @override
  bool get passValid => (_$passValidComputed ??=
          Computed<bool>(() => super.passValid, name: '_EditStore.passValid'))
      .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_EditStore.isFormValid'))
          .value;
  Computed<VoidCallback> _$savePressedComputed;

  @override
  VoidCallback get savePressed =>
      (_$savePressedComputed ??= Computed<VoidCallback>(() => super.savePressed,
              name: '_EditStore.savePressed'))
          .value;

  final _$userPhotoAtom = Atom(name: '_EditStore.userPhoto');

  @override
  File get userPhoto {
    _$userPhotoAtom.reportRead();
    return super.userPhoto;
  }

  @override
  set userPhoto(File value) {
    _$userPhotoAtom.reportWrite(value, super.userPhoto, () {
      super.userPhoto = value;
    });
  }

  final _$nameAtom = Atom(name: '_EditStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$pass1Atom = Atom(name: '_EditStore.pass1');

  @override
  String get pass1 {
    _$pass1Atom.reportRead();
    return super.pass1;
  }

  @override
  set pass1(String value) {
    _$pass1Atom.reportWrite(value, super.pass1, () {
      super.pass1 = value;
    });
  }

  final _$pass2Atom = Atom(name: '_EditStore.pass2');

  @override
  String get pass2 {
    _$pass2Atom.reportRead();
    return super.pass2;
  }

  @override
  set pass2(String value) {
    _$pass2Atom.reportWrite(value, super.pass2, () {
      super.pass2 = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EditStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$_saveAsyncAction = AsyncAction('_EditStore._save');

  @override
  Future<void> _save() {
    return _$_saveAsyncAction.run(() => super._save());
  }

  final _$_EditStoreActionController = ActionController(name: '_EditStore');

  @override
  void setPhoto(dynamic image) {
    final _$actionInfo =
        _$_EditStoreActionController.startAction(name: '_EditStore.setPhoto');
    try {
      return super.setPhoto(image);
    } finally {
      _$_EditStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo =
        _$_EditStoreActionController.startAction(name: '_EditStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_EditStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass1(String value) {
    final _$actionInfo =
        _$_EditStoreActionController.startAction(name: '_EditStore.setPass1');
    try {
      return super.setPass1(value);
    } finally {
      _$_EditStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass2(String value) {
    final _$actionInfo =
        _$_EditStoreActionController.startAction(name: '_EditStore.setPass2');
    try {
      return super.setPass2(value);
    } finally {
      _$_EditStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userPhoto: ${userPhoto},
name: ${name},
pass1: ${pass1},
pass2: ${pass2},
loading: ${loading},
nameValid: ${nameValid},
passValid: ${passValid},
isFormValid: ${isFormValid},
savePressed: ${savePressed}
    ''';
  }
}
