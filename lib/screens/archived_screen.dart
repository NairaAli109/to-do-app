import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/component/component.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';


class ArchivesTasksScreen extends StatelessWidget {
  const ArchivesTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks= AppCubit.get(context).archivedTasks;
        return tasksBuilder(tasks: tasks, text: 'There is no archive tasks yet!', icon: Icons.archive);
      },
    );
  }
}

