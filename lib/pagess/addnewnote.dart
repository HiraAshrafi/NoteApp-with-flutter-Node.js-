import 'package:flutter/material.dart';
import 'package:note/models/note.dart';
import 'package:note/provider/noteprovider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
class AddNewPage extends StatefulWidget {
  final bool IsUpdate;
  final Note?note;
  const AddNewPage({Key? key,required this.IsUpdate,this.note}) : super(key: key);

  @override
  _AddNewPageState createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController contentcontroller=TextEditingController();

  void addnewnote(){
    Note newnote=Note(
      id:Uuid().v1(),
      userid: "mdhira@gmail.com",
      title: titlecontroller.text,
      content: contentcontroller.text,
      dateadded: DateTime.now()
    );
    Provider.of<NoteProviders>(context,listen: false).addnote(newnote);
    Navigator.pop(context);

  }
  void update(){
    widget.note!.title=titlecontroller.text;
    widget.note!.content=contentcontroller.text;
    widget.note!.dateadded=DateTime.now();
    Provider.of<NoteProviders>(context,listen: false).updatenote(widget.note!);
    Navigator.pop(context);
  }
  @override
  void initState(){
    super.initState();
    if(widget.IsUpdate){
      titlecontroller.text=widget.note!.title!;
      contentcontroller.text=widget.note!.content!;
    }

  }
  FocusNode notefocuse=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              if(widget.IsUpdate){
                update();

                //update
              }
              else{
                addnewnote();

              }

            },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: titlecontroller,
                autofocus:(widget.IsUpdate==true)?false:true,
                onSubmitted: (val){
                  if(val!=""){
                    notefocuse.requestFocus();
                  }
                },
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none
                ),
              ),
              Expanded(
                child: TextField(
                  controller: contentcontroller,
                  focusNode: notefocuse,
                  maxLines: null,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'Note',
                    border: InputBorder.none
                  ),
                ),
              )
            ],

          ),
        ),
      ),
    );
  }
}
