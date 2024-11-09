import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/services_or_auth/authService.dart';
import 'package:provider/provider.dart';

import 'Chat_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //instance of auth
  final FirebaseAuth _auth =  FirebaseAuth.instance;
  //sign user out
  void signOut(){
    //get auth Service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home'),
        backgroundColor: Colors.black12,
        actions: [
          //sign out button
          IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _buildUserList(),
    );
  }
  //build a list of user except for the current logged in user
Widget _buildUserList(){
   return StreamBuilder<QuerySnapshot>(
       stream: FirebaseFirestore.instance.collection('user').snapshots(),
       builder: (context,snapshot){
         if(snapshot.hasError){
         return const Text('error');
        }
         if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
            }

            return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc)=> _buildUserListitem(doc))
                .toList(),
            );
         },
      );
    }
    //build individual user list items
    Widget _buildUserListitem(DocumentSnapshot document) {
    Map<String,dynamic> data = document.data()! as Map<String,dynamic>;

    //display all user except current user
      if(_auth.currentUser!.email != data['email'] ){
        return ListTile(
          title: Text(data['email']),
          onTap: (){
            //pass the clicked user UID to the chat page
            Navigator.push(
                context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                ),
                )
            );
          },
        );

      }else{
        //return empty container
        return Container();
      }
    }
  }

