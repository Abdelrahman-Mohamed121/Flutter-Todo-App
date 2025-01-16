import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/validator.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController =
      TextEditingController(text: 'emilys');
  final TextEditingController _passwordController =
      TextEditingController(text: 'emilyspass');

  LoginScreen({super.key});

  void onLoginClick(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      await context
          .read<AuthProvider>()
          .login(_usernameController.text, _passwordController.text);
      if (context.mounted &&
          context.read<AuthProvider>().isAuthenticated == true) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Successful'),
          backgroundColor: Colors.green,
        ));
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid Credentials'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in all fields correctly')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Padding(
            padding: defaultPadding,
            child: Container(
              padding: defaultPadding,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: defaultBorder),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline_rounded, size: 80),
                  defaultVerticalSizedBox,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      defaultHorizontalSizedBox,
                      Icon(Icons.waving_hand_rounded),
                    ],
                  ),
                  defaultVerticalSizedBox,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smallVerticalSizedBox,
                        TextFormField(
                          controller: _usernameController,
                          validator: Validator.validateUsername,
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderRadius: defaultBorder),
                            labelText: "Username",
                          ),
                        ),
                        defaultVerticalSizedBox,
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          validator: Validator.validateUsername,
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderRadius: defaultBorder),
                            labelText: "Password",
                          ),
                        ),
                        smallVerticalSizedBox,
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: defaultBorder),
                            elevation: 0.0,
                            minimumSize: Size(double.infinity, 50.0),
                          ),
                          onPressed: () {
                            onLoginClick(context);
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
