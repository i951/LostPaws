import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lostpaws_app/presentation/components/custom_text_field.dart';
import 'package:lostpaws_app/presentation/components/custom_toggle_buttons.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class CreatePostingScreen extends StatefulWidget {
  const CreatePostingScreen({super.key});

  @override
  State<CreatePostingScreen> createState() => _CreatePostingScreenState();
}

class _CreatePostingScreenState extends State<CreatePostingScreen> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Create a Post",
          style: const LostPawsText().primaryTitle,
        ),
        leadingWidth: getProportionateScreenWidth(70),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            iconSize: getProportionateScreenWidth(defaultPadding),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: getProportionateScreenWidth(defaultPadding),
            ),
          ),
        ),
        toolbarOpacity: 1.0,
        toolbarHeight: getProportionateScreenHeight(80),
        backgroundColor: ConstColors.lightGreen,
        foregroundColor: ConstColors.darkOrange,
        elevation: 0,
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
          child: Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(300),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Post Type",
                                style:
                                    const LostPawsText().primaryRegularGreen),
                            const CustomToggleButtons(
                              multiselect: false,
                              options: ["LOST", "SIGHTING"],
                            ),
                            Text(
                              "Post Title",
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Golden Retriever at Broadmoor',
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
                                    defaultPadding)),
                            Text(
                              "Photos",
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_rounded,
                                  size: getProportionateScreenWidth(50),
                                  color: Colors.black,
                                  shadows: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 7,
                                      spreadRadius: 3,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: UPLOAD PHOTOS
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ConstColors.mediumGreen,
                                    elevation: 7,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: const BorderSide(
                                      color: ConstColors.darkGreen,
                                      width: 2.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Text(
                                      "Upload Photos",
                                      style: const LostPawsText()
                                          .primaryRegularWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Pet Type",
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                            const CustomToggleButtons(
                              multiselect: false,
                              options: [
                                "DOG",
                                "CAT",
                                "BIRD",
                                "BUNNY",
                                "REPTILE",
                                "AMPHIBIAN",
                                "RODENT",
                                "OTHER",
                              ],
                            ),
                            Text(
                              "Breed (fill in N/A if unsure)",
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Golden Retriever',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            Text(
                              "Colour",
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Light Brown',
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // TODO: show colour picker
                                  },
                                  icon: const Icon(
                                    Icons.colorize,
                                    color: ConstColors.darkOrange,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  getProportionateScreenHeight(defaultPadding),
                            ),
                            CustomTextField(
                              title: "Weight",
                              hintText: '12.5',
                              keyboardType: TextInputType.text,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              extraText: "kg",
                              onChanged: () {
                                // TODO
                              },
                            ),
                            Text(
                              "Weight",
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: '12.5',
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    "kg",
                                    style: const LostPawsText()
                                        .primarySemiBoldGreen,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "Size",
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(50),
                                  width: getProportionateScreenWidth(160),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: ConstColors.lightGrey
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: selectedSize,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 42,
                                    underline: const SizedBox(),
                                    borderRadius: BorderRadius.circular(10),
                                    items: const [
                                      DropdownMenuItem(
                                        value: "value",
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultPadding),
                                          child: Text("Small"),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "value",
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: defaultPadding),
                                          child: Text("Medium"),
                                        ),
                                      ),
                                    ],
                                    onChanged: (String? size) {
                                      setState(() {
                                        selectedSize = size;
                                        print("selected $size");
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.info,
                                    color: ConstColors.darkGreen,
                                  ),
                                  onPressed: () {
                                    // TODO: show info exapmle
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Date Last Seen",
                                  style:
                                      const LostPawsText().primaryRegularGreen,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // TODO: show colour picker
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: ConstColors.darkOrange,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Location Last Seen",
                                  style:
                                      const LostPawsText().primaryRegularGreen,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // TODO: show colour picker
                                  },
                                  icon: const Icon(
                                    Icons.add_location_alt_outlined,
                                    color: ConstColors.darkOrange,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Description (add any additional info)",
                              style: const LostPawsText().primaryRegularGreen,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              maxLines: 10,
                              minLines: 5,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    'Saw a sad hungry doggo at Minoru Park. '
                                    'Had dark brown eyes. No collar indicating any information '
                                    'so took it home with me. Text me if it\'s yours',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            CustomTextField(
                              title: "Contact Email",
                              keyboardType: TextInputType.text,
                              hintText: 'example@email.com',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              onChanged: () {
                                // TODO
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(15),
                                        horizontal:
                                            getProportionateScreenWidth(70),
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
                                      style:
                                          const LostPawsText().primarySemiBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
