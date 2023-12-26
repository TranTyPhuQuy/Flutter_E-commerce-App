import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:smart_shop/constants.dart';
import 'package:smart_shop/utils/baseurl.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);
  static const String routeName = 'admin_add_category';
  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreen();
}

class _AddCategoryScreen extends State<AddCategoryScreen> {
  List<int>? _selectedFile;
  Uint8List? _bytesData;
  TextEditingController title = TextEditingController();
  String? imageData;

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          imageData = reader.result as String;
          _bytesData =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          // Remove the part before the comma
          print('imageData: ' + imageData!);
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future uploadImage() async {
    try {
      Map mapeddate = {
        'title': title.text,
        'imageData': imageData,
      };
      http.Response response =
          await http.post(Uri.parse(baseUrl + 'categories'), body: mapeddate);
      // Check if the response is successful
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("DATA: ${data}");
        // Check if the data contains userId
        if (data['success']) {
          showSuccessDialog(context,'Thành công', ' Đã thêm thành công');
          print("upload suscess");
        } else {
          // Show an error message
          showSuccessDialog(context,'Thất bại', 'Đã thêm thất bại');
          print("upload falied");
        }
      } else {
        // Show an error message
          showSuccessDialog(context,'Thất bại', 'Đã xảy ra lỗi');
        print("Something went wrong");
      }
    } catch (e) {
      print(e);
    }
  }

  void showSuccessDialog(BuildContext context,title, content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                  border: outlineInputBorder(), label: Text('Tên danh mục')),
            ),
            Text('Let\'s upload Image'),
            SizedBox(height: 20),
            MaterialButton(
              color: Colors.pink,
              elevation: 8,
              highlightElevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textColor: Colors.white,
              child: Text("Chọn ảnh"),
              onPressed: () {
                startWebFilePicker();
              },
            ),
            Divider(
              color: Colors.teal,
            ),
            _bytesData != null
                ? Image.memory(_bytesData!, width: 200, height: 200)
                : Container(),
            MaterialButton(
              color: Colors.purple,
              elevation: 8,
              highlightElevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              textColor: Colors.white,
              child: Text("Thêm"),
              onPressed: () {
                uploadImage();
              },
            ),
          ],
        )),
      ),
    );
  }
}
