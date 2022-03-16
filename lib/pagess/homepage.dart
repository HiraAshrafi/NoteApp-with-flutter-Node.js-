
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/models/note.dart';
import 'package:note/pagess/addnewnote.dart';
import 'package:note/provider/noteprovider.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NoteProviders noteProviders=Provider.of<NoteProviders>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(""
            "Note APP"),
      ),
      body: (noteProviders.isloading==false)?SafeArea(
        child:(noteProviders.notes.length>0)? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount:noteProviders.notes.length,
          itemBuilder: (context,index){
            Note currenote=noteProviders.notes[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>AddNewPage(IsUpdate: true,note: currenote,)
                ));
              },
              onLongPress: (){
                noteProviders.deletenote(currenote);
              },

              child: Container(
                margin: const EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2
                  )

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     currenote.title!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 7,),
                    Text(currenote.content!,
                    maxLines: 5,overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
            );

          },

        ):
            Center(
              child: Text(""
                  "No notes yets"),
            )
      ):
          Center(
            child: CircularProgressIndicator(),
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context)=>AddNewPage(IsUpdate: false)
          ));

        },
      ),

    );
  }
}
