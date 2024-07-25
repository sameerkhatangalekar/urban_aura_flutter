import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/features/auth/presentation/bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool isObscured = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocListener<AuthBloc, AuthState>(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formState,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/logo.svg',
                        theme: const SvgTheme(
                          currentColor: Colors.white,
                        ),
                        height: 78,
                      )
                          .animate()
                          .fadeIn(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeIn)
                          .then()
                          .shimmer(
                        duration: const Duration(milliseconds: 800),
                        colors: [
                          Colors.white,
                          AppPalette.secondaryColor,
                          Colors.white
                        ],
                      ),
                      const SpacerBox(
                        height: 52,
                      ),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                      ),
                      const SpacerBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: isObscured,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                    () {
                                  isObscured = !isObscured;
                                },
                              );
                            },
                            icon: Icon(isObscured
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          if (value.length < 4) {
                            return 'Password must contain 4 or more characters';
                          }
                          return null;
                        },
                      ),
                      const SpacerBox(
                        height: 52,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: size.width * 0.5,
                          maxWidth: size.width * 0.5,
                        ),
                        child: TextButton.icon(
                          style: ButtonStyle(
                            overlayColor:
                            WidgetStatePropertyAll<Color>(Colors.grey.shade500),
                            iconColor: const WidgetStatePropertyAll<Color>(
                              Colors.black,
                            ),
                            backgroundColor: const WidgetStatePropertyAll<Color>(
                              Colors.white,
                            ),
                            shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            splashFactory: InkSparkle.splashFactory,
                          ),
                          onPressed: () async {
                            if (formState.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                SigninEvent(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(
                            Icons.key_sharp,
                          ),
                          label: const Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                        onPressed: () {
                          context.push(
                            '/signup',
                          );
                        },
                        iconAlignment: IconAlignment.end,
                        child: const Text(
                          'New user? Sign up',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          listener: (context, state) {
            if (state is LoadingState) {
              LoadingDialog().show(
                context: context,
                text: 'Logging in',
              );
            }
            if (state is SigninFailedState) {
              LoadingDialog().hide();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    maxLines: 4,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
            if (state is SigninSuccessfulState) {
              LoadingDialog().hide();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Logged in successfully',
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ));
  }
}
