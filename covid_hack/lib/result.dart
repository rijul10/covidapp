
import 'package:covidhack/precautions.dart';
import 'package:covidhack/web.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';



class Result extends StatefulWidget {
  int res;
  Result({Key key,this.res}): super(key: key);
  @override
  _ResultState createState() => _ResultState(res);
}

class _ResultState extends State<Result> {
  int res;
  _ResultState(this.res);

  
  int _selectedIndex = 0;

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
              title: const Text('Prediction Result'),
              // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//        actions: <Widget>[
//          NavigationControls(_controller.future),
//          Menu(_controller.future, () => _favorites),
//        ],
            ),
            body: Center(
              child: res == 1
                  ? Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text('The model predicts that you are safe from COVID-19! Stay the same!',
                style: TextStyle(fontSize: 28))))
                  : Center(child:Container(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Text('The model predicts that there is a high chance that you are suffering from COVID-19! Go to a doctor if you feel any symptoms!',
    style: TextStyle(fontSize: 28))))
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
