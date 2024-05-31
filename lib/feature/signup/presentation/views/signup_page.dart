import 'package:authentication_app/core/service/navigation/routes/routes.dart';
import 'package:authentication_app/core/widgets/green_line.dart';
import 'package:authentication_app/core/widgets/password_field_provider.dart';
import 'package:authentication_app/feature/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});
  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  ({
    bool firstName,
    bool lastName,
    bool email,
    bool password
  }) enableButtonNotifier =
      (firstName: false, lastName: false, email: false, password: false);

  @override
  void initState() {
    super.initState();
    firstName.addListener(
      () {
        setState(() {
          enableButtonNotifier = (
            firstName: firstName.text.isNotEmpty,
            lastName: lastName.text.isNotEmpty,
            email: email.text.isNotEmpty,
            password: password.text.isNotEmpty,
          );
        });
      },
    );
    lastName.addListener(
      () {
        setState(() {
          enableButtonNotifier = (
            firstName: firstName.text.isNotEmpty,
            lastName: lastName.text.isNotEmpty,
            email: email.text.isNotEmpty,
            password: password.text.isNotEmpty,
          );
        });
      },
    );
    email.addListener(
      () {
        setState(() {
          enableButtonNotifier = (
            firstName: firstName.text.isNotEmpty,
            lastName: lastName.text.isNotEmpty,
            email: email.text.isNotEmpty,
            password: password.text.isNotEmpty,
          );
        });
      },
    );
    password.addListener(
      () {
        setState(() {
          enableButtonNotifier = (
            firstName: firstName.text.isNotEmpty,
            lastName: lastName.text.isNotEmpty,
            email: email.text.isNotEmpty,
            password: password.text.isNotEmpty,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpControllerProvider);
    ref.listen(signUpControllerProvider, (_, next) {
      if (next.value ?? false) {
        context.pushNamed(
          Routes.emailConfirmation,
          pathParameters: {'email': email.text, 'previousPage': 'signup'},
        );
      } else if (next.hasError && !next.isLoading) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('User already exists'),
              content: const Text('Please Login'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Stack(
                children: [
                  Text(
                    'Signup with email',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Underline(right: 80),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Get chatting with friends and family today by\n signing up for our chat app!',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First Name',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(hintText: 'Enter first name'),
                    controller: firstName,
                  )
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Name',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(hintText: 'Enter last name'),
                    controller: lastName,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Enter email'),
                    controller: email,
                  )
                ],
              ),
              const SizedBox(height: 40),
              PasswordFieldProvider(
                text: 'Password',
                hintText: 'Enter password',
                controller: password,
              ),
              const Spacer(),
              TextButton(
                style: !(enableButtonNotifier.firstName &
                        enableButtonNotifier.lastName &
                        enableButtonNotifier.email &
                        enableButtonNotifier.password)
                    ? const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xFFF3F6F6),
                        ),
                        minimumSize: WidgetStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      )
                    : const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 97, 145, 122),
                        ),
                        minimumSize: WidgetStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                onPressed: (enableButtonNotifier.firstName &
                        enableButtonNotifier.lastName &
                        enableButtonNotifier.email &
                        enableButtonNotifier.password)
                    ? () {
                        ref.read(signUpControllerProvider.notifier).signup(
                              firstName: firstName.text,
                              lastName: lastName.text,
                              email: email.text,
                              password: password.text,
                            );
                      }
                    : null,
                child: (state.isLoading)
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.white)
                    : Text(
                        'Create an account',
                        style: (enableButtonNotifier.firstName &
                                enableButtonNotifier.lastName &
                                enableButtonNotifier.email &
                                enableButtonNotifier.password)
                            ? const TextStyle(
                                color: Color.fromARGB(255, 234, 237, 236))
                            : const TextStyle(color: Color(0xFF797C7B)),
                      ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Text('Already have an account? Login',
                    style: Theme.of(context).textTheme.displaySmall),
                onTap: () => GoRouter.of(context).pushNamed(Routes.login),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
