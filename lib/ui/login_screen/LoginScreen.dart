import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rridefraser/ui/feed_screen/FeedScreen.dart';
import 'package:rridefraser/ui/login_screen/LoginBloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginBloc my_bloc = context.read<LoginBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showDialog(
              context: context,
              barrierDismissible:
                  false, // User cannot dismiss the dialog by tapping outside
              builder: (BuildContext context) {
                return const Dialog(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 55, 237, 91),
                  )),
                );
              },
            );
          } else if (state is LoginCompletedState) {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return BlocProvider.value(
                value: my_bloc..add(OnRetrieveEvent()),
                child: const FeedScreen(),
              );
            }));
          } else if (state is LoginFailedState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else {}
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const Row(
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      "Login to your account",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  color: const Color.fromARGB(255, 244, 244, 244),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == "") {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Email"),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: const Color.fromARGB(255, 244, 244, 244),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == "") {
                        return "Please enter a password";
                      }
                      return null;
                    },
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Password",
                        suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: const Text("Show"))),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 30, 176, 61),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10)),
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              my_bloc.add(OnLoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                              emailController.clear();
                              passwordController.clear();
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Forgot your password",
                  style: TextStyle(color: Color.fromARGB(255, 30, 176, 61)),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
