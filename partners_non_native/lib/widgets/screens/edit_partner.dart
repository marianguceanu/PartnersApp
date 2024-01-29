import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partners_non_native/models/partner.dart';
import 'package:partners_non_native/service/server_service.dart';
import 'package:partners_non_native/service/partner_service.dart';

class EditPartner extends StatefulWidget {
  final Partner partner;
  final String title;

  EditPartner({required Key key, required this.partner, required this.title})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditPartnerState createState() => _EditPartnerState();
}

class _EditPartnerState extends State<EditPartner> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _ownerPhoneNoController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.partner.name;
    _emailController.text = widget.partner.email;
    _phoneNoController.text = widget.partner.phoneNo;
    _ownerPhoneNoController.text = widget.partner.ownerPhoneNo;
    _addressController.text = widget.partner.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneNoController,
                decoration: InputDecoration(labelText: 'Phone No'),
              ),
              TextField(
                controller: _ownerPhoneNoController,
                decoration: InputDecoration(labelText: 'Owner Phone No'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Create a new partner and add it to the service
                  final newPartner = Partner(
                    id: widget.partner.id,
                    name: _nameController.text,
                    email: _emailController.text,
                    phoneNo: _phoneNoController.text,
                    address: _addressController.text,
                    ownerPhoneNo: _ownerPhoneNoController.text,
                  );
                  await ServerService.updatePartner(newPartner)
                      .then<void>((value) {
                    if (value != 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Partner updated successfully'),
                        ),
                      );
                    } else {
                      log('Partner update failed');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Partner update failed'),
                        ),
                      );
                    }
                    Navigator.pop(context);
                  });

                  // Go back to the partner list screen
                },
                child: Text('Save'),
              ),
            ],
          )),
    );
  }
}
