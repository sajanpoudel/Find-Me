import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobileapp/screens/home/detailspage.dart';
import 'package:mobileapp/screens/home/item_filter.dart';

/// The items used on the home screen.
class Items extends StatefulWidget {
  const Items({Key? key, this.query = ''}) : super(key: key);

  /// Search text. Only matching items are shown.
  final String query;

  @override
  State<Items> createState() => _ItemsState();
}

const TextStyle ktextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Caveat',
    letterSpacing: 1.15,
    color: Colors.black87);

class _ItemsState extends State<Items> {
  FirebaseStorage storage = FirebaseStorage.instance;
  late final Future<List<Map<String, dynamic>>> _items = _loadImages();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        child: FutureBuilder(
          future: _items,
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final shown = filterItems(snapshot.data ?? [], widget.query);
              if (shown.isEmpty) {
                return const Center(child: Text('No items match your search'));
              }
              return GridView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: shown.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> image = shown[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => DetailPage(
                                    imgUrl: image['url'],
                                    itemName: image['item_name'],
                                    foundby: image['uploaded_by'],
                                    contact: image['contact_info'],
                                    des: image['description'],
                                  ))));
                    },
                    child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 4,
                                child: Image.network(
                                  image['url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 11.0),
                                        child: Text(
                                          image['item_name'],
                                          style: ktextStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                },
              );
            }
            /////////
            //////
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
