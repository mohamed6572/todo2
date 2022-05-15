import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/commponents.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class done_Tasks extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (context, state) {
        var tasks =AppCubit.get(context).doneTasks;
        return taskBuilder(
            text: 'no done Tasks Yet , please Add Some Tasks',
            tasks: tasks,
          color1: Colors.green,
          color2: Colors.grey,
        );
      } ,
      listener: (context, state) {

      },
    );

  }
}
