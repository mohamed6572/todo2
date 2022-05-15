import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/moduls/archive_Tasks/archive_Tasks.dart';
import 'package:todo/moduls/done_Tasks/done_Tasks.dart';
import 'package:todo/moduls/new_Tasks/new_Tasks.dart';
import 'package:todo/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivesTasks = [];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  List<Widget> BootomItem = [new_Tasks(), done_Tasks(), archived_Tasks()];

  void ChangeIndex(int index) {
    CurrentIndex = index;
    emit(AppBottomNavBarStates());
  }

  void CreateDataBase() {
    /*
    ID
    title
    description
    date
    time
    status
     */
    openDatabase('ToDo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , decription TEXT , date TEXT , time TEXT, status TEXT)')
          .then((value) {
        print('dataBase created');
      }).catchError((error) {
        print('error when create data base ${error.toString()}');
      });
    }, onOpen: (database) {
      GetFromDataBase(database);
      print('dataBase opend');
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseStates());
    });
  }

  void InsertToDataBase({
    required String title,
    required String decrip,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks (title , decription , date , time , status ) VALUES("$title","$decrip","$date","$time","new")')
          .then((value) {
        print('$value Inserted sucssefully');
        emit(AppInsertDataBaseStates());
        GetFromDataBase(database);
      }).catchError((error) {
        print('error when iserting ${error.toString()}');
      });
    });
  }

  void GetFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archivesTasks = [];
    emit(AppGetDateBaseLodingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if(element['status'] == 'new')
          newTasks.add(element);
        else if(element['status'] == 'done')
          doneTasks.add(element);
        else archivesTasks.add(element);

      });
      emit(AppGetDataBaseStates());
    });
  }

  bool isBottomSheet = false;
  IconData fabIcon = Icons.edit;

  void ChangeBottomSheet({
    required bool isBotSheet,
    required IconData icon,
  }) {
    isBottomSheet = isBotSheet;
    fabIcon = icon;
    emit(AppCangeBottomsheetStates());
  }

  void UpdateDataBase({
  required String status,
    required int id,
})async
  {
    database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]
    ).then((value) {
      GetFromDataBase(database);
      emit(AppUpdateDataBaseStates());
    });

  }

  void DeleteFromDataBase({
  required int id
})
  {
    database!
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
          GetFromDataBase(database);
          emit(AppDeleteDataBaseStates());
    });
  }


}
