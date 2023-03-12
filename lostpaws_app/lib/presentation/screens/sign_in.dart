import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lostpaws_app/main.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/unauthenticated_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Container(
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
                height: getProportionateScreenHeight(380),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/lost-paws.png'),
                      fit: BoxFit.fitWidth),
                ),
              ),
              Expanded(
                child: Container(
                  height: SizeConfig.screenHeight / 2,
                  child: Column(
                    children: [
                      Text(
                        "Welcome!",
                        style: const LostPawsText().primaryTitle,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(defaultPadding),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(350),
                        width: getProportionateScreenWidth(300),
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email address',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                            SizedBox(
                              height:
                                  getProportionateScreenHeight(defaultPadding),
                            ),
                            TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                            SizedBox(
                              height:
                                  getProportionateScreenHeight(defaultPadding),
                            ),
                            InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(
                                    getProportionateScreenWidth(5)),
                                child: Text(
                                  "Forgot password?",
                                  style: const LostPawsText().primaryRegular,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              onTap: () {
                                Beamer.of(context, root: true).beamToNamed(
                                    UnauthenticatedLocations.forgotFormRoute);
                              },
                            ),
                            SizedBox(
                              height:
                                  getProportionateScreenHeight(defaultPadding),
                            ),
                            ElevatedButton(
                              onPressed: () => print("Logging in"),
                              child: Text(
                                "Login",
                                style: const LostPawsText().caption1SemiBold,
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
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