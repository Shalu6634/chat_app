
import 'dart:io';

import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/services/storage_image_folder/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../modal/cloud_modal.dart';
import '../../services/cloud_firestore_services.dart';
import '../../utils/global.dart';


File? fileImage;
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: FutureBuilder(
        future:
            CloudFireStoreServices.cloudFireStoreServices.readCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff1f6563),
              ),
            );
          }

          Map? data = snapshot.data!.data();
          UserModal userModal = UserModal.fromMap(data!);
          return Column(
            children: [

              DrawerHeader(
                child: CircleAvatar(
                    radius: 70,
                    backgroundImage: (fileImage != null)
                        ? NetworkImage(FileImage(fileImage!).toString())
                        : const NetworkImage(
                            ''),
                    child: Stack(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 90, left: 100),
                          child: GestureDetector(
                            onTap: () async {
                               ImagePicker imagePicker= ImagePicker();
                               XFile? file =await  imagePicker.pickImage(source: ImageSource.gallery);
                                 fileImage =  File(file!.path);
                                 print(fileImage);

                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.teal),
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: ListTile(
                  leading: const Icon(Icons.person_outline_outlined),
                  title: const Text(
                    "Name   ",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  subtitle: Text(
                    userModal.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  trailing: const Icon(
                    Icons.mode_edit_outlined,
                    color: Color(0xff1f6563),
                  ),
                ),
              ),
              const Divider(
                thickness: 0.5,
                endIndent: 25,
                indent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: const Text(
                    "Email - id   ",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  subtitle: Text(
                    userModal.email!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  trailing: const Icon(
                    Icons.mode_edit_outlined,
                    color: Color(0xff1f6563),
                  ),
                ),
              ),
              const Divider(
                thickness: 0.5,
                endIndent: 25,
                indent: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: ListTile(
                  leading: const Icon(Icons.local_phone_outlined),
                  title: const Text(
                    "Phone   ",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  subtitle: Text(
                    userModal.phone!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
