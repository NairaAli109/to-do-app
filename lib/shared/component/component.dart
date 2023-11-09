import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../cubit/cubit.dart';


Widget buildTaskItem( Map model, context)=> Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.purple[200] ,
          radius: 35,
          child:  Text(
            "${model['time']}",
            style: const TextStyle(
                color: Colors.white
            ),
          ),
        ),
        const SizedBox(width: 20,),
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
      ],
    ) ,
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
    condition: tasks.isNotEmpty,
    builder:(context)=> ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
      separatorBuilder: (context, index) =>
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
      itemCount: tasks.length,
    ),
    fallback: (context)=> const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu,size: 100,color: Colors.grey,),
          Text(
            "No Tasks Yet, Please Add Some Tasks ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.grey,
            ),
          )
        ],
      ),
    )
) ;