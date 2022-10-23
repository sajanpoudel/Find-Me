import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:mobileapp/components/coustom_bottom_nav_bar.dart';
import 'package:mobileapp/enums.dart';

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class UploadItem extends StatefulWidget {
  static String routeName = "/upload";
  const UploadItem({Key? key}) : super(key: key);

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? title;
  String? description;
  String? uploader;
  String? contact;
  final texEditingControllertitle = TextEditingController();
  final textEditingControllerdescription = TextEditingController();
  final TextEditingControlleruploader = TextEditingController();
  final TextEditingControllercontact = TextEditingController();
  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref('lost_items/$fileName').putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'item_name': title!,
              'uploaded_by': uploader!,
              'contact_info': contact!,
              'description': description!
            }));

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
  }

  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref('lost_items/').list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "item_name": fileMeta.customMetadata?['item_name'] ?? 'no name',
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'No uploader',
        "contact_info": fileMeta.customMetadata?['contact_info'] ?? 'No info',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.favourite),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                  child: Text(
                "Upload Any Items You Have Found",
                style: TextStyle(
                    fontFamily: 'Caveat',
                    letterSpacing: 1.5,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              )),
              const SizedBox(
                height: 20.0,
              ),

              //Item Name
              TextField(
                controller: texEditingControllertitle,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  title = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(labelText: "Item Name"),
              ),
              const SizedBox(
                height: 8.0,
              ),

              //Uploaded By
              TextField(
                controller: TextEditingControlleruploader,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  uploader = value;

                  //Do something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Found By'),
              ),
              const SizedBox(
                height: 8.0,
              ),

              ///contact info
              TextField(
                controller: TextEditingControllercontact,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  contact = value;

                  //Do something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(labelText: 'Contact Info'),
              ),
              const SizedBox(
                height: 8.0,
              ),

              ///description
              TextField(
                controller: textEditingControllerdescription,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  description = value;

                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Item Description'),
              ),

              /////////////////////////////

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () => _upload('camera'),
                      icon: const Icon(Icons.camera),
                      label: const Text('camera')),
                  ElevatedButton.icon(
                      onPressed: () {
                        _upload('gallery');
                        texEditingControllertitle.clear();
                        TextEditingControllercontact.clear();
                        TextEditingControlleruploader.clear();
                        textEditingControllerdescription.clear();
                        //  setState(() {
                        //    title ='';
                        //    description ='';
                        //  });
                      },
                      icon: const Icon(Icons.library_add),
                      label: const Text('Gallery')),
                ],
              ),
              //////////////////////////////////

              /////////////////////////////
              Expanded(
                child: FutureBuilder(
                  future: _loadImages(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> image =
                              snapshot.data![index];

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              dense: false,
                              leading: Image.network(image['url']),
                              title: Text(image['item_name'],
                                  style: const TextStyle(color: Colors.black)),
                              subtitle: Text(image['uploaded_by'],
                                  style: const TextStyle(color: Colors.black)),
                              trailing: IconButton(
                                onPressed: () => _delete(image['path']),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
