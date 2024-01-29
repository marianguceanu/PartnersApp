import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partners_non_native/models/partner.dart';
import 'package:partners_non_native/service/server_service.dart';
import 'package:partners_non_native/service/partner_service.dart';

class AddPartnerScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AddPartnerScreenState createState() => _AddPartnerScreenState();
}

class _AddPartnerScreenState extends State<AddPartnerScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _ownerPhoneNoController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Partner'),
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
            FloatingActionButton(
              onPressed: () async {
                // Create a new partner and add it to the service
                final newPartner = Partner(
                  id: ServerService.getPartnerCount() + 1,
                  name: _nameController.text,
                  email: _emailController.text,
                  phoneNo: _phoneNoController.text,
                  address: _addressController.text,
                  ownerPhoneNo: _ownerPhoneNoController.text,
                );
                await ServerService.addPartner(newPartner)
                    .then<void>((value) => {
                          if (value != 0)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Partner added successfully'),
                                ),
                              ),
                            }
                          else
                            {
                              log('Failed to add partner'),
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to add partner'),
                                ),
                              ),
                            },
                          // Go back to the partner list screen
                          Navigator.pop(context)
                        });
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
