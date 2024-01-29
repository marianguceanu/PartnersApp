import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partners_non_native/connection/connectivity.dart';
import 'package:partners_non_native/connection/websocket.dart';
import 'package:partners_non_native/service/server_service.dart';
import 'package:partners_non_native/service/partner_service.dart';
import 'package:partners_non_native/widgets/partner_card/partner_card.dart';
import 'package:partners_non_native/widgets/screens/add_partner.dart';
import 'package:partners_non_native/widgets/screens/edit_partner.dart';

class PartnerListScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PartnerListScreenState createState() => _PartnerListScreenState();
}

class _PartnerListScreenState extends State<PartnerListScreen> {
  ConnectionStatusManager connectionStatus =
      ConnectionStatusManager.getInstance();

  Widget onServer() {
    return ListView.builder(
      itemCount: ServerService.getPartnerCount(),
      itemBuilder: (context, index) {
        return PartnerCard(
            partner: ServerService.getPartner(index),
            deletePartner: (int id) {
              ServerService.deletePartner(id).then<void>((value) {
                if (value != 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Partner deleted successfully"),
                  ));
                } else {
                  log("Partner not deleted");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Partner not deleted"),
                    ),
                  );
                }
                setState(() {});
              });
            },
            updatePartner: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPartner(
                          key: UniqueKey(),
                          partner: ServerService.getPartner(index),
                          title: "Edit Partner",
                        )),
              ).then<void>((value) => setState(() {}));
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partner List'),
      ),
      body: onServer(),
      floatingActionButton: TextButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPartnerScreen()),
          ).then<void>((value) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
