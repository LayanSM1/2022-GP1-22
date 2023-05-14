// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'dart:io';
import 'package:application1/classes/Utils.dart';
import 'package:application1/classes/function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:steganograph/steganograph.dart';
import 'package:application1/classes/secureStorage.dart';
import 'package:crypton/crypton.dart';


class sendImage extends StatefulWidget {
  File imagepath;
  String path;
  String myName;
  String uid;
  String Secretkey;
  sendImage(
      {Key? key,
      required this.imagepath,
      required this.path,
      required this.myName,
      required this.uid,
      required this.Secretkey})
      : super(key: key);

  @override
  State<sendImage> createState() => _sendImageState();
}

class _sendImageState extends State<sendImage> {
  UploadTask? task;
  TextEditingController _title = TextEditingController();
  bool isLoading = false;
  List<int>? bytes;


  RSAPrivateKey? MyPrivateKey;
  String? EncryptedSecretKey;
  String? SecretKey;
  String encryptedmsg='';
  Future<void> encryptSecretKey() async {
    try {
      EncryptedSecretKey=widget.Secretkey;
      final myPrivateKeyString = await userSecureStorage.getPrivateKey() ?? "";
      MyPrivateKey=RSAPrivateKey.fromString(myPrivateKeyString);
      print("my private key from secure storage ");
      print(MyPrivateKey.toString());
      print("decrypted Secret Key");
      SecretKey = MyPrivateKey!.decrypt(EncryptedSecretKey!);


    }
    catch(e) {
      print(e);
    }
  }


  Future encrypt() async {
    String SKey="";
    String msg = _title.text;
    print("orginal msg"+msg+"the secret key"+widget.Secretkey);

    try {
      EncryptedSecretKey=widget.Secretkey;
      // decrypt shared secret key :
      final myPrivateKeyString = await userSecureStorage.getPrivateKey() ?? "";
      MyPrivateKey=RSAPrivateKey.fromString(myPrivateKeyString);
      print("my private key from secure storage ");
      print(MyPrivateKey.toString());
      print("decrypted Secret Key");
       SKey = MyPrivateKey!.decrypt(EncryptedSecretKey!);

    }
    catch(e) {
      print(e);
    }
    print("original msg"+msg+"the secret key"+SKey);

    // encrypt the message using shared secret key :
    encryptedmsg =
    (await FlutterAesEcbPkcs5
        .encryptString(
        msg,SKey))!;

    print("the original msg");
    print(_title.text);
    print("the encrypted msg");
    print(encryptedmsg);

    setState(() {
      isLoading = true;
    });
    Directory tempDir = await getTemporaryDirectory();
    File? StegoImag = await Steganograph.encode(
      image: File(widget.path),
      message: encryptedmsg,
      outputFilePath: tempDir.path + '/result.png',
    );
    log(StegoImag.toString());
    print(StegoImag!.path);
    log(StegoImag.path);
    if (StegoImag != null) {
      setState(() {
        bytes = StegoImag.readAsBytesSync();
      });
      return StegoImag.path;
    }
  }

