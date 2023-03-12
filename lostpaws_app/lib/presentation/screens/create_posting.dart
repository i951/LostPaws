import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/routes/unauthenticated_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class CreatePostingScreen extends StatefulWidget {
  const CreatePostingScreen({super.key});

  @override
  State<CreatePostingScreen> createState() => _CreatePostingScreenState();
}

class _CreatePostingScreenState extends State<CreatePostingScreen> {
  final List<bool> _selectedItems = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () =>
                  Beamer.of(context).popToNamed(HomeLocations.homeRoute),
              child: Text(
                "Cancel",
                style: LostPawsText().primaryOrangeBold,
                softWrap: false,
              ),
            ),
            Text(
              "Create a Post",
              style: const LostPawsText().primaryTitle,
            ),
            TextButton(
              onPressed: () => print("Clear all outputs"),
              child: Text(
                "Clear All",
                style: LostPawsText().primaryOrangeBold,
              ),
            ),
          ],
        ),
        toolbarOpacity: 1.0,
        toolbarHeight: getProportionateScreenHeight(80),
        backgroundColor: ConstColors.lightGreen,
        foregroundColor: ConstColors.darkOrange,
      ),
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
                height: getProportionateScreenHeight(0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(defaultPadding),
              ),
              Expanded(
                child: Container(
                  height: SizeConfig.screenHeight / 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(defaultPadding),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(500),
                        width: getProportionateScreenWidth(300),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Post Type",
                                  style: LostPawsText().primaryRegular,
                                ),
                              ),
                              ToggleButtons(
                                fillColor: ConstColors.lightGreen,
                                renderBorder: false,
                                direction: Axis.horizontal,
                                onPressed: (int index) {
                                  setState(() {
                                    // The button that is tapped is set to true, and the others to false.
                                    for (int i = 0;
                                        i < _selectedItems.length;
                                        i++) {
                                      _selectedItems[i] = i == index;
                                    }
                                  });
                                },
                                isSelected: _selectedItems,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ConstColors.yellowOrange,
                                        ),
                                        child: Text('Sighting')),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ConstColors.yellowOrange,
                                        ),
                                        child: Text('Lost')),
                                  ),
                                ],
                              ),
                              Text(
                                "Post Title",
                                style: const LostPawsText().primaryTitle,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Golden Retriever',
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
                                height: getProportionateScreenHeight(
                                    defaultPadding),
                              ),
                              Text(
                                "Colour",
                                style: const LostPawsText().primaryTitle,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Light Brown',
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(
                                    defaultPadding),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(
                                    defaultPadding),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(15),
                                    horizontal: getProportionateScreenWidth(70),
                                  ),
                                  backgroundColor: ConstColors.darkOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                                onPressed: () {
                                  Beamer.of(context, root: true)
                                      .beamToNamed(HomeLocations.homeRoute);
                                },
                                child: Text(
                                  'Post',
                                  style: const LostPawsText().primarySemiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
