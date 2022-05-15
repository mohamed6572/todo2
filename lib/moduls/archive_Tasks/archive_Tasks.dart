import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/commponents.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class archived_Tasks extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (context, state) {
        var tasks =AppCubit.get(context).archivesTasks;
        return taskBuilder(
            text: 'no archived Tasks Yet , please Add Some Tasks',
            tasks: tasks,
          color1: Colors.grey,
          color2: Colors.blueGrey,
        );
      } ,
      listener: (context, state) {

      },
    );

  }
}
