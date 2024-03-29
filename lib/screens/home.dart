import 'package:flutter/material.dart';
import 'package:yet_another_mal_client/models/fetchResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yet_another_mal_client/models/DetailsResult.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:yet_another_mal_client/screens/details.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  late List<Data> itemList;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final token ='';
      
  @override
  void initState() {
    super.initState();
    widget.itemList = [];
  }

  int _crossAxisCount = 2;

  double _aspectRatio = 1.5;

  ViewType _viewType = ViewType.grid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Preview'),
        actions: [
          IconButton(
            icon: Icon(
                _viewType == ViewType.list ? Icons.grid_on : Icons.view_list),
            onPressed: () {
              if (_viewType == ViewType.list) {
                _crossAxisCount = 2;
                _aspectRatio = 1.5;
                _viewType = ViewType.grid;
              } else {
                _crossAxisCount = 1;
                _aspectRatio = 5;
                _viewType = ViewType.list;
              }
              setState(() {});
            },
          )
        ],
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search',
                ),
                onSubmitted: (string) => SearchQuery(string),
              ),
              Flexible(
                child: Container(
                    height: 600,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Theme.of(context).canvasColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: GridView.count(
                          crossAxisCount: _crossAxisCount,
                          childAspectRatio: _aspectRatio,
                          children: widget.itemList.map((Data imageData) {
                            return getGridItem(imageData);
                          }).toList(),
                        ))),
              ),
            ]),
      ),
    );
  }

  GridTile getGridItem(Data imageData) {
    return GridTile(
      child: GestureDetector(
        onTap: () => seeDetails(context, imageData.node?.id, token),
        child: (_viewType == ViewType.list)
            ? Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageData.node?.mainPicture?.medium as String,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CutTitle(imageData.node?.title as String),
                          style: const TextStyle(
                              fontSize: 20, overflow: TextOverflow.fade),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageData.node?.mainPicture?.medium as String,
                          ))),
                  Text(
                    CutTitle(imageData.node?.title) as String,
                    style: const TextStyle(
                        fontSize: 15, overflow: TextOverflow.clip),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
      ),
    );
  }

  Future<void> SearchQuery(searched) async {
    var query = await getImageDataList(searched, token);
    setState(() {
      widget.itemList = query;
    });
  }
}

String CutTitle(title) {
  if (title.length > 25) return title.substring(0, 22) + '...';
  return title;
}

Future<List<Data>> getImageDataList(searched, token) async {
  var client = http.Client();
  FetchResult? decodedResponse;

  var response = await client.get(
      Uri.https(
          'api.myanimelist.net', '/v2/anime', {"q": searched, "limit": "40"}),
      headers: {"Authorization": token});
  var fetched = jsonDecode(response.body) as Map<String, dynamic>;
  decodedResponse = FetchResult.fromJson(fetched);
  client.close();

  return decodedResponse?.data ?? [];
}

Future<DetailsResult> getDetails(id, token) async {
  DetailsResult model;
  var client = http.Client();
  var response = await client.get(
      Uri.https('api.myanimelist.net', '/v2/anime/$id',
          {"fields": "id,title,start_date,end_date,synopsis"}),
      headers: {"Authorization": token});
  var fetched = jsonDecode(response.body) as Map<String, dynamic>;
  model = DetailsResult.fromJson(fetched);

  client.close();
  return model;
}

Future<void> seeDetails(context, id, token) async {
  var client = http.Client();
  DetailsResult model = await getDetails(id, token);
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => new DetailsScreen(model)));
}

enum ViewType { grid, list }
