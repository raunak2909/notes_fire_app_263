import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseFirestore firebaseFirestore;

  late CollectionReference<Map<String, dynamic>> colNote;

  @override
  Widget build(BuildContext context) {

    firebaseFirestore = FirebaseFirestore.instance;
    colNote = firebaseFirestore.collection('notes');

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: FutureBuilder(
        future: colNote.get(),
        builder: (_, snapshots){

          if(snapshots.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshots.hasData){
            return snapshots.data!.size>0 ? ListView.builder(
              itemCount: snapshots.data!.docs.length,
                itemBuilder: (_, index){
              return ListTile(
                title: Text(snapshots.data!.docs[index].data()['title']),
                subtitle: Text(snapshots.data!.docs[index].data()['desc']),
              );
            }) : Center(child: Text('No Notes yet!!'),);
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var doc = await colNote.add({
            'title' : 'New Note',
            'desc' : 'Do what you love or Love what you do.'
          });

          setState(() {

          });

          print("${doc.id} added!!");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}