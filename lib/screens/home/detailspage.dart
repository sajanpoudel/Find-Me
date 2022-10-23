import 'package:flutter/material.dart';
import 'package:mobileapp/constants.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle ktextStyle = GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        letterSpacing: 1.15,
        color: Colors.black87));

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  String? imgUrl;
  String? itemName;
  String? foundby;
  String? contact;
  String? des;
  DetailPage(
      {Key? key,
      this.imgUrl,
      this.itemName,
      this.foundby,
      this.contact,
      this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Card(
                    clipBehavior: null,
                    child: Image.network(
                      imgUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Flexible(
                    flex: 2,
                    child: Card(
                      elevation: 10.0,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Item Name: ',
                                    style: ktextStyle,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    itemName!,
                                    style: ktextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          ////
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Found By: ',
                                    style: ktextStyle,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    foundby!,
                                    style: ktextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3.0),

                          ///
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Contact: ',
                                    style: ktextStyle,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    contact!,
                                    style: ktextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 3.0),
                          //
                          Flexible(
                            flex: 1,
                            child: Text(
                              des!,
                              style: ktextStyle,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(height: 120.0),
                          Flexible(
                            child: Text(
                              "Contact Now If It Belongs To You",
                              style: ktextStyle,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor,
                              ),
                              onPressed: () async {
                                await FlutterPhoneDirectCaller.callNumber(
                                    contact!);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Call Now",
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Icon(
                                    Icons.call,
                                    size: 25.0,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
