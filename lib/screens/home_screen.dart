// ignore_for_file: avoid_print, use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';


class HomeScreen extends StatelessWidget {

  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context,AppStates state) {
          if (state is AppInsertDBState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context,AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.purple[100],
              title:  Text(
                cubit.titles[cubit.currentIndex],
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async
              {
                if(cubit.isBottomSheetShown)//isBottomSheetShown==true------->>>>> sheet is opened
                    {
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                }
                else// isBottomSheetShown==false------->>>>> sheet is closed
                    {
                  scaffoldKey.currentState?.showBottomSheet(
                        (context) =>
                        Container(
                          // color: Colors.white,
                          padding: const EdgeInsets.all(20),
                          child:Form(
                            key: formKey,
                            child:   Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  onTapOutside: (event){
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty ) {
                                      return "title must be not empty";
                                    }
                                    return null;
                                  },
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  decoration:  const InputDecoration(
                                      label: Text("Task title"),
                                      prefixIcon: Icon(Icons.title),
                                      border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 20,),
                                TextFormField(
                                  onTapOutside: (event){
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty ) {
                                      return "time must be not empty";
                                    }
                                    return null;
                                  },
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: (){
                                    showTimePicker(
                                      context: context ,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      print(value?.format(context));
                                      timeController.text= value!.format(context);
                                    });
                                  },
                                  decoration:  const InputDecoration(
                                      label: Text("Time"),
                                      prefixIcon: Icon(Icons.watch_later_outlined),
                                      border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 20,),
                                TextFormField(
                                  onTapOutside: (event){
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty ) {
                                      return "date must be not empty";
                                    }
                                    return null;
                                  },
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: (){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2023-12-09"),
                                    ).then((value){
                                      dateController.text = DateFormat.yMMMd().format(value!);
                                      print(DateFormat.yMMMd(). format(value));
                                    });
                                  },
                                  decoration:  const InputDecoration(
                                      label: Text("date"),
                                      prefixIcon: Icon(Icons.calendar_month),
                                      border: OutlineInputBorder()),
                                ),
                              ],
                            ),
                          ),
                        ),
                    elevation: 20,
                  ).closed.then((value)
                  {
                    cubit.changeBottomSheetState(
                        isShow: false,
                        icon: Icons.edit
                    );
                  });
                  cubit.changeBottomSheetState(
                      isShow: true,
                      icon: Icons.add
                  );
                }
              },
              backgroundColor: Colors.purple[100],
              child:  Icon(cubit.fabIcon),
            ),
            body: state is AppGetDatabaseLoadingState ? const Center(child: CircularProgressIndicator(),) : cubit.screens[cubit.currentIndex],
            // body: state is! AppGetDatabaseLoadingState ?  cubit.screens[cubit.currentIndex]:const Center(child: CircularProgressIndicator(),),
            // body: cubit.tasks.isEmpty ? const Center(child: CircularProgressIndicator(),) : cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: "tasks"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done),
                    label: "done"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: "archived"
                ),
              ],
            ),
          );
        },
      ),
    );
  }
///try-catch error
// try
// {
//   var name= await getName();
//   print(name);
//
//   // throw("some error!!!!!!!!!!!!");
// }
// catch(error)
// {
//   print("error${error.toString()}");
// }

///.then-catch error
// getName().then((value) {
//   print(value);
//   print("osama");
// }).catchError((error){
//   print("error is :${error.toString()}");
// });
}

