import 'package:contact_dairy_app/helpers/providers/contact_provider.dart';
import 'package:contact_dairy_app/helpers/providers/theme_provider.dart';
import 'package:contact_dairy_app/models/contact_model.dart';
import 'package:contact_dairy_app/views/screens/add_contactpage.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    ContactProvider obj=Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () async{

                LocalAuthentication localAuthentication= LocalAuthentication();

          bool isBiometricAvailable= await localAuthentication.canCheckBiometrics;

          bool isDeviceSupported=await localAuthentication.isDeviceSupported();

          if(isBiometricAvailable || isDeviceSupported){

         bool isAuthenticated=await localAuthentication.authenticate(
              localizedReason: "Please provide your authenticity");

           if(isAuthenticated == true){
             Navigator.of(context).pushNamed('hidden_contact_page');
           }
           else{
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                     content:Text("Authentication is wrong")
                 ));
           }
          }
          else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
              content:Text("Authentication is not supported")
          ));
          }

                Navigator.of(context).pushNamed('hidden_contact_page');
              },
              icon: Icon(Icons.lock)
          ),
          IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context,listen: false).changetheme();
              }, icon: Icon(Icons.dark_mode)
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed('add_contactpage');
      },
      child: Icon(Icons.add),),

      body: ListView.builder(
        padding: EdgeInsets.all(12.0),
          itemCount: obj.allcontact.length,
          itemBuilder: (context,i){
            return Card(
              elevation: 5,
              shadowColor: Colors.blue,
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'detail_screen_page',arguments: obj.allcontact[i]);
                },
                trailing: Row(
                  mainAxisAlignment:MainAxisAlignment.end ,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {
                      showDialog(context: context,
                          builder:(context){
                        return AlertDialog(
                          actions: [
                          TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Last Name',
                              labelText: 'Enter First Name'
                          ),
                          ),
                            TextField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Last Name',
                                  labelText: 'Enter Last Name'
                              ),
                            ),TextField(
                              controller: contactNumberController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Contact Number',
                                  labelText: 'Enter Contact Number'
                              ),
                            ),TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Email',
                                  labelText: 'Enter Email'
                              ),
                            ),TextField(
                              controller: websiteController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Website',
                                  labelText: 'Enter website'
                              ),
                            ),
                            TextButton(onPressed: () {
                              Contact contact=Contact(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  contactNumber: contactNumberController.text,
                                  website: websiteController.text);

                              Provider.of<ContactProvider>(context,listen: false).updatecontact(data: contact,id: i);
                              firstNameController.clear();
                              lastNameController.clear();
                              contactNumberController.clear();
                              emailController.clear();
                              websiteController.clear();
                            },
                                child: Text("Edit"))
                          ],
                        );
                          });
                    },
                        icon: Icon(Icons.edit)
                    ),
                    IconButton(onPressed: () {
                      obj.deletecontact(data: obj.allcontact[i]);
                    },
                        icon: Icon(Icons.delete))
                  ],
                ),
                isThreeLine: true,
                leading: Text("${i+1}"),
                title: Text("${obj.allcontact[i].firstName}"),
                subtitle: Text("+91 ${obj.allcontact[i].contactNumber}\n${obj.allcontact[i].website}"),

              ),
            );
          }
      ),

    );
  }
}
