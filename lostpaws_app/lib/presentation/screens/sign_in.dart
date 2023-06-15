import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lostpaws_app/business/cubit/authentication_cubit.dart';
import 'package:lostpaws_app/main.dart';
import 'package:lostpaws_app/presentation/components/error_message.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/routes/unauthenticated_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _googleSignInPressed = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const ShapeDecoration(
            color: ConstColors.lightGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: getProportionateScreenHeight(300),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/lost-paws.png'),
                      fit: BoxFit.fitWidth),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(defaultPadding),
              ),
              SizedBox(
                height: getProportionateScreenHeight(450),
                child: BlocListener<AuthenticationCubit, AuthenticationState>(
                  listenWhen: (previous, current) =>
                      previous.status != current.status,
                  listener: (context, state) {
                    if (state.status == LoginFormStatus.submissionSuccess) {
                      Beamer.of(context).beamToNamed(HomeLocations.homeRoute);
                    }
                  },
                  child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: getProportionateScreenWidth(
                                      defaultPadding * 2),
                                ),
                                Text(
                                  "Welcome!",
                                  style: const LostPawsText().primaryTitleBold,
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  getProportionateScreenHeight(defaultPadding),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(450),
                              width: getProportionateScreenWidth(300),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Email address',
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      autovalidateMode: state.autoValidate
                                          ? AutovalidateMode.onUserInteraction
                                          : null,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.email(),
                                      ]),
                                      onChanged: (email) => context
                                          .read<AuthenticationCubit>()
                                          .emailChanged(email),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(10),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: 'Password',
                                        fillColor: Colors.white,
                                        filled: true,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: ConstColors.lightGrey),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        ),
                                      ),
                                      obscureText: _obscureText,
                                      autovalidateMode: state.autoValidate
                                          ? AutovalidateMode.onUserInteraction
                                          : null,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      onChanged: (password) => context
                                          .read<AuthenticationCubit>()
                                          .passwordChanged(password),
                                    ),
                                    state.errorMessage != null
                                        ? ErrorMessage(
                                            error: state.errorMessage!)
                                        : SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10),
                                          ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                getProportionateScreenWidth(5)),
                                            child: Text(
                                              "Forgot password?",
                                              style: const LostPawsText()
                                                  .primarySemiBoldGreen,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                          onTap: () {
                                            Beamer.of(context, root: true)
                                                .beamToNamed(
                                                    UnauthenticatedLocations
                                                        .forgotFormRoute);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(5),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: const Size.fromHeight(50),
                                        backgroundColor:
                                            ConstColors.yellowOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                      ),
                                      child: state.status ==
                                              LoginFormStatus
                                                  .submissionInProgress
                                          ? const CircularProgressIndicator()
                                          : Text(
                                              'Login',
                                              style: const LostPawsText()
                                                  .primarySemiBold,
                                            ),
                                      onPressed: () async {
                                        if (!state.autoValidate) {
                                          context
                                              .read<AuthenticationCubit>()
                                              .setAutovalidate;

                                          if (!_formkey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                        }

                                        await context
                                            .read<AuthenticationCubit>()
                                            .signInEmailPassword();
                                      },
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(
                                          defaultPadding),
                                    ),
                                    Text(
                                      "Don't have an account?",
                                      style: const LostPawsText()
                                          .primaryRegularGrey,
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(10),
                                    ),
                                    SignInButton(
                                      Buttons.Google,
                                      onPressed: () async {
                                        if (!_googleSignInPressed) {
                                          _googleSignInPressed = true;
                                          await context
                                              .read<AuthenticationCubit>()
                                              .signInGoogle();
                                        }
                                      },
                                    ),
                                    SignInButtonBuilder(
                                      text: 'Register now',
                                      icon: Icons.account_circle_rounded,
                                      onPressed: () {
                                        Beamer.of(context).beamToNamed(
                                            UnauthenticatedLocations
                                                .createAccountRoute);
                                      },
                                      backgroundColor: ConstColors.darkGreen,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
