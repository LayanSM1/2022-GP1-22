import 'dart:developer';
import 'dart:io';
import 'package:application1/core/app_export.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:steganograph/steganograph.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class secretMsg extends StatefulWidget {
  String url;
  String? msg;
  String? encryptionKey;
  secretMsg({Key? key, this.msg, required this.url, this.encryptionKey})
      : super(key: key);

  @override
  State<secretMsg> createState() => _secretMsgState();
}

class _secretMsgState extends State<secretMsg> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }

  String? decode;
  bool isLoading = true;

  getMessage() async {
    var response = await http.get(Uri.parse(widget.url));
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = new File(join(documentDirectory.path, 'imagetest.png'));
    file.writeAsBytesSync(response.bodyBytes);
    log(file.toString());
    String? embeddedMessage = await Steganograph.decode(
      image: file,
      encryptionKey: widget.encryptionKey,
    );
    setState(() {
      decode = embeddedMessage;
      isLoading = false;
    });
    log(embeddedMessage!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   TextButton(
          //     onPressed: () {

          //     },
          //     child: Text(
          //       'Show Secret Message',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   )
          // ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text(decode.toString())));
          Get.snackbar(
            'Secret message',
            decode.toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red,
            barBlur: 2,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 5),
            margin: EdgeInsets.all(10),
          );
        },
        child: Icon(
          Icons.message,
          color: Colors.white,
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                      image: NetworkImage(
                        widget.url,
                      ),
                      fit: BoxFit.cover)),
              // child: Center(
              //   child: Text(
              //     decode.toString(),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 25,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ),
    );
  }
}
