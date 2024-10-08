import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/component/component.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';


class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks= AppCubit.get(context).newTasks;
        return tasksBuilder(tasks: tasks, text: 'Start adding your tasks...', icon: Icons.menu);
      },
    );
  }
}

