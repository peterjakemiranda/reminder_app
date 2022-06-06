import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reminder_app/screens/home/homescreen.dart';
import 'package:reminder_app/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback toggleView;
  const SignInScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton.icon(
              icon: Icon(Icons.account_circle_outlined),
              onPressed: () {
                widget.toggleView();
              },
              label: Text('Sign Up'),
            )
          ],
        ),
        body: Column(
          children: [
            Lottie.asset('assets/images/calendar.json', width: 175),
            Text('Yet another Todo list',
                style: Theme.of(context).textTheme.headline6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: 'Enter email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) => val == null || !val.contains('@')
                            ? 'Enter a valid email address'
                            : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: 'Enter password'),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Enter atleast 6 characters'
                            : null,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final user = await AuthService()
                                  .signInUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                              if (user != null) {
                                print(user);
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => HomeScreen()),
                                // );
                              }
                            }
                          },
                          child: Text('Sign In'))
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
