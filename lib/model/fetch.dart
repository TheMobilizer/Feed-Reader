import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dart_rss/dart_rss.dart';

class Fetcher {

  Future<List<String>> getLinks() async { 

    var links = <String>[];
    await File('links').readAsString().then((String contents) {
      links = contents.split("\n");
      }
    );

    return Future.value(links);
  }

  int operate(String op, int n1, int n2)
  {
    if(op == "+")
    {
      return (n1+n2);
    }
    return (n1-n2);
  }

  String? convertRssTimeToHttp(String? dt)
  {

    /*
    Break received datetime by spaces, creating a List<String>:
    dtList[0] = day,
    dtList[1] = dd
    dtList[2] = mon
    dtList[3] = yyyy
    dtList[4] = hh:mm:ss
    dtList[5] = [+/-]HHMM
    */
    List<String> dtList = dt!.split(' ');
    if(dtList[5] == "GMT")
    {
      return dt;
    }
    String? res = dt.split('+')[0];
    if(res == dt)
    {
      res = dt.split('-')[0];
    }

    int hr = int.parse(dtList[4].split(":")[0]);
    int mn = int.parse(dtList[4].split(":")[1]);

    String sign = dtList[5][0];
    if(sign == "+")
    {
      sign = "-";
    }
    else if(sign == "-")
    {
      sign = "+";
    }
    
    String delhm = dtList[5].replaceFirst("+", "");
    int delh = int.parse(delhm.substring(0,2));
    int delm = int.parse(delhm.substring(2,4));

    int dayn = int.parse(dtList[1]);

    int newmn = mn;
    int newhr = hr;
    int newday = dayn;

  
    newmn = operate(sign, newmn, delm);
    newhr = operate(sign, newhr, delh);
    

    if(newmn > 59)
    {
      newhr += newmn ~/ 60;
      newmn = newmn % 60;
      newday += newhr ~/ 24;
      newhr = newhr % 24;
    }
    else if(newmn < 0)
    {
      newmn = newmn % 60;
      newhr = newhr % 24;
      newhr -= 1;
      newday -= newhr ~/ 24;
    }


    res += "GMT";
    return res;

  }

  Future<List<RssItem>> fetchAll() async
  {
    final links = await getLinks();
    List<RssItem> feedItems = [];
    for(String link in links)
    {
        final httpPackageUrl = Uri.parse(link);
        final httpPackageInfo = await http.read(httpPackageUrl);
        var rssFeed = RssFeed.parse(httpPackageInfo);
        //print(rssFeed.description);
        //print(rssFeed.categories.length);
        //print("Adding Items to list...");
        for(final item in rssFeed.items)
        {
          feedItems.add(item);
        }
    }
    feedItems.sort((a,b) => -(HttpDate.parse(convertRssTimeToHttp(a.pubDate)??"").compareTo(HttpDate.parse(convertRssTimeToHttp(b.pubDate)??""))));
    print("Inside fetchAll. Feed items:");
    print(feedItems.length);
    return Future.value(feedItems);
  
  }

  void fphello()
  {
    print("Hello flutter");
  }
}