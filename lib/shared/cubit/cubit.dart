import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled3/modules/archive_tasks/archive_tasks_screen.dart';
import 'package:untitled3/modules/done_tasks/done_tasks_screen.dart';
import 'package:untitled3/modules/new_tasks/new_tasks_screan.dart';
import 'package:untitled3/shared/cubit/state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];
  List<String> Title = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBar());
  }

  void createDataBase() async {
    openDatabase(
      'todo.db', // name of Database
      version: 1,
      onCreate: (database, version) {
        print('database create');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title Text, date TEXT,time Text,status TEXT) ')
            .then((value) {
          print('table create');
        }).catchError((error) {
          print('Error when create table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertToDatabase(
    String title,
    String time,
    String date,
  ) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO tasks(title,time,date,status) VALUES ("$title","$time","$date","new")',
      )
          .then((value) {
        log('$value inserted successfully ');
        emit(AppInsertDataBaseState());

        getDatabase(database);
      }).catchError((error, StackTrace) {
        log('Error when insert new record ${error.toString()}',
            stackTrace: StackTrace);
      });
      return Future(() => null);
    });
  }

  void getDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];

    emit(AppGetDataBaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else
          archivetasks.add(element);
      });

      emit(AppGetDataBaseState());
    });
  }

  void updateData({required String status, required int id}) {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDatabase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
