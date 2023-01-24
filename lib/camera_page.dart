import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
// import 'package:path_povider/path_provider.dart';
// import 'package:cross_file_image/cross_file_image.dart';
import 'package:http/http.dart' as http;


class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;
  String object = "placeholder";

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              height: 600,
              width: 400,
              child: CameraPreview(controller),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              pictureFile = await controller.takePicture();
              File imageFile = await File(pictureFile!.path);
              String path = imageFile.path;
              print(path);
              String object2 = await uploadImage("image",imageFile );
              // String fileFormat = imageFile.path.split('.').last;
              // print(imageFile.path);
              setState(() {
                object = object2;
                print(object);
              });
            },
            child: const Text('Identify'),
          ),
        ),

        // Image.file(File(pictureFile!.path)),
          // result of AI
          Text(
            '$object',
            // 'The object is: $object',
            style: TextStyle(fontSize: 35, backgroundColor: Colors.yellow),
          )
      ],
    );
  }
}


Future<String> uploadImage(String title, File file) async{
  // var request = http.MultipartRequest("POST",Uri.parse("http://127.0.0.1:8000/objects/"));
  //
  // request.fields['title'] = "objectImage";
  // request.headers['Authorization'] = "";
  // var picture = http.MultipartFile.fromBytes('image', (await load(path)).buffer.asUint8List(),
  //     filename: 'testimage.jpg');
  // request.files.add(picture);
  // var response = await request.send() ;

  // var responseData = await response.stream.toBytes();

  // var result = String.fromCharCodes(responseData);

  // print(result);

  // final response = await http.post(
  //   Uri.parse("http://127.0.0.1:8000/objects/"),
  //
  //   body: {
  //     // 'photo': file != null ? 'data:image/png;base64,' + base64Encode(file.readAsBytesSync()) : 'dd',
  //   },
  // );
  // final responseJson = json.decode(response.body);
  // print(responseJson);

  Response response;
  var dio = Dio();
  
  response = await dio.post("http://192.168.132.254:8000/objects/", data: {
    // 'id': 12, 'name': 'wendu',
    'photo': file != null ? 'data:image/jpg;base64,' + base64Encode(file.readAsBytesSync()) : '34',
  });
  print('sssssssssssss2');
  // print(response.data['verdict']);

  return response.data['verdict'];

}
