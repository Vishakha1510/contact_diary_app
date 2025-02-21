import 'package:contact_dairy_app/helpers/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/providers/contact_provider.dart';
import '../../models/contact_model.dart';

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController contactNumberController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController websiteController = TextEditingController();


class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {



  int initialstep=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back),
        ),
        title: Text('Add Contact Page'),
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isdark ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changetheme();
            },
          ),
        ],
      ),
      body: Column(
        spacing: 30,
        children: [
          Stepper(
              currentStep: initialstep,
              onStepContinue: (){
                setState(() {
                  if(initialstep < 1){
                    initialstep++;
                  }
                });
              },
              onStepCancel: (){
                setState(() {
                  if(initialstep > 0){
                    initialstep--;
                  }
                });
              },
              onStepTapped: (value) {
                setState(() {
                  initialstep=value;
                });
              },
              controlsBuilder: (context, controldetails) {
                return Container();
              },
              steps: [
                Step(
                    title: Text('personal info'),
                    content:Column(
                      spacing: 10,
                      children: [
                        TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter First Name here....',
                              labelText: 'First Name'
                          ),
                        ),
                        TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Last Name here....',
                              labelText: 'Last Name'
                          ),
                        )
                      ],
                    )
                ),
                Step(
                    title: Text('contact info'),
                    content:Column(
                      spacing: 10,
                      children: [
                        TextField(
                          controller: contactNumberController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Contact no. here....',
                              labelText: 'Contact No.'
                          ),
                        ),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Email here....',
                              labelText: 'Email'
                          ),
                        ),
                        TextField(
                          controller: websiteController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Website here....',
                              labelText: 'Website'
                          ),
                        ),
                      ],
                    )
                ),
              ]
          ),
          OutlinedButton(
              onPressed:(){
                Contact contact = Contact(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    contactNumber: contactNumberController.text,
                    email: emailController.text,
                    website: websiteController.text
                );
                Provider.of<ContactProvider>(context,listen: false).addcontact(data: contact);

                firstNameController.clear();
                lastNameController.clear();
                contactNumberController.clear();
                emailController.clear();
                websiteController.clear();
              } ,
              child:Text("Submit")
          )
        ],
      ),
    );
  }
}
