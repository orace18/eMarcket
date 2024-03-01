import 'dart:convert';
import 'package:easy_market_client/pages/chat_page/models/message_model.dart';
import 'package:easy_market_client/helpers/notification_service.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_market_client/pages/home_page/widgets/bottom_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  ShowNotification notificationService = ShowNotification();
  late IOWebSocketChannel channel; //channel varaible for websocket
  late bool connected; // boolean value to track connection status

  final myidText = GetStorage().read('id'); //my id
  String recieverid = "65c4c4a4062f4355b1ce3bb9"; //reciever id
  // swap myid and recieverid value on another mobile to test send and recieve
  String auth = "chatapphdfgjd34534hjdfk"; //auth key

  List<MessageData> msglist = [];

  TextEditingController msgtext = TextEditingController();

  @override
  void initState() {
    connected = false;
    msgtext.text = "";
    channelconnect();
    super.initState();
  }

  channelconnect() {
    //function to connect
  String myid = myidText.toString();

    try {
      channel = IOWebSocketChannel.connect(
          "ws://$webUrl/$myid"); //channel IP : Port
      channel.stream.listen(
        (message) {
          print(message);
          setState(() {
            if (message == "connected") {
              connected = true;
              setState(() {});
              print("Connection establised.");
            } else if (message == "send:success") {
              print("Message send success");
              setState(() {
                msgtext.text = "";
              });
            } else if (message == "send:error") {
              print("Message send error");
            } else if (message.substring(0, 6) == "{'cmd'") {
              print("Message data");
              message = message.replaceAll(RegExp("'"), '"');
              var jsondata = json.decode(message);

              msglist.add(MessageData(
                //on message recieve, add data to model
                msgtext: jsondata["msgtext"],
                userid: jsondata["userid"],
                isme: false,
              ));
              setState(() {
                //update UI after adding data to message model
              });
              notificationService.showNotification(jsondata["msgtext"]);
            }
          });
        },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendmsg(String sendmsg, String id) async {
  String myid = myidText.toString();

    if (connected == true) {
      String msg =
          "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
      setState(() {
        msgtext.text = "";
        msglist.add(MessageData(msgtext: sendmsg, userid: myid, isme: true));
      });
      channel.sink.add(msg); //send message to reciever channel
    } else {
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chat".tr),
        leading: Icon(Icons.circle,
            color: connected ? Colors.greenAccent : Colors.redAccent),
        //if app is connected to node.js then it will be gree, else red.
        titleSpacing: 0,
      ),
      body: Container(
          child: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 70,
              left: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      /* Container( 
                              child:Text("Your Messages", style: TextStyle(fontSize: 20)),
                            ), */
                      Container(
                          child: Column(
                        children: msglist.map((onemsg) {
                          return Container(
                              margin: EdgeInsets.only(
                                //if is my message, then it has margin 40 at left
                                left: onemsg.isme ? 40 : 0,
                                right:
                                    onemsg.isme ? 0 : 40, //else margin at right
                              ),
                              child: Card(
                                  color: onemsg.isme
                                      ? Colors.green[100]
                                      : Colors.white,
                                  //if its my message then, blue background else red background
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /*     Container(
                                                child:Text(onemsg.isme?"":"ID: " + onemsg.userid)
                                              ), */

                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Text(onemsg.msgtext,
                                              style: TextStyle(fontSize: 17)),
                                        ),
                                      ],
                                    ),
                                  )));
                        }).toList(),
                      ))
                    ],
                  )))),
          Positioned(
            //position text field at bottom of screen

            bottom: 0, left: 0, right: 0,
            child: Container(
                color: Colors.black12,
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: msgtext,
                        decoration: InputDecoration(
                            hintText: "type_message".tr,
                            border: OutlineInputBorder()),
                      ),
                    )),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          child: Icon(
                            Icons.send,
                            color: AppTheme.easyMarketMaterial,
                          ),
                          onPressed: () {
                            if (msgtext.text != "") {
                              sendmsg(msgtext.text,
                                  recieverid); //send message with webspcket
                            } else {
                              print("Enter message");
                            }
                          },
                        ))
                  ],
                )),
          )
        ],
      )),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
