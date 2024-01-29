import 'dart:convert';

import 'package:partners_non_native/constants/app_constants.dart';
import 'package:partners_non_native/models/partner.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class ServerService {
  static List<Partner> _partners = [];

  static int getPartnerCount() {
    return _partners.length;
  }

  // Function used to load partners from the server
  static Future<List<Partner>> getPartners() async {
    final resp = await dio.get(
      '${AppConstants.serverUrl}/get/all',
    );

    if (resp.statusCode == 200) {
      final partners = resp.data as List<dynamic>;
      _partners = partners.map((p) => Partner.fromJson(p)).toList();
      return _partners;
    } else {
      throw Exception('Failed to load partners');
    }
  }

  // Function used to load a partner from the server
  static Partner getPartner(int index) {
    return _partners[index];
  }

  // Function used to add a partner to the server
  static Future<int> addPartner(Partner partner) async {
    print(jsonEncode(partner.toMap()));
    partner.id = 0;
    final resp = await dio.post(
      '${AppConstants.serverUrl}/add',
      options: Options(
        followRedirects: false,
        headers: {'content-type': 'application/json', 'accept': 'text/plain'},
      ),
      data: jsonEncode(partner.toMap()),
    );
    final id = resp.data['id'] as int;
    partner.id = id;
    _partners.add(partner);
    return _partners.firstWhere((p) => p.id == id).id;
  }

  // Function used to update a partner on the server
  static Future<int> updatePartner(Partner partner) async {
    final resp = await dio.put(
      '${AppConstants.serverUrl}/update/${partner.id}',
      options: Options(
        validateStatus: (status) => true,
        followRedirects: false,
        headers: {'Content-Type': 'application/json', 'accept': 'text/plain'},
      ),
      data: jsonEncode(partner.toMap()),
    );
    if (resp.statusCode == 200) {
      final id = resp.data['id'] as int;
      partner.id = id;
      final index = _partners.indexWhere((p) => p.id == partner.id);
      if (index != -1) {
        _partners[index] = partner;
      }
      return id;
    } else {
      throw Exception('Failed to update partner');
    }
  }

  // Function used to delete a partner from the server
  static Future<int> deletePartner(int id) async {
    final resp = await dio.delete(
      '${AppConstants.serverUrl}/delete/$id',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': "*"
        },
      ),
    );
    if (resp.statusCode == 200 || resp.statusCode == 204) {
      _partners.removeWhere((p) => p.id == id);
      return id;
    } else {
      throw Exception('Failed to delete partner');
    }
  }
}
