import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget defultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required String? Function(String? val) validator,
  VoidCallback? onTap,
  int? maxlines,
}) =>
    TextFormField(
      onTap: onTap,
      validator: validator,
      controller: controller,
      keyboardType: type,
      maxLines: maxlines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );



Widget BuildTaskItem({required Map model, context,required Color color1,required Color color2}) => Dismissible(
  onDismissed: (direction){
    AppCubit.get(context).DeleteFromDataBase(id:model['id'],);
  },
  key: Key(model['id'].toString()),
  child:   Padding(

        padding: EdgeInsets.all(20),

        child: Row(

          children: [

            CircleAvatar(
              backgroundColor: Colors.blueAccent,

              radius: 40,

              child: Text(

                model['time'],
                style: TextStyle(
                  color: Colors.white
                ),



              ),

            ),

            SizedBox(

              width: 20,

            ),

            Expanded(

                child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  model['title'],

                  style: TextStyle(

                    fontSize: 22,

                    fontWeight: FontWeight.bold,

                  ),

                ),

                SizedBox(

                  height: 3,

                ),

                Text(

                  model['date'],

                  style: TextStyle(fontSize: 10, color: Colors.grey),

                ),

                SizedBox(

                  height: 2,

                ),

                Text(

                  model['decription'],

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight: FontWeight.w300,

                  ),

                ),

              ],

            )),

            IconButton(onPressed: (){

              AppCubit.get(context).UpdateDataBase(

                id: model['id'],

                status: 'done'

              );

            }, icon: Icon(Icons.check_box,color:color1,)),

            IconButton(onPressed: (){

              AppCubit.get(context).UpdateDataBase(

                  id: model['id'],

                  status: 'archived'

              );

            }, icon: Icon(Icons.archive,color: color2,)),

          ],

        ),

      ),
);

Widget taskBuilder({
  required List<Map> tasks,
required String text,
  required Color color1,
  required Color color2

})=> tasks.length > 0 ? ListView.separated(
    itemBuilder:(context, index) => BuildTaskItem(model: tasks[index],
    color1: color1,
    color2:color2 ,
    context: context
    ) ,
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20
      ),
      child: Container(
        width: double.infinity,
        height: 2,
        color: Colors.grey[300],      ),
    ),
    itemCount: tasks.length
) : Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.menu,
      size: 100,),
      Text(
          text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    ],

  ),
);
