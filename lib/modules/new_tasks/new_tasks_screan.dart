import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/shared/components/components.dart';
import 'package:untitled3/shared/cubit/cubit.dart';
import 'package:untitled3/shared/cubit/state.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newtasks;

        return taskBuilder(tasks: tasks);
      },
    );
  }
}
