import 'package:chat_app/constants.dart';
import 'package:chat_app/models/masseg_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class ChatPage extends StatelessWidget {
  static String id = "chat page";
  final CollectionReference masseges =
      FirebaseFirestore.instance.collection('masseges');
  late TextEditingController controlle = TextEditingController();
  final ScrollController controller = ScrollController();
// commit from abdo
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: masseges.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List<MassegModel> massegList = [];
          for (int i = 0; i < snapShot.data!.docs.length; i++) {
            massegList.add(MassegModel.fromJosn(snapShot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    height: 50,
                  ),
                  const Text(
                    "Chat",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: controller,
                  itemCount: massegList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return massegList[index].id == email
                        ? ChatBubble(
                            masseg: massegList[index],
                          )
                        : ChatBubbleForFrinde(masseg: massegList[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  controller: controlle,
                  onSubmitted: (data) {
                    masseges.add({
                      kMasseg: data,
                      kCreatedAt: DateTime.now(),
                      "id": email,
                    });
                    controlle.clear();
                    controller.animateTo(
                      controller.position.maxScrollExtent,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
                  },
                  decoration: const InputDecoration(
                    hintText: "send masseg",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kPrimaryColor,
                    )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: kPrimaryColor,
                    )),
                    suffixIcon: Icon(
                      Icons.send,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ]),
          );
        } else {
          return ModalProgressHUD(
            inAsyncCall: true,
            progressIndicator: const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
            child: Container(),
          );
        }
      },
    );
  }
}
