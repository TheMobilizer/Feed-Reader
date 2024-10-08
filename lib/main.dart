import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:reader/model/fetch.dart';
import 'package:reader/view/item_tile.dart';
void main() {
  //Fetcher().fphello();
  runApp( 
    MaterialApp(
      title: "WIP:Reader",
      home: MainApp(fetcher: Fetcher()),
      ),
    );
}



class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.fetcher});
  final Fetcher fetcher;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>{
  List<RssItem> _feedItems = [];

  @override
  void initState() {
    super.initState();
    widget.fetcher.fetchAll().then((value){
      setState(() {
        _feedItems = value;
      });
      
    }
    );
    print(_feedItems.length);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed Reader"),
      ),
      body: ListView.builder(
        itemCount: _feedItems.length,
        itemBuilder: (context, index){
          final item = _feedItems[index];
          print("Inside Item Builder");
          print(_feedItems.length);
          //return Text(item.title??"No title provided");
          return ItemTile(
            title: item.title??"no title",
            link: item.link??"",
          );
        },
        )
    );
  }

}