import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:realtime_todo/constant/colors.dart';
import 'package:realtime_todo/model/employee_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<LoadDataEvent>((event, emit) => _onLoadData(event, emit));
    on<DeleteDataEvent>(
      (event, emit) => _onDeleteData(event, emit),
    );
    on<Backevent>(
      (event, emit) => _onback(event, emit),
    );
  }
  void _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) async {
    final Box<Details> dataBox = await Hive.openBox<Details>('detailsBox');
    if (dataBox.isEmpty) {
      emit(state.copyWith(status: DataStatus.empty));
    } else {
      emit(state.copyWith(
          details: dataBox.values.toList(), status: DataStatus.notempty));
    }
  }

  void _onback(Backevent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isUndo: false));
  }

  void _onDeleteData(DeleteDataEvent event, Emitter<HomeState> emit) async {
    final Box<Details> dataBox = Hive.box<Details>('detailsBox');
    dynamic tempValue;
    tempValue = dataBox.getAt(event.index);
    add(LoadDataEvent());
    if (tempValue == null) {
      return;
    }
    dataBox.deleteAt(event.index);
    emit(state.copyWith(isUndo: true, status: DataStatus.notempty));

    ScaffoldMessenger.of(event.context).showSnackBar(
      SnackBar(
        content: Text(
          'Employee data has been deleted',
          style: TextStyle(
            color: white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        duration: Duration(seconds: 4),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            dataBox.add(tempValue);
            add(Backevent());
            add(LoadDataEvent());
          },
        ),
      ),
    );
    await Future.delayed(Duration(seconds: 4));
    add(Backevent());

    if (dataBox.isEmpty) {
      emit(state.copyWith(status: DataStatus.empty));
    }
  }
}
