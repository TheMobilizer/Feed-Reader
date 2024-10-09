import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemTile extends StatelessWidget{
    final String title;
    final String link;

    //final VoidCallback onPressed;
    const ItemTile(
        {super.key, required this.title, required this.link,});
    @override
    Widget build(BuildContext context){
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          surfaceTintColor: Colors.deepPurpleAccent,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.purple,

            onTap: () {
                launchUrl(Uri.parse(link));
            },
          
            /*onPressed: () {
                launchUrl(Uri.parse(link));
            },*/
            child: 
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: SizedBox(
                width: 100,
                height: 50,
                child: Text(title),
                )
              ),
        )
        );

    }

}