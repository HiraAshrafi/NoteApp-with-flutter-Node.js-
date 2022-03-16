import 'package:flutter/cupertino.dart';
import 'package:note/models/note.dart';
import 'package:note/service/serviceapi.dart';

class NoteProviders with ChangeNotifier{
  bool isloading=true;
  List<Note>notes=[];
  NoteProviders(){
    fetchnote();
  }
  void sortnote(){
    notes.sort((a,b)=>b.dateadded!.compareTo(a.dateadded!));
  }

  void addnote(Note note){
    notes.add(note);
    sortnote();
    notifyListeners();
    ApiService.addnotes(note);

  }

  void updatenote(Note note){
    int indexofnote=notes.indexOf(notes.firstWhere((element) => element.id==note.id));
    notes[indexofnote]=note;
    sortnote();
    notifyListeners();
    ApiService.addnotes(note);


  }
  void deletenote(Note note){
    int indexofnote=notes.indexOf(notes.firstWhere((element) => element.id==note.id));
    notes.removeAt(indexofnote);
    sortnote();
    notifyListeners();
    ApiService.deletenotes(note);


  }
  void fetchnote()async{
    notes= await ApiService.fetchnotesdata("mdhira@gmail.com");
    isloading=false;
    sortnote();
    notifyListeners();

  }


}