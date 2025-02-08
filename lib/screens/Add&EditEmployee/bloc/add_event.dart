// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'add_bloc.dart';

sealed class AddEvent extends Equatable {
  const AddEvent();

  @override
  List<Object> get props => [];
}

class AddDataEvent extends AddEvent {
  String name;
  AddDataEvent({
    required this.name,
  });

  AddDataEvent copyWith({
    String? name,
  }) {
    return AddDataEvent(
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [name];
}

class AllDataEvent extends AddEvent {
  DateTime? fromDate;
  DateTime? toDate;
  String role;
  bool isNotime;

  AllDataEvent({
    this.fromDate,
    this.toDate,
    this.role = '',
    this.isNotime = true,
  });

  AllDataEvent copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    String? role,
    bool? isNotime,
  }) {
    return AllDataEvent(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      role: role ?? this.role,
      isNotime: isNotime ?? this.isNotime,
    );
  }

  @override
  List<Object> get props => [fromDate ?? '', toDate ?? '', role, isNotime];
}

class FromDataEvent extends AddEvent {
  DateTime? fromDate;
  DateTime? toDate;
  bool isNotime;

  FromDataEvent({
    this.fromDate,
    this.toDate,
    this.isNotime = true,
  });

  FromDataEvent copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    bool? isNotime,
  }) {
    return FromDataEvent(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      isNotime: isNotime ?? this.isNotime,
    );
  }

  @override
  List<Object> get props => [fromDate ?? '', toDate ?? '', isNotime];
}

class RoleEvent extends AddEvent {
  String role;

  RoleEvent({
    this.role = '',
  });

  RoleEvent copyWith({
    String? role,
  }) {
    return RoleEvent(
      role: role ?? this.role,
    );
  }

  @override
  List<Object> get props => [role];
}

class ChangeFromdate extends AddEvent {
  int index;
  ChangeFromdate({
    required this.index,
  });

  ChangeFromdate copyWith({
    int? index,
  }) {
    return ChangeFromdate(
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [index];
}

class ChangeToFrodate extends AddEvent {
  bool isNotime;
  int index;
  ChangeToFrodate({
    this.isNotime = true,
    required this.index,
  });

  ChangeToFrodate copyWith({
    bool? isNotime,
    int? index,
  }) {
    return ChangeToFrodate(
      isNotime: isNotime ?? this.isNotime,
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [index, isNotime];
}

class updateDataEvent extends AddEvent {
  String id;
  String name;
  updateDataEvent({
    required this.id,
    required this.name,
  });

  updateDataEvent copyWith({
    String? id,
    String? name,
  }) {
    return updateDataEvent(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [id, name];
}

class DeletPerEvent extends AddEvent {
  String id;
  DeletPerEvent({
    required this.id,
  });

  DeletPerEvent copyWith({
    String? id,
  }) {
    return DeletPerEvent(
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [id];
}
