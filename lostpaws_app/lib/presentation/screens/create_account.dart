import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/routes/unauthenticated_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  bool _termsAgreement = false;

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
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign up",
                  style: const LostPawsText().primaryTitleBold,
                ),
                const SizedBox(height: 5),
                Text(
                  "Create an account to get started",
                  style: const LostPawsText().primaryRegularGrey,
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "Name",
                  style: const LostPawsText().primarySemiBoldGreen,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'John Smith',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  // TODO
                  // autovalidateMode: state.autoValidate
                  //     ? AutovalidateMode.onUserInteraction
                  //     : null,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  // onChanged: (email) => context
                  //     .read<AuthenticationCubit>()
                  //     .emailChanged(email),
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "Email Address",
                  style: const LostPawsText().primarySemiBoldGreen,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'name@email.com',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  // TODO
                  // autovalidateMode: state.autoValidate
                  //     ? AutovalidateMode.onUserInteraction
                  //     : null,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  // onChanged: (email) => context
                  //     .read<AuthenticationCubit>()
                  //     .emailChanged(email),
                ),
                const SizedBox(height: 10),
                Text(
                  "This email address will be visible to the public in case others need to contact you.",
                  style: const LostPawsText().primarySmallerGrey,
                ),
                const SizedBox(height: defaultPadding),
                Text(
                  "Password",
                  style: const LostPawsText().primarySemiBoldGreen,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter a password',
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: ConstColors.lightGrey),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                  // autovalidateMode: state.autoValidate
                  //     ? AutovalidateMode.onUserInteraction
                  //     : null,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  // onChanged: (password) => context
                  //     .read<AuthenticationCubit>()
                  //     .passwordChanged(password),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter a password',
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: ConstColors.lightGrey),
                      onPressed: () {
                        setState(() {
                          _obscureTextConfirm = !_obscureTextConfirm;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureTextConfirm,
                  // autovalidateMode: state.autoValidate
                  //     ? AutovalidateMode.onUserInteraction
                  //     : null,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  // onChanged: (password) => context
                  //     .read<AuthenticationCubit>()
                  //     .passwordChanged(password),
                ),
                const SizedBox(height: defaultPadding),
                CheckboxListTile(
                  title: RichText(
                    text: TextSpan(
                      text: "I've read and agree with the ",
                      style: const LostPawsText().primaryRegularGrey,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms and Conditions ',
                          style: const LostPawsText().primaryRegularOrange,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Beamer.of(context).beamToNamed(
                                  UnauthenticatedLocations
                                      .termsAndConditionsRoute,
                                ),
                        ),
                        TextSpan(
                            text: 'and the ',
                            style: const LostPawsText().primaryRegularGrey),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: const LostPawsText().primaryRegularOrange,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Beamer.of(context).beamToNamed(
                                  UnauthenticatedLocations.privacyPolicyRoute,
                                ),
                        ),
                      ],
                    ),
                  ),
                  value: _termsAgreement,
                  activeColor: ConstColors.darkOrange,
                  side: const BorderSide(
                    color: ConstColors.lightGrey,
                  ),
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.5)),
                  onChanged: (_) {
                    setState(() {
                      _termsAgreement = !_termsAgreement;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: ConstColors.yellowOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child:
                      // state.status == LoginFormStatus.submissionInProgress
                      //     ? const CircularProgressIndicator()
                      // :
                      Text(
                    'Register',
                    style: const LostPawsText().primarySemiBold,
                  ),
                  onPressed: () async {
                    // if (!state.autoValidate) {
                    //   context.read<AuthenticationCubit>().setAutovalidate;

                    //   if (!_formkey.currentState!.validate()) {
                    //     return;
                    //   }
                    // }

                    // await context
                    //     .read<AuthenticationCubit>()
                    //     .signInEmailPassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
