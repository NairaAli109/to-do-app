// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/shared/cubit/states.dart';

import '../../screens/archived_screen.dart';
import '../../screens/done_screen.dart';
import '../../screens/new_tasks_screen.dart';


class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> screens=
  [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivesTasksScreen(),
  ];

  List<String> titles=
  [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks"
  ];

  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];

  ///CREATE DATABASE
  void createDatabase()  {
    openDatabase(
        "todo.db",
        version: 1,
        onCreate: (database, version){
          print("database created");
          //creating table
          database.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT , status TEXT )")
              .then((value) {
            print("table is created");
          }).catchError((error){
            print("error while creating table ${error.toString()}");
          });
        },
        onOpen: (database){
          getDataFromDatabase(database);
          print("database opened ");
        }
    ).then((value){
      database=value;
      emit(AppCreateDBState());
    });
  }

  ///INSERT TO DATABASE
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
    await database.transaction((txn )async{
      txn.rawInsert(
          'INSERT INTO tasks (title,date,time,status) VALUES("$title", "$date","$time","new")'
      ).then((value)
      {
        print("$value inserted successfully");

        emit(AppInsertDBState());

        getDataFromDatabase(database);
      }).catchError((error){
        print("++++++++++++++++++++++error while inserting new record ${error.toString()}+++++++++++++++++++++++++");
      });
      return null;
    });
  }

  ///GET DATA FROM DATABASE
  void getDataFromDatabase( database )
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks ').then((value) {

      value.forEach((element) {
        if(element['status']=='new'){
          newTasks.add(element);
        }
        else if(element['status']=='Done'){
          doneTasks.add(element);
        }
        else archivedTasks.add(element);
      });

      emit(AppGetDBState());
    });
  }

  ///UPDATE DATE
  void updateData({
    required String status,
    required int id,
  }){
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseLoadingState());
    });
  }

  ///DELETE DATE
  void deleteData({
    required int id,
  }){
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseLoadingState());
    });
  }

  ///CHANGE BOTTOM SHEET STATE
  bool isBottomSheetShown=false;
  IconData fabIcon= Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }){

    isBottomSheetShown= isShow;
    fabIcon= icon;

    emit(AppChangeBottomSheetState());
  }



}