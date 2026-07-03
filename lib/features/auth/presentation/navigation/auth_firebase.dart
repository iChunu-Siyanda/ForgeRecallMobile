import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forge_recall/core/navigation/app_routes.dart';
import 'package:forge_recall/features/auth/presentation/navigation/login_or_register.dart';
import 'package:go_router/go_router.dart';

class AuthFirebase extends StatelessWidget {
  const AuthFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>( 
        stream: FirebaseAuth.instance.authStateChanges(), //Stream checks if user is logged in or not
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          //Home page if user logged in
          if (snapshot.hasData){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(AppRoutes.projects);
            });
            
            return const Center(child: CircularProgressIndicator());
          }

          //Login or register if user not logged in
          else{
            return const LoginOrRegister();
          }
        }
      ),
    );
  }
}