import 'package:flutter/material.dart';
import 'package:note/pagess/homepage.dart';
import 'package:note/provider/noteprovider.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(myapp());
}
class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=>NoteProviders(),
        )
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      )
    );


  }
}
