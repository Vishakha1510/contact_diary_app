import 'package:contact_dairy_app/helpers/providers/contact_provider.dart';
import 'package:contact_dairy_app/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helpers/providers/theme_provider.dart';

class Detailcontactpage extends StatefulWidget {
  const Detailcontactpage({super.key});

  @override
  State<Detailcontactpage> createState() => _DetailcontactpageState();
}

class _DetailcontactpageState extends State<Detailcontactpage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ContactProvider>(context);

    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hidden Page"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ContactProvider>(context, listen: false)
                    .hidecontact(data: contact);

                Provider.of<ContactProvider>(context, listen: false)
                    .deletecontact(data: contact);

                Navigator.of(context).pop();
              },
              icon: Icon(Icons.lock)),
          IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changetheme();
              },
              icon: Icon(Icons.dark_mode)),
        ],
      ),
      body: Column(
        children: [
          Text("${contact.firstName}${contact.lastName}"),
          Text("${contact.contactNumber}"),
          Text("${contact.email}"),
          Text("${contact.website}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () async {
                    try {
                      await launchUrl(
                          Uri.parse("tel:+91${contact.contactNumber}"));
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(Icons.call)),
              IconButton(
                  onPressed: () async {
                    try {
                      await launchUrl(
                          Uri.parse("sms:+91${contact.contactNumber}"));
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(Icons.sms)),
              IconButton(
                  onPressed: () async {
                    try {
                      await launchUrl(Uri.parse("mailto:${contact.email}"));
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(Icons.email)),
              IconButton(
                  onPressed: () async {
                    try {
                      await launchUrl(Uri.parse("https:${contact.website}"));
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(Icons.web_asset)),
            ],
          )
        ],
      ),
    );
  }
}
