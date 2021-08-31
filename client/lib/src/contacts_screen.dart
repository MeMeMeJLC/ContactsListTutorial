import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'contacts_listing.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List contacts = [];

  void _addContact() {
    final faker = Faker();
    final person = faker.person;
    final fullName = '${person.firstName()} ${person.lastName()}';

    setState(() {
      contacts.add({'name': fullName});
    });
  }

  void _deleteContact(String id) {
    setState(() {
      contacts.removeWhere((contact) => contact['name'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ContactsListing(
        contacts: contacts,
        onAdd: _addContact,
        //onDelete: _deleteContact,
        
        /*════════ Exception caught by widgets library ═══════════════════════════════════
The following assertion was thrown building ContactsListing(dirty):
setState() or markNeedsBuild() called during build.

This ContactsScreen widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
The widget on which setState() or markNeedsBuild() was called was: ContactsScreen
    state: _ContactsScreenState#8eb96
The widget which was currently being built when the offending call was made was: ContactsListing
    dirty
The relevant error-causing widget was
ContactsListing
package:contacts_app_client/src/contacts_screen.dart:41
When the exception was thrown, this was the stack
*/
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Refresh List',
            backgroundColor: Colors.purple,
            child: Icon(Icons.refresh),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _addContact,
            tooltip: 'Add new contact',
            child: Icon(Icons.person_add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ),
    );
  }
}
