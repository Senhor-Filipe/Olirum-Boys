import 'package:flutter/material.dart';
import 'package:flutter_front_end/models/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  User user = User(userId: 0, username: "", pwd: "");

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width*0.6,
      height: screenSize.height,
      color: Colors.black45,

      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              width: constraints.maxWidth,
              child: Center(
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => user.username = input!.toString(),
                        decoration: const InputDecoration(
                          hintText: "Username",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => user.pwd = input!.toString(),
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          //TODO login http request
                        },
                        child: const Center(
                          child: Text(
                              "Login"
                          ),
                        ),
                      )
                    ],
                  )
                ),
              )
          );
        },
      )
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}