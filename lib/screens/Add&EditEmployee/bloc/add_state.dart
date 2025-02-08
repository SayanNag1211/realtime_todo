// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'add_bloc.dart';

enum FromDateStatus { today, nextMon, nextTues, nextWeek }

enum ToDateStatus { nodate, today }

class AddState extends Equatable {
  FromDateStatus fdstatus;
  ToDateStatus tdstatus;
  final String name;
  final String role;
  final DateTime? fromDate;
  final DateTime? toDate;
  final DateTime? seletedDate;
  bool isNotime;
  final String tempFromDate;
  final String tempToDate;

  AddState({
    this.fdstatus = FromDateStatus.today,
    this.tdstatus = ToDateStatus.nodate,
    this.name = '',
    this.role = '',
    this.fromDate,
    this.toDate,
    this.seletedDate,
    this.isNotime = true,
    this.tempFromDate = '',
    this.tempToDate = '',
  });

  AddState copyWith({
    FromDateStatus? fdstatus,
    ToDateStatus? tdstatus,
    String? name,
    String? role,
    DateTime? fromDate,
    DateTime? toDate,
    DateTime? seletedDate,
    bool? isNotime,
    String? tempFromDate,
    String? tempToDate,
  }) {
    return AddState(
      fdstatus: fdstatus ?? this.fdstatus,
      tdstatus: tdstatus ?? this.tdstatus,
      name: name ?? this.name,
      role: role ?? this.role,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      seletedDate: seletedDate ?? this.seletedDate,
      isNotime: isNotime ?? this.isNotime,
      tempFromDate: tempFromDate ?? this.tempFromDate,
      tempToDate: tempToDate ?? this.tempToDate,
    );
  }

  @override
  List<Object> get props => [
        name,
        role,
        fromDate ?? '',
        toDate ?? '',
        fdstatus,
        tdstatus,
        seletedDate ?? '',
        isNotime,
        tempFromDate,
        tempToDate,
      ];
}
