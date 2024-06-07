import 'package:flutter/material.dart';

class CompanyInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Company Info'),
      content: Text(
        'Company: Geeksynergy Technologies Pvt Ltd\n'
        'Address: Sanjayanagar, Bengaluru-56\n'
        'Phone: XXXXXXXXX09\n'
        'Email: XXXXXX@gmail.com',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    );
  }
}
