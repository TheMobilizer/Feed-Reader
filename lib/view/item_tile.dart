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
        return TextButton(

            onPressed: () {
                launchUrl(Uri.parse(link));
            },
            child: Text(title));

    }

}