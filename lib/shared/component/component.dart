import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/shared/colors.dart';

import '../cubit/cubit.dart';


Widget buildTaskItem( Map model, context)=> Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
    child:Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      width: double.infinity,
      height: 80,
      child:  Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: mainColor,
              radius: 35,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Center(
                  child:  Text(
                    "${model['time']}",
                    style: const TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ) ,
            const SizedBox(width: 20),
            Expanded(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 7,),
                  Text(
                    "${model['date']} ",
                    style: const TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20,),
            IconButton(
              onPressed: (){
                AppCubit.get(context).updateData(
                  status: 'Done',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: (){
                AppCubit.get(context).updateData(
                    status: "Archive",
                    id: model['id']
                );
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
            IconButton(
              onPressed: (){
                AppCubit.get(context).deleteData(id: model['id']);
              },
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      )
    )
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
  required String text,
  required IconData icon,
}) => ConditionalBuilder(
    condition: tasks.isNotEmpty,
    builder:(context)=> ListView.builder(
      itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
      // separatorBuilder: (context, index) =>
      //     Padding(
      //       padding: const EdgeInsets.all(20),
      //       child: Container(
      //         width: double.infinity,
      //         height: 1.0,
      //         color: Colors.grey[300],
      //       ),
      //     ),
      itemCount: tasks.length,
    ),
    fallback: (context)=>  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(icon,size: 100,color: Colors.white,),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    )
) ;