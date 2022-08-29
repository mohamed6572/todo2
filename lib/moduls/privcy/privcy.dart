import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class privcy extends StatefulWidget{

  @override
  State<privcy> createState() => _privcyState();
}

class _privcyState extends State<privcy> {
  String? privecy;

  @override
  initState() {
    super.initState();
    getPrivecyText();
  }

  getPrivecyText()async{
    String response;
    response =await rootBundle.loadString('assets/privecy.txt');
    privecy = response;
    print(privecy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text( 'الخصوصية',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),),
        ),
      body:  Center(child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
           margin: EdgeInsets.all(15),
           padding: EdgeInsets.all(20),
           child: Column(
             children: [
               Text('$privecy',style: TextStyle(height: 1.8,fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black))

             ],
           ),
         ),
      )),
    );

  }
}
