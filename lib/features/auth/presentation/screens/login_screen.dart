import 'package:flutter/material.dart';
import 'package:smart_folder_mobile_app/constants/app_routes.dart';

import '../widgets/input_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 30,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Smart \n  Organizer",
                style: TextStyle(
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 10,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                child: Column(
                  spacing: 20,
                  children: [
                    inputFields(
                      context: context,
                      icon: Icons.email_outlined,
                      hintText: "Email address",
                      labelText: "Email",
                    ),
                    inputFields(
                      context: context,
                      icon: Icons.lock_outline_rounded,
                      hintText: "Password",
                      labelText: "Password",
                      obscure: true,
                    ),
                    FilledButton.tonal(
                      onPressed: () {},
                      child: Text(
                        "Login",
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text("Sign up"),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.registerScreen),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
