import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/commponents.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class new_Tasks extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state) {
          var tasks =AppCubit.get(context).newTasks;
          return taskBuilder(
            text: 'no  Tasks Yet , please Add Some Tasks',
            color1: Colors.grey,
            color2: Colors.grey,
            tasks: tasks
          );
        } ,
        listener: (context, state) {

        },
    );
  }
}
