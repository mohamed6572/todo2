import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/components/commponents.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

/*
1- create data base
2- create tables
3- open data base
4- insert to data base
5- get from data base
6- update data base
7- delete from dat base
 */


class Home_Layout extends StatelessWidget
{
  var scafoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleControler = TextEditingController();
  var decripControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => AppCubit()..CreateDataBase(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context, state) {
          if(state is AppInsertDataBaseStates){
            Navigator.pop(context);
          }
        },
        builder: (context, state)
        {
          var cubit = AppCubit.get(context);
         return Scaffold(
           key: scafoldKey,
            appBar: AppBar(
              title: Center(child: Text(cubit.titles[cubit.CurrentIndex],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),
              )),
              backgroundColor: Colors.blueAccent,
            ),
            floatingActionButton: FloatingActionButton(

              onPressed: (){
               if(cubit.isBottomSheet)
               {
                 if(formKey.currentState?.validate() == true){
                   cubit.InsertToDataBase(title: titleControler.text, decrip: decripControler.text, time: timeControler.text, date: dateControler.text);
                   titleControler.text='';
                   decripControler.text='';
                   timeControler.text='';
                   dateControler.text='';
                 }

               }else{
                 scafoldKey.currentState?.showBottomSheet((context)
                 => Container(
                   color: Colors.white,
                   child: Padding(
                     padding: EdgeInsets.all(20),
                     child: Form(
                       key: formKey,
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           defultFormField(
                               controller: titleControler,
                               type: TextInputType.text,
                               label: 'Task Title',
                               prefix: Icons.title,
                               validator: (value){
                                 if(value!.isEmpty){
                                   return('title must not be impty');
                                 }
                                 return null;
                               }),
                           SizedBox(height: 15,),
                           defultFormField(
                               controller: decripControler,
                               type: TextInputType.multiline,
                               label: 'Task Description',
                               prefix: Icons.description,
                               maxlines: 4,
                               validator: (value){
                                 if(value!.isEmpty){
                                   return('Description must not be impty');
                                 }
                                 return null;
                               }),
                           SizedBox(height: 15,),
                           defultFormField(
                               controller: timeControler ,
                               type: TextInputType.datetime,
                               label: 'Task Time',
                               prefix: Icons.watch_later_outlined,
                             validator: (value){
                               if(value!.isEmpty){
                                 return('time must not be impty');
                               }
                               return null;
                             },
                             onTap: (){
                                 showTimePicker(
                                     context: context,
                                     initialTime: TimeOfDay.now()
                                 ).then((value) {
                                   timeControler.text = value!.format(context).toString();
                                 });

                             }

                           ),
                           SizedBox(height: 15,),
                           defultFormField(
                               controller: dateControler ,
                               type: TextInputType.datetime,
                               label: 'Task Date',
                               prefix: Icons.calendar_today,
                               validator: (value){
                                 if(value!.isEmpty){
                                   return('date must not be impty');
                                 }
                                 return null;
                               },
                               onTap: (){
                               showDatePicker(
                                   context: context,
                                   initialDate: DateTime.now(),
                                   firstDate: DateTime.now(),
                                   lastDate: DateTime.parse('2050-03-08')
                               ).then((value) {
                                 dateControler.text = DateFormat.yMMMd().format(value!);
                               });
                               }
                           ),

                         ],
                       ),

                     ),
                   ),

                 ),

                 ).closed.then((value) {
                   cubit.ChangeBottomSheet(
                     icon: Icons.edit,
                     isBotSheet: false,
                   );
                 });
                 cubit.ChangeBottomSheet(
                   isBotSheet: true,
                   icon: Icons.add
                 );
               }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 20,
              currentIndex: cubit.CurrentIndex,
              onTap: (index)
              {
                cubit.ChangeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'New Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle),label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive),label: 'Archive'),
              ],

            ),
           body: cubit.BootomItem[cubit.CurrentIndex],
          );
        },
      ),
    );
  }
}
