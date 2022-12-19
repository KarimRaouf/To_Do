import 'package:FlutterApplications/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static get(context) => BlocProvider.of<AppCubit>(context);

  int currentIndex = 0;

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDataBase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        try {
          await database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
          print('database created');
        } catch (error) {
          print('Error when create table$error');
        }
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void insertDatabase({
    required String title,
    required String time,
    required String date,
  }) {
    database.transaction(
      (txn) async {
        await txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","New")',
        );
      },
    ).then((value) {
      emit(AppInsertDatabaseState());
      getDataFromDatabase(database);
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'New')
          newTasks.add(element);
        else if (element['status'] == 'Done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required IconData icon,
    required bool isBottomSheet,
  }) {
    fabIcon = icon;
    isBottomSheetShown = isBottomSheet;
    emit(AppChangeBottomSheetState());
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', '$id'],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabasetState());
    });
  }

  void deleteData({
    required int id,
  }) {
    database.rawUpdate('DELETE FROM tasks WHERE id = ?', [id]);
    getDataFromDatabase(database);
    emit(AppDeleteDatabasetState());
  }
}
