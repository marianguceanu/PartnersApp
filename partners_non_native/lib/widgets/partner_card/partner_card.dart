import 'package:flutter/material.dart';
import 'package:partners_non_native/models/partner.dart';

class PartnerCard extends StatefulWidget {
  final Partner? partner;
  final Function? deletePartner;
  final Function? updatePartner;
  PartnerCard(
      {super.key,
      required this.partner,
      required this.deletePartner,
      required this.updatePartner});

  @override
  // ignore: library_private_types_in_public_api
  _PartnerCardState createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${widget.partner?.name ?? ""}"),
            SizedBox(height: 8),
            Text("Email: ${widget.partner?.email ?? ""}"),
            SizedBox(height: 8),
            Text("Phone number: ${widget.partner?.phoneNo ?? ""}"),
            SizedBox(height: 8),
            Text("Address: ${widget.partner?.address ?? ""}"),
            SizedBox(height: 8),
            Text("Owner phone number: ${widget.partner?.ownerPhoneNo ?? ""}"),
            SizedBox(height: 8),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      widget.updatePartner!();
                    },
                    child: Icon(Icons.edit)),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete Partner"),
                              content: Text(
                                  "Are you sure you want to delete this partner?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      widget.deletePartner!(widget.partner?.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No"))
                              ],
                            );
                          });
                    },
                    child: Icon(Icons.delete))
              ],
            )
          ],
        ));
  }
}
