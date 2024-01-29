import 'package:partners_non_native/database/database.dart';
import 'package:partners_non_native/models/partner.dart';

class PartnerService {
  List<Partner> _partners = [];

  Future<void> init() async {
    _partners = await DbHelper.getPartners();
  }

  int getPartnerCount() {
    return _partners.length;
  }

  Partner getPartner(int pos) {
    return _partners[pos];
  }

  Future<int> addPartner(Partner partner) async {
    final id = await DbHelper.addPartner(partner);

    partner.id = id;
    _partners.add(partner);
    return id;
  }

  Future<int> updatePartner(Partner partner) async {
    int id = await DbHelper.updatePartner(partner);

    final index = _partners.indexWhere((p) => p.id == partner.id);
    if (index != -1) {
      _partners[index] = partner;
    }
    return id;
  }

  Future<int> deletePartner(int partnerId) async {
    int id = await DbHelper.deletePartner(partnerId);
    _partners.removeWhere((partner) => partner.id == partnerId);
    return id;
  }
}

final partnerService = PartnerService();
