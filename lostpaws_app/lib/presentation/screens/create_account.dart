import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lostpaws_app/business/cubit/create_account_cubit.dart';
import 'package:lostpaws_app/presentation/components/error_message.dart';
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
  bool _termsAgreed = false;

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
            child: BlocListener<CreateAccountCubit, CreateAccountState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == CreateFormStatus.submissionSuccess) {
                  Beamer.of(context)
                      .beamToNamed(UnauthenticatedLocations.signInRoute);
                }
              },
              child: BlocBuilder<CreateAccountCubit, CreateAccountState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.acceptTermsAndPolicy !=
                        current.acceptTermsAndPolicy,
                builder: (context, state) {
                  return Form(
                    key: _formkey,
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
                            hintText: 'John Smith',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          autovalidateMode: state.autoValidate
                              ? AutovalidateMode.onUserInteraction
                              : null,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          onChanged: (name) => context
                              .read<CreateAccountCubit>()
                              .nameChanged(name),
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
                            hintText: "name@email.com",
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
                              .read<CreateAccountCubit>()
                              .emailChanged(email),
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
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Enter your password',
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
                          autovalidateMode: state.autoValidate
                              ? AutovalidateMode.onUserInteraction
                              : null,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          onChanged: (password) => context
                              .read<CreateAccountCubit>()
                              .passwordChanged(password),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Re-enter your password',
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _obscureTextConfirm
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
                          autovalidateMode: state.autoValidate
                              ? AutovalidateMode.onUserInteraction
                              : null,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          onChanged: (confirmedPassword) => context
                              .read<CreateAccountCubit>()
                              .confirmPasswordChanged(confirmedPassword),
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
                                  style:
                                      const LostPawsText().primaryRegularOrange,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => Beamer.of(context).beamToNamed(
                                              UnauthenticatedLocations
                                                  .termsAndConditionsRoute,
                                            ),
                                ),
                                TextSpan(
                                    text: 'and the ',
                                    style: const LostPawsText()
                                        .primaryRegularGrey),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style:
                                      const LostPawsText().primaryRegularOrange,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => Beamer.of(context).beamToNamed(
                                              UnauthenticatedLocations
                                                  .privacyPolicyRoute,
                                            ),
                                ),
                              ],
                            ),
                          ),
                          activeColor: ConstColors.darkOrange,
                          side: const BorderSide(
                            color: ConstColors.lightGrey,
                          ),
                          value: _termsAgreed,
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.5)),
                          onChanged: (_) {
                            setState(() {
                              _termsAgreed = !_termsAgreed;
                            });

                            context
                                .read<CreateAccountCubit>()
                                .acceptTermsAndPolicyChanged(_termsAgreed);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(35),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: state.acceptTermsAndPolicy == false
                                ? Colors.grey.withOpacity(0.5)
                                : ConstColors.yellowOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                          child: state.status ==
                                  CreateFormStatus.submissionInProgress
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Register',
                                  style: _termsAgreed == false
                                      ? const LostPawsText().primaryRegularGrey
                                      : const LostPawsText()
                                          .primaryRegularGreen,
                                ),
                          onPressed: () async {
                            if (_termsAgreed) {
                              if (!state.autoValidate) {
                                context
                                    .read<CreateAccountCubit>()
                                    .setAutovalidate;

                                if (!_formkey.currentState!.validate()) {
                                  return;
                                }
                              }

                              await context
                                  .read<CreateAccountCubit>()
                                  .createAccountEmailPassword();
                            }
                          },
                        ),
                        state.errorMessage != null
                            ? ErrorMessage(error: state.errorMessage!)
                            : SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
