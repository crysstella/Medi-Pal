import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';
import '../../blocs/log_in_bloc/log_in_bloc.dart';
import '../../components/my_text_field.dart';
import '../../components/strings.dart';
import '../Profile/profile.dart'; 

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key,}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordToggle = true;
  String? _errorMsg;
  bool logInRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInBloc, LogInState>(
      listener: (context, state) {
  if (state is LogInSuccess) {
    setState(() {
      logInRequired = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(email: emailController.text),
      ),
    );
  } else if (state is LogInProcess) {
    setState(() {
      logInRequired = true;
    });
  } else if (state is LogInFailure) {
    setState(() {
      logInRequired = false;
      _errorMsg = 'Please re-check your email or password';
    });
  }
},
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: emailController,
                hintText: 'E-mail',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(UniconsLine.envelope),
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!emailRexExp.hasMatch(val)) {
                    return 'Please enter a valid e-mail';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: passwordToggle,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(UniconsLine.lock),
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!passwordRexExp.hasMatch(val)) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordToggle = !passwordToggle;
                      if (passwordToggle) {
                        const Icon(UniconsLine.eye);
                      } else {
                        const Icon(UniconsLine.eye_slash);
                      }
                    });
                  },
                  icon: const Icon(UniconsLine.eye_slash),
                ),
              ),
            ),
            const SizedBox(height: 40),
            !logInRequired
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LogInBloc>().add(LogInRequired(
                                emailController.text,
                                passwordController.text,
                              ));
                        }
                      },
                      style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor:
                            Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 5,
                        ),
                        child: Text(
                          'Log In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
