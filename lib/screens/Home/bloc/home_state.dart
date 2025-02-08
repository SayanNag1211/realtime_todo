// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'home_bloc.dart';

enum DataStatus { empty, notempty }

class HomeState extends Equatable {
  List<Details>? details;
  bool? isUndo;
  DataStatus status;
  HomeState({
    this.details = const [],
    this.isUndo = false,
    this.status = DataStatus.empty,
  });

  HomeState copyWith({
    List<Details>? details,
    bool? isUndo,
    DataStatus? status,
  }) {
    return HomeState(
      details: details ?? this.details,
      isUndo: isUndo ?? this.isUndo,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [details, isUndo, status];
}
