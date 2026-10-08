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

/// The detail page.
class DetailPage extends StatelessWidget {
  final String? imgUrl;
  final String? itemName;
  final String? foundby;
  final String? contact;
  final String? des;
  const DetailPage(
      {Key? key,
      this.imgUrl,
      this.itemName,
      this.foundby,
      this.contact,
      this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(itemName ?? 'Item')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (imgUrl != null)
                Image.network(
                  imgUrl!,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailRow(label: 'Item Name: ', value: itemName),
                        const SizedBox(height: 3.0),
                        DetailRow(label: 'Found By: ', value: foundby),
                        const SizedBox(height: 3.0),
                        DetailRow(label: 'Contact: ', value: contact),
                        const SizedBox(height: 3.0),
                        Text(des ?? '', style: ktextStyle),
                        const SizedBox(height: 40.0),
                        Text("Contact Now If It Belongs To You",
                            style: ktextStyle),
                        const SizedBox(height: 15.0),
                        Center(child: _callButton()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The call button. It is switched off when the finder left no number.
  Widget _callButton() {
    final number = contact?.trim() ?? '';
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        disabledBackgroundColor: Colors.grey,
      ),
      onPressed: number.isEmpty
          ? null
          : () async {
              await FlutterPhoneDirectCaller.callNumber(number);
            },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Call Now", style: TextStyle(fontSize: 25.0)),
          SizedBox(width: 15.0),
          Icon(Icons.call, size: 25.0),
        ],
      ),
    );
  }
}

/// One line of the detail card: a label and its value.
class DetailRow extends StatelessWidget {
  const DetailRow({super.key, required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: ktextStyle),
        Expanded(child: Text(value ?? '', style: ktextStyle)),
      ],
    );
  }
}
