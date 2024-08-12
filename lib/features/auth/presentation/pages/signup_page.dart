import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/bloc/auth/auth_bloc.dart';
import 'package:urban_aura_flutter/core/common/dialogs/loading_dialog.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/spacer_box.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';



class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  bool isObscured = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formState,
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
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SpacerBox(
                    height: 20,
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
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
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
                          overlayColor: WidgetStatePropertyAll<Color>(
                              Colors.grey.shade500),
                          iconColor:
                          const WidgetStatePropertyAll<Color>(Colors.black),
                          backgroundColor:
                          const WidgetStatePropertyAll<Color>(Colors.white),
                          shape: const WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          splashFactory: InkSparkle.splashFactory),
                      onPressed: () {
                        if (formState.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignupEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              name: _nameController.text.trim(),
                            ),
                          );
                        }
                      },
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.key_sharp),
                      label: const Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: size.width * 0.5,
                      maxWidth: size.width * 0.5,
                    ),
                    child: IconButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStatePropertyAll<Color>(
                            Colors.grey.shade500),
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
                        context
                            .read<AuthBloc>()
                            .add(const GoogleSigninEvent());
                      },
                      icon:  const FaIcon(
                        FontAwesomeIcons.google,
                        size: 16,
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        listener: (context, state) {
          if (state is LoadingState) {
            LoadingDialog().show(
              context: context,
              text: 'Signing Up',
            );
          }
          if (state is SignupFailedState) {
            LoadingDialog().hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
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
            ScaffoldMessenger.of(context)..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Signed up successfully',
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      FaIcon(
                        FontAwesomeIcons.userAstronaut,
                        color: Colors.white,
                      )
                    ],
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
      ),
    );
  }
}
