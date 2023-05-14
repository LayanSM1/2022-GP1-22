import 'dart:developer';
import 'dart:io';
import 'package:application1/core/app_export.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
import 'package:path_provider/path_provider.dart';
import 'package:steganograph/steganograph.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:application1/classes/secureStorage.dart';
import 'package:application1/classes/Utils.dart';


class secretMsg extends StatefulWidget {
  String url;
  String? msg;
  String? secretKey;

  secretMsg({Key? key, this.msg, required this.url, this.secretKey})
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
  RSAPrivateKey? MyPrivateKey;
  String? EncryptedSecretKey;
  String? SecretKey;
  String? decryptedmsg;

  getMessage() async {
    var response = await http.get(Uri.parse(widget.url));
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = new File(join(documentDirectory.path, 'image.png'));
    file.writeAsBytesSync(response.bodyBytes);
    log(file.toString());
    String? embeddedMessage = await Steganograph.decode(
      image: file
      // encryptionKey: SecretKey,
    );
    print("the encrypted secret msg ");
    print(embeddedMessage);
    setState(() {
      decode = embeddedMessage;
      isLoading = false;
    });

    try {
      EncryptedSecretKey=widget.secretKey;
      final myPrivateKeyString = await userSecureStorage.getPrivateKey() ?? "";
      MyPrivateKey=RSAPrivateKey.fromString(myPrivateKeyString);
      print("my private key from secure storage ");
      print(MyPrivateKey.toString());
      print("Secret Key from database ");
      print(EncryptedSecretKey);
      print("decrypted Secret Key");
      SecretKey = MyPrivateKey?.decrypt(EncryptedSecretKey!);
      print(SecretKey);
      print("The secret msg");
      decryptedmsg =
      await FlutterAesEcbPkcs5
          .decryptString(
          decode!, SecretKey!);
      print(decryptedmsg);
    }
    catch(e) {
      print(e);
      Utils.toastMessage("Something went error, try again later !! ");

    }
  }
  Future<void> encryptSecretKey() async {
    try {
      EncryptedSecretKey=widget.secretKey;
      final myPrivateKeyString = await userSecureStorage.getPrivateKey() ?? "";
      MyPrivateKey=RSAPrivateKey.fromString(myPrivateKeyString);
      print("my private key from secure storage ");
      print(MyPrivateKey.toString());
      print("Secret Key from database ");
      print(EncryptedSecretKey);
      print("decrypted Secret Key");
      SecretKey = MyPrivateKey?.decrypt(EncryptedSecretKey!);
      print(SecretKey);
      print("The secret msg");
      print(decryptedmsg);

    }
    catch(e) {
      print(e);
      Utils.toastMessage("Something went error, try again later !! ");

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar(
            'Secret message',
            decryptedmsg.toString(),
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

            ),
    );
  }


}
