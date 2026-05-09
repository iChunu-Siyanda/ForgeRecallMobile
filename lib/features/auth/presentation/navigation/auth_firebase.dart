import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forge_recall/features/auth/presentation/navigation/login_or_register.dart';
import 'package:forge_recall/features/dashboard/presentation/pages/dashboard.dart';

class AuthFirebase extends StatelessWidget {
  const AuthFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>( 
        stream: FirebaseAuth.instance.authStateChanges(), //Stream checks if user is logged in or not
        builder: (context,snapshot) {
          //Home page if user logged in
          if (snapshot.hasData){
            return Dashboard();
          }

          //Login or register if user not logged in
          else{
            return LoginOrRegister();
          }
        }
      ),
    );
  }
}