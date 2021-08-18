import 'package:chill_n_grill/model/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';



class SecondScreen extends StatefulWidget {
  final EventImages value;


  SecondScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String downloadMessage= "downloading";
  bool _isDownloading = false;
  int _progress = 0;
  void initState() {
    super.initState();

    ImageDownloader.callback(onProgressUpdate: (String  imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Detail Page')),
      body: new Container(
        child: new Center(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network('${widget.value.imageUrl}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text("Download Image",style: TextStyle(fontSize: 10),),
                  onPressed: ()async{
                    setState(() {
                      _isDownloading =!_isDownloading;
                    });
                    var dir = await getExternalStorageDirectory();
                    Dio dio =Dio();
                    dio.download('${widget.value.imageUrl}', '${dir.path}',
                      onReceiveProgress:(actualbytes, totalbytes){
                      var percentage =actualbytes/totalbytes*100;

                      setState(() {
                        downloadMessage= actualbytes.toString();
                      });
                      }

                    );
                    // try {

                    //   var imageId = await ImageDownloader.downloadImage('${widget.value.imageUrl}');
                    //   if (imageId == null) {
                    //     return;
                    //   }
                    //   var path = await ImageDownloader.findPath(imageId);
                    // } on PlatformException catch (error) {
                    //   print(error);
                    // }
                  },
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}




