import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note/models/note.dart';
import 'package:http/http.dart'as http;

class ApiService
{
  static String _baseurl="https://infinite-earth-71505.herokuapp.com/note";

  static Future<void>addnotes(Note note)async{
    Uri requesturi=Uri.parse(_baseurl +"/add");
     var response= await http.post(requesturi,body: note.toMap());
     var decode=jsonDecode(response.body);
     developer.log(decode.toString());
      


  }
  
  static Future<void>deletenotes(Note note)async{
    Uri requesturi=Uri.parse(_baseurl +"/delete");
    var response=await http.post(requesturi,body: note.toMap());
    var decode=jsonDecode(response.body);
    developer.log(decode.toString());
  }

  static Future<List<Note>>fetchnotesdata(String userid)async{
    Uri requesturi=Uri.parse(_baseurl +"/list");
    var response=await http.post(requesturi,body:{"userid":userid});
    var decode=jsonDecode(response.body);
    List<Note>notes=[];
    for(var notemap in decode  ){
      Note newnote=Note.fromMap(notemap);
      notes.add(newnote);
    }
    return notes;



  }
}