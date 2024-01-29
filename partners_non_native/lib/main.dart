import 'package:flutter/material.dart';
import 'package:partners_non_native/connection/connectivity.dart';
import 'package:partners_non_native/database/database.dart';
import 'package:partners_non_native/service/server_service.dart';
import 'package:partners_non_native/service/partner_service.dart';
import 'package:partners_non_native/widgets/screens/list_partner.dart';

void main() async {
  // await DbHelper.getDbConnection();
  // await partnerService.init();
  ConnectionStatusManager ins = ConnectionStatusManager.getInstance();
  ins.initialize();
  // await ServerService.initConnection();
  await ServerService.getPartners();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PartnerListScreen(),
    );
  }
}
