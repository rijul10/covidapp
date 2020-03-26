import 'dart:async';
import 'package:covidhack/main.dart';
import 'package:covidhack/precautions.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikipediaExplorer extends StatefulWidget {
  @override
  _WikipediaExplorerState createState() => _WikipediaExplorerState();
}

class _WikipediaExplorerState extends State<WikipediaExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();
  int _selectedIndex = 1;

  void ItemTapped(int index)
  {
    if(index==1)
    {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=> WikipediaExplorer())
      );
    }

    else{
      setState(() {
        _selectedIndex = index;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage())
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: new Container(),
        title: const Text('COVID-19 Tracker'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//        actions: <Widget>[
//          NavigationControls(_controller.future),
//          Menu(_controller.future, () => _favorites),
//        ],
      ),
      body: WebView(
        initialUrl: 'https://bing.com/covid',
//        onWebViewCreated: (WebViewController webViewController) {
//          _controller.complete(webViewController,
//          );
//        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
        bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.assessment),title: Text("Prediction")),
          BottomNavigationBarItem(icon: Icon(Icons.language),title: Text("Tracker")),

        ],
          currentIndex: _selectedIndex,
          onTap: ItemTapped,
        )


    );
  }

}
