import 'package:covidhack/main.dart';
import 'package:covidhack/web.dart';
import 'package:flutter/material.dart';


class Precautions extends StatefulWidget {

  @override
  _PrecautionsState createState() => _PrecautionsState();
}

class _PrecautionsState extends State<Precautions> {

  int _selectedIndex = 1;

  void ItemTapped(int index)
  {
    if(index==1)
    {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WikipediaExplorer())
      );
    }
    else if(index==2)
    {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Precautions())
      );

    }

    else{
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage())
      );

    }


  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