  var userData1 = {};
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getData1();
  }

  getData1() async {
    setState(() {
      isLoading = true;
    });

    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.uid)
          .get();

      setState(() {
        userData1 = Usersnap.data()!;
      });
    } catch (e) {}

    setState(() {
      isLoading = false;
    });
  }

  final cloudinary = Cloudinary.full(
    apiKey: '198352734653458',
    apiSecret: 'llU7_NDCJnPOMVTSw7ODSZknBXE',
    cloudName: 'duwyd7b68',
  );

  Future uploadImage(String path, String key) async {
    Utils.toastMessage("sending image");
    String fileName = Uuid().v1();

    final response = await cloudinary.uploadResource(CloudinaryUploadResource(
        filePath: path,
        fileBytes: bytes,
        resourceType: CloudinaryResourceType.image,
        folder: 'Stego Encrypt Image',
        fileName: fileName,
        progressCallback: (count, total) {
          print('Uploading image from file with progress: $count/$total');
        }));

    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
    }
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chats")
        .doc(widget.uid)
        .collection('ImgChat')
        .doc(fileName)
        .set({
      "user": widget.myName,
      "link": response.secureUrl,
      "key": key,
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "read": false,
      "time": DateTime.now(),
    });
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.uid)
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('ImgChat')
        .doc(fileName)
        .set({
      "user": widget.myName,
      "link": response.secureUrl,
      "key": key,
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "read": false,
      "time": DateTime.now(),
    });
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.uid)
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "time": DateTime.now(),
      "read": true,
    });
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chats")
        .doc(widget.uid)
        .update({
      "time": DateTime.now(),
    });
    //send notification
    LocalNotificationService.sendPushMessage(
        "${widget.myName} Sends you an Image", "Message", userData1['token']);
    setState(() {
      isLoading = false;
    });

    Utils.toastMessage("complete");

    log(response.secureUrl!);
  }

  bool sending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: CupertinoButton(
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor ==
                        Colors.white
                    ? Colors.black
                    : Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,

        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    widget.imagepath.path.isEmpty
                        ? Container()
                        : InteractiveViewer(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken),
                                    image:
                                        FileImage(File(widget.imagepath.path)),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // height: 40,
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            child: sending
                                ? _buildSendFileStatus(task!)
                                : Container(),
                          ),
                          Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            color: Theme.of(context)
                                .bottomNavigationBarTheme
                                .backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(
                                    milliseconds: 500,
                                  ),
                                  width: MediaQuery.of(context).size.width - 87,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: TextFormField(
                                    maxLines: 2,
                                    controller: _title,
                                    minLines: 1,
                                    maxLength: 100,
                                    // autofocus: true,
                                    autocorrect: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Secret Message...',
                                        prefixIcon: Icon(
                                            Icons.closed_caption_outlined)),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  child: CupertinoButton(
                                    onPressed: () async {
                                      log('tap');
                                      if (_title.text.isNotEmpty) {

                                        String StegoImg = await encrypt();

                                        uploadImage(
                                          StegoImg,
                                          widget.Secretkey,
                                        ).then((value) {
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        Utils.toastMessage(
                                            'please enter secret message !');
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      child: CircleAvatar(
                                        radius: 19,
                                        backgroundColor: Colors.blue,
                                        child: Center(
                                          child: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ));
  }

//   Widget _buildSendFileStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
//         stream: task.snapshotEvents,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final snap = snapshot.data!;
//             final progress = snap.bytesTransferred / snap.totalBytes;
//             final percentage = (progress * 100).toStringAsFixed(2);
//             return Column(
//               children: [
//                 Stack(
//                   children: [
//                     percentage == '100.00'
//                         ? SizedBox(
//                             height: 200,
//                             width: 200,
//                             child: Icon(
//                               Icons.done_outline_rounded,
//                               size: 100,
//                               color: Colors.green,
//                             ))
//                         : SizedBox(
//                             height: 200,
//                             width: 200,
//                             child: CircularProgressIndicator(
//                               color: Colors.grey,
//                               value: 1,
//                               strokeWidth: 8.0,
//                             ),
//                           ),
//                     SizedBox(
//                       height: 200,
//                       width: 200,
//                       child: CircularProgressIndicator(
//                         color: Colors.green,
//                         value: progress,
//                         strokeWidth: 8.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   '${(snap.bytesTransferred / 1000000).toStringAsFixed(2)}/${(snap.totalBytes / 1000000).toStringAsFixed(2)}MB ($percentage%)',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             );
//           } else {
//             return const SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: CircularProgressIndicator(
//                   color: Colors.green,
//                   // value: progress,
//                   strokeWidth: 8.0,
//                 ));
//           }
//         },
//       );
// }

  Widget _buildSendFileStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width - 70,
                    child: LinearProgressIndicator(
                      // color: kPrimaryColor,
                      value: progress,
                    ),
                  ),
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          } else {
            return Container(
                color: Colors.transparent,
                height: 10,
                child: LinearProgressIndicator());
          }
        },
      );
}
