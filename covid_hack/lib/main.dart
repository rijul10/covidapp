import 'package:covidhack/loading.dart';
import 'package:covidhack/precautions.dart';
import 'package:covidhack/result.dart';
import 'package:covidhack/web.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  int _selectedIndex = 0;
  bool loading = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image);

    setState(() {
      _image = image;
    });
  }

//  Future <Response> dio_upload() async {
//    Dio dio = new Dio();
//    FormData formdata = new FormData();
//    //var _image =  File(imagePath);
//    var uploadURL = 'http://rishabh3699.pythonanywhere.com/upload';
//    var headers = { 'Accept': "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
//'Accept-Encoding': "gzip, deflate", 'Accept-Language': 'en-US,en;q=0.9,pa;q=0.8',
//'Cache-Control': 'max-age=0',
//'Connection': 'keep-alive',
//'Content-Length': '23837',
//'Content-Type': 'multipart/form-data; boundary=----WebKitFormBoundaryhmLhgvfizifYTezB',
//'Cookie': '_ga=GA1.2.221302727.1585165160; _gid=GA1.2.994057806.1585165160',
//'Host': 'rishabh3699.pythonanywhere.com',
//'Origin': 'http://rishabh3699.pythonanywhere.com',
//'Referer': 'http://rishabh3699.pythonanywhere.com/',
//'Upgrade-Insecure-Requests': '1',
//'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36' };
//    formdata.add("file", new UploadFileInfo(_image,_image.path));
//    print(formdata);
//    var response = dio.post(uploadURL, data: formdata, options:     Options(method: 'POST',responseType: ResponseType.json,headers: headers));
//    print(response);
//    return response;
//  }

//  Future <Response> dio_upload() async {
//    var url = 'http://rishabh3699.pythonanywhere.com/upload';
//  var request = http.MultipartRequest('POST', Uri.parse(url));
//  request.files.add(
//  http.MultipartFile.fromBytes(
//  'picture',
//  _image.readAsBytesSync(),
//  //filename: _image.split("/").last
//  )
//  );
//  var res = await request.send();
//  print(res);
//
//}

  upload(File imageFile) async {
    // open a bytestream
    var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://rishabh3699.pythonanywhere.com/upload");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: Path.basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(jsonDecode(value));
      var reply = value;
      print(reply[10]);
      Navigator.push(context,MaterialPageRoute(builder:(context) => Result(res:int.parse(reply[10]))));
    });

  }

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
        title: Text('COVID-19 Predictor'),
      ),
      body: Center(
        child: _image == null
            ? Text('Upload X-Ray of Lungs')
            : Column(
            children: <Widget>[
            Image.file(_image,width: 200,height: 200,fit: BoxFit.contain,),
              SizedBox(height: 20.0),
              RaisedButton(onPressed: () {
                setState(() => loading = true);
                 upload(File(_image.path));
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Result())
//                );
              },
                color: Colors.blue,
                child: Text('Predict'),
              )
        ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: Icon(Icons.assessment),title: Text("Prediction")),
        BottomNavigationBarItem(icon: Icon(Icons.language),title: Text("Tracker")),

      ],
        currentIndex: _selectedIndex,
        onTap: ItemTapped,
      )
      ,

    );
  }
}