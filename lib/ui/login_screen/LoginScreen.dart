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
                    color: Color(0xFF5DB075),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    27), //the padding on figma file cause an alignment problem with the rest of the form, so I increased it. Yet testing on different screen sizes/densities affected the alignment.
                            // An approach which maintained alignment , that I used in the first push is covering everyhting with  padding. So irrespective of screen size, the alihnment is maintained.
                            child: Text(
                              textAlign: TextAlign.start,
                              "Login to your account",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 343,
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
                                  vertical: 16, horizontal: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Email"),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 343,
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
                                  vertical: 16, horizontal: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Password",
                              suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  child: const Text(
                                    "Show",
                                    style: TextStyle(color: Color(0xFF5DB075)),
                                  ))),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 343,
                            height: 51,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5DB075),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10)),
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
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
                        "Forgot your password?",
                        style: TextStyle(
                            color: Color(0xFF5DB075),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
