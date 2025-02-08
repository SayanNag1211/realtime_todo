// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends HomeEvent {}

class DeleteDataEvent extends HomeEvent {
  int index;
  BuildContext context;
  bool isUndo;
  DeleteDataEvent({
    required this.index,
    required this.context,
    this.isUndo = false,
  });

  DeleteDataEvent copyWith({
    int? index,
    BuildContext? context,
    bool? isUndo,
  }) {
    return DeleteDataEvent(
      index: index ?? this.index,
      context: context ?? this.context,
      isUndo: isUndo ?? this.isUndo,
    );
  }

  @override
  List<Object> get props => [index, context, isUndo];
}

class Backevent extends HomeEvent {}
