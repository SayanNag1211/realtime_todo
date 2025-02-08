import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:realtime_todo/model/employee_model.dart';
import 'package:realtime_todo/screens/Home/bloc/home_bloc.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final HomeBloc homeBloc;
  AddBloc(this.homeBloc) : super(AddState()) {
    on<AddDataEvent>((event, emit) => _onaddData(event, emit));
    on<FromDataEvent>((event, emit) => _onfromData(event, emit));
    on<ChangeFromdate>((event, emit) => _onChangefromData(event, emit));
    on<ChangeToFrodate>((event, emit) => _onChangeToData(event, emit));
    on<RoleEvent>((event, emit) => _onRoleData(event, emit));

    on<AllDataEvent>((event, emit) => _onAllData(event, emit));
    on<updateDataEvent>((event, emit) => _onUpdateData(event, emit));
    on<DeletPerEvent>((event, emit) => _onDeletePer(event, emit));
  }
  void _onfromData(FromDataEvent event, Emitter<AddState> emit) {
    // print("before change ${state.toDate}");
    emit(
      state.copyWith(
        // name: event.name,
        isNotime: event.isNotime,
        // role: event.role,
        fromDate: event.fromDate,
        toDate: event.toDate,
      ),
    );
    // print("after change ${state.toDate}");
  }

  void _onRoleData(RoleEvent event, Emitter<AddState> emit) {
    emit(
      state.copyWith(
        // name: event.name,
        role: event.role,
      ),
    );
  }

  void _onAllData(AllDataEvent event, Emitter<AddState> emit) {
    emit(
      state.copyWith(
        // name: event.name,
        isNotime: event.isNotime,
        role: event.role,
        toDate: event.toDate,
        fromDate: event.fromDate,
      ),
    );
  }

  void _onaddData(AddDataEvent event, Emitter<AddState> emit) async {
    final Box<Details> dataBox = await Hive.openBox<Details>('detailsBox');
    final data = Details(
      id: DateTime.now().toString(),
      name: event.name,
      role: state.role,
      fromDate: state.fromDate != null
          ? DateFormat("d MMM yyyy").format(state.fromDate!).toString()
          : DateFormat("d MMM yyyy").format(DateTime.now()).toString(),
      toDate: state.isNotime == true
          ? ""
          : (state.toDate != null
              ? DateFormat("d MMM yyyy").format(state.toDate!).toString()
              : ""),
    );
    await dataBox.add(data);
    // print(dataBox.values.toList().map((e) => e.name));
    homeBloc.add(LoadDataEvent());
    emit(
      state.copyWith(
          isNotime: true,
          name: '',
          role: '',
          fromDate: DateTime.now(),
          fdstatus: FromDateStatus.today,
          tdstatus: ToDateStatus.nodate
          // toDate: null,
          ),
    );
  }

  void _onUpdateData(updateDataEvent event, Emitter<AddState> emit) async {
    final Box<Details> dataBox = await Hive.openBox<Details>('detailsBox');

    int index =
        dataBox.values.toList().indexWhere((detail) => detail.id == event.id);

    if (index != -1) {
      final updatedData = Details(
        id: event.id,
        name: event.name,
        role: state.role,
        fromDate: state.fromDate != null
            ? DateFormat("d MMM yyyy").format(state.fromDate!).toString()
            : DateFormat("d MMM yyyy").format(DateTime.now()).toString(),
        toDate: state.isNotime == true
            ? ""
            : (state.toDate != null
                ? DateFormat("d MMM yyyy").format(state.toDate!).toString()
                : ""),
      );

      await dataBox.putAt(index, updatedData);

      homeBloc.add(LoadDataEvent());

      emit(
        state.copyWith(
            isNotime: true,
            name: '',
            role: '',
            fromDate: DateTime.now(),
            fdstatus: FromDateStatus.today,
            tdstatus: ToDateStatus.nodate
            // toDate: null,
            ),
      );
    }
  }

  void _onChangefromData(ChangeFromdate event, Emitter<AddState> emit) async {
    DateTime getNextMonday(DateTime date) {
      int daysUntilMonday = (DateTime.monday - date.weekday) % 7;
      return date
          .add(Duration(days: daysUntilMonday == 0 ? 7 : daysUntilMonday));
    }

    DateTime getNextTuesday(DateTime date) {
      int daysUntilTuesday = (DateTime.tuesday - date.weekday) % 7;
      return date
          .add(Duration(days: daysUntilTuesday == 0 ? 7 : daysUntilTuesday));
    }

    DateTime getAfterOneWeek(DateTime date) {
      return date.add(Duration(days: 7));
    }

    DateTime now = DateTime.now();
    DateTime selectedDate;

    if (event.index == 0) {
      selectedDate = now;
    } else if (event.index == 1) {
      selectedDate = getNextMonday(now);
    } else if (event.index == 2) {
      selectedDate = getNextTuesday(now);
    } else {
      selectedDate = getAfterOneWeek(now);
    }

    emit(
      state.copyWith(
        fromDate: selectedDate,
        fdstatus: event.index == 0
            ? FromDateStatus.today
            : event.index == 1
                ? FromDateStatus.nextMon
                : event.index == 3
                    ? FromDateStatus.nextWeek
                    : FromDateStatus.nextTues,
      ),
    );

    // print("New State: ${state.fromDate}");
  }

  void _onChangeToData(ChangeToFrodate event, Emitter<AddState> emit) async {
    // print("before change ${state.toDate}");
    // DateTime? nulltime;
    emit(
      state.copyWith(
        isNotime: event.index == 0 ? true : false,
        toDate: DateTime.now(),
        tdstatus: event.index == 0 ? ToDateStatus.nodate : ToDateStatus.today,
      ),
    );
    // print("after change ${state.toDate}");
  }

  void _onDeletePer(DeletPerEvent event, Emitter<AddState> emit) async {
    final Box<Details> dataBox = await Hive.openBox<Details>('detailsBox');

    int index =
        dataBox.values.toList().indexWhere((detail) => detail.id == event.id);

    if (index != -1) {
      await dataBox.deleteAt(index);
      homeBloc.add(LoadDataEvent());
    }
  }
}
