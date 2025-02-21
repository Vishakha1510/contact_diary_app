import 'package:contact_dairy_app/helpers/providers/contact_provider.dart';
import 'package:contact_dairy_app/helpers/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HiddenContactPage extends StatefulWidget {
  const HiddenContactPage({super.key});

  @override
  State<HiddenContactPage> createState() => _HiddenContactPageState();
}

class _HiddenContactPageState extends State<HiddenContactPage> {
  @override
  Widget build(BuildContext context) {
    ContactProvider obj=Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context,listen: false).changetheme();
              }, icon: Icon(Icons.dark_mode)
          ),
        ]
      ),
      body: ListView.builder(
        itemCount: obj.hiddencontacts.length,
          itemBuilder: (context,i){
            return Card(
              child: ListTile(
                onTap:  (){
                  Navigator.of(context).pushNamed('detail_screen_page',arguments: obj.hiddencontacts[i]);
                },
                isThreeLine: true,
                leading: Text("${i+1}"),
                title: Text("${obj.hiddencontacts[i].firstName}"),
                subtitle: Text("+91${obj.hiddencontacts[i].contactNumber}\n${obj.hiddencontacts[i].website}"),
              ),
            );
          } ),
    );
  }
}
