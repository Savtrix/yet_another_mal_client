import 'package:flutter/material.dart';
import 'package:yet_another_mal_client/models/DetailsResult.dart';
import 'package:http/http.dart' as  http;
import 'dart:convert';

class DetailsScreen extends StatefulWidget {
  late DetailsResult model;
   DetailsScreen(model){
    this.model = model;
  }
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<DetailsScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(),
        body: Container(
          child: ListView(
            children: [
          Image.network(
            widget.model.mainPicture?.medium as String,

            height: 350,
          ),
              Text(widget.model.title.toString(),
              maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 40),
              ),
              Text("From:" + widget.model.startDate.toString(), maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Open Sans',
                    fontSize: 20),),
              Text("To:" + (widget.model.endDate ?? "not finished"), maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Open Sans',
                    fontSize: 20),),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.red)
                  ),
                  color: Theme.of(context).canvasColor,),
                child:
              Column(
                children:[
              Text("Synopsis:",style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: 'Open Sans',
                  fontSize: 24),),
              Text(widget.model.synopsis.toString())
            ],
          ),
        ),
  ],)
    ),);
  }
}