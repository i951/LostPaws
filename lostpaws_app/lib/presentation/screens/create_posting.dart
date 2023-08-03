import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lostpaws_app/business/bloc/create_post_bloc.dart';
import 'package:lostpaws_app/data/models/pet_colour.dart';
import 'package:lostpaws_app/presentation/components/custom_text_field.dart';
import 'package:lostpaws_app/presentation/components/custom_toggle_buttons.dart';
import 'package:lostpaws_app/presentation/components/date_picker.dart';
import 'package:lostpaws_app/presentation/components/location_picker.dart';
import 'package:lostpaws_app/presentation/components/pet_size_dropdown_menu.dart';
import 'package:lostpaws_app/presentation/components/pet_size_info.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';
import 'package:permission_handler/permission_handler.dart';

class CreatePostingScreen extends StatefulWidget {
  const CreatePostingScreen({super.key});

  @override
  State<CreatePostingScreen> createState() => _CreatePostingScreenState();
}

class _CreatePostingScreenState extends State<CreatePostingScreen> {
  bool isLoading = false;
  final datePicker = const DatePicker();
  Color pickerColor = Color(PetColours.values.first.hexValue);

  List<Color> getAvailableColors() {
    final List<Color> colors = [];
    for (var color in PetColours.values) {
      colors.add(Color(color.hexValue));
    }

    return colors;
  }

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
                      child: BlocProvider(
                        create: (context) => CreatePostBloc(),
                        child: BlocBuilder<CreatePostBloc, CreatePostState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Post Type",
                                    style: const LostPawsText()
                                        .primaryRegularGreen),
                                CustomToggleButtons(
                                  toggleType: ToggleType.post,
                                  multiselect: false,
                                  options: [
                                    PostTypeOption.lost.value,
                                    PostTypeOption.sighting.value,
                                  ],
                                ),
                                Text(
                                  "Post Title",
                                  style:
                                      const LostPawsText().primaryRegularGreen,
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
                                  onChanged: (title) => context
                                      .read<CreatePostBloc>()
                                      .add(
                                          CreatePostTitleChanged(title: title)),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(
                                        defaultPadding)),
                                Text(
                                  "Photos",
                                  style:
                                      const LostPawsText().primaryRegularGreen,
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
                                        backgroundColor:
                                            ConstColors.mediumGreen,
                                        elevation: 7,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  style:
                                      const LostPawsText().primaryRegularGreen,
                                ),
                                CustomToggleButtons(
                                  toggleType: ToggleType.pet,
                                  multiselect: false,
                                  options: [
                                    PetTypeOption.dog.value,
                                    PetTypeOption.cat.value,
                                    PetTypeOption.bird.value,
                                    PetTypeOption.bunny.value,
                                    PetTypeOption.reptile.value,
                                    PetTypeOption.amphibian.value,
                                    PetTypeOption.rodent.value,
                                    PetTypeOption.other.value,
                                  ],
                                ),
                                Text(
                                  "Breed (fill in N/A if unsure)",
                                  style:
                                      const LostPawsText().primaryRegularGreen,
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
                                    onChanged: (breed) => context
                                        .read<CreatePostBloc>()
                                        .add(CreatePostBreedChanged(
                                            breed: breed))),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Text(
                                  "Colour",
                                  style:
                                      const LostPawsText().primaryRegularGreen,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.colour != null
                                          ? state.colour!.name
                                          : '',
                                      style:
                                          const LostPawsText().primarySemiBold,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => BlocProvider.value(
                                            value:
                                                context.read<CreatePostBloc>(),
                                            child: AlertDialog(
                                              backgroundColor:
                                                  ConstColors.lightGreen,
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'What colour was the animal?',
                                                      style:
                                                          const LostPawsText()
                                                              .primarySemiBold,
                                                    ),
                                                    Text(
                                                      'Choose a colour that best describes the animal. '
                                                      'You can always add more in the description.',
                                                      style: const LostPawsText()
                                                          .primarySmallerGrey,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 280,
                                                      child: BlockPicker(
                                                        pickerColor:
                                                            pickerColor,
                                                        onColorChanged:
                                                            (Color color) {
                                                          setState(() =>
                                                              pickerColor =
                                                                  color);

                                                          for (var petColor
                                                              in PetColours
                                                                  .values) {
                                                            if (petColor
                                                                    .hexValue ==
                                                                color.value) {
                                                              context.read<CreatePostBloc>().add(CreatePostColourChanged(
                                                                  colour: PetColour(
                                                                      hexValue:
                                                                          petColor
                                                                              .hexValue,
                                                                      name: petColor
                                                                          .name)));
                                                            }
                                                          }
                                                        },
                                                        availableColors:
                                                            getAvailableColors(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 120,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              ConstColors
                                                                  .darkGreen,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: Text(
                                                            "Done",
                                                            style: const LostPawsText()
                                                                .primaryRegularWhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.colorize,
                                        color: ConstColors.darkOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                CustomTextField(
                                  title: "Weight",
                                  hintText: '12.5',
                                  keyboardType: TextInputType.text,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.numeric(
                                        errorText:
                                            'Please enter a valid number'),
                                  ]),
                                  extraText: "kg",
                                  onChanged: (weight) => context
                                      .read<CreatePostBloc>()
                                      .add(CreatePostWeightChanged(
                                          weight: weight)),
                                ),
                                Text(
                                  "Weight",
                                  style:
                                      const LostPawsText().primaryRegularGreen,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: '4.5',
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.all(defaultPadding),
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
                                  style:
                                      const LostPawsText().primaryRegularGreen,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        height:
                                            getProportionateScreenHeight(50),
                                        width: getProportionateScreenWidth(160),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: ConstColors.lightGrey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        child: PetSizeDropdownMenu(
                                          handleOnChanged: (size) {
                                            print(size);
                                          },
                                        )),
                                    const PetSizeInfo(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            "Date Last Seen",
                                            style: const LostPawsText()
                                                .primaryRegularGreen,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat(
                                                      DateFormat.YEAR_MONTH_DAY)
                                                  .format(
                                                state.dateLastSeen ??
                                                    DateTime.now(),
                                              ),
                                              style: const LostPawsText()
                                                  .primarySemiBold,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => BlocProvider.value(
                                            value:
                                                context.read<CreatePostBloc>(),
                                            child: Dialog(
                                              insetPadding:
                                                  const EdgeInsets.all(
                                                      defaultPadding),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    (defaultPadding * 2),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    (defaultPadding * 18),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: DatePicker(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.calendar_month_rounded,
                                        color: ConstColors.darkOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Location Last Seen",
                                          style: const LostPawsText()
                                              .primaryRegularGreen,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            // Check if location services are enabled
                                            bool serviceEnabled;
                                            LocationPermission permission;

                                            permission = await Geolocator
                                                .checkPermission();

                                            if (permission ==
                                                LocationPermission.denied) {
                                              permission = await Geolocator
                                                  .requestPermission();
                                              if (permission ==
                                                  LocationPermission.denied) {
                                                print(
                                                    'Location permissions are denied');
                                                if (mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Location permissions are denied, please '
                                                        'allow location access to continue.',
                                                        style: const LostPawsText()
                                                            .primaryRegularWhite,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            }

                                            if (permission ==
                                                LocationPermission
                                                    .deniedForever) {
                                              print(
                                                  'Location permissions are permanently denied, '
                                                  'we cannot request permissions.');
                                              if (mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Location permissions are permanently denied, '
                                                      'please go to settings and allow location access.',
                                                      style: const LostPawsText()
                                                          .primaryRegularWhite,
                                                    ),
                                                    action: SnackBarAction(
                                                      label: 'GO TO SETTINGS',
                                                      onPressed: () async {
                                                        await openAppSettings();

                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else {
                                              serviceEnabled = await Geolocator
                                                  .isLocationServiceEnabled();

                                              if (!serviceEnabled) {
                                                print(
                                                    'Location services are disabled.');

                                                if (mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Location services are disabled, please enable '
                                                        'location services to continue.',
                                                        style: const LostPawsText()
                                                            .primaryRegularWhite,
                                                      ),
                                                      action: SnackBarAction(
                                                        label: 'GO TO SETTINGS',
                                                        onPressed: () async {
                                                          await Geolocator
                                                              .openLocationSettings();

                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }

                                              final position = await Geolocator
                                                  .getCurrentPosition(
                                                      desiredAccuracy:
                                                          LocationAccuracy
                                                              .high);

                                              final userLocation = LatLng(
                                                  position.latitude,
                                                  position.longitude);

                                              if (mounted) {
                                                final dialogWidth =
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        (defaultPadding * 2);

                                                final dialogHeight =
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height -
                                                        (defaultPadding * 8);

                                                showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      BlocProvider.value(
                                                    value: context
                                                        .read<CreatePostBloc>(),
                                                    child: Dialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              defaultPadding),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: SizedBox(
                                                        width: dialogWidth,
                                                        height: dialogHeight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: LocationPicker(
                                                            dialogWidth:
                                                                dialogWidth,
                                                            dialogHeight:
                                                                dialogHeight,
                                                            userLocation:
                                                                userLocation,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );

                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            }
                                          },
                                          icon: isLoading
                                              ? const SizedBox.square(
                                                  dimension: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        ConstColors.darkOrange,
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons
                                                      .add_location_alt_outlined,
                                                  color: ConstColors.darkOrange,
                                                ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.locationLastSeen == null
                                                ? ''
                                                : '${state.locationLastSeen!.street}, ${state.locationLastSeen!.city}, ${state.locationLastSeen!.province}, ${state.locationLastSeen!.postalCode}',
                                            style: const LostPawsText()
                                                .primarySemiBold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Description (add any additional info)",
                                  style:
                                      const LostPawsText().primaryRegularGreen,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  maxLines: 30,
                                  minLines: 5,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintStyle:
                                        const LostPawsText().primaryRegularGrey,
                                    hintText:
                                        'Enter more details about the time, date, and '
                                        'place where the animal was last seen.\n\n'
                                        'You may also provide info about the animal\'s '
                                        'appearance, such as its colour(s), size, and '
                                        'any other unique features.',
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(8.0),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                                CustomTextField(
                                  title: "Weight",
                                  hintText: '12.5',
                                  width: 120,
                                  keyboardType: TextInputType.text,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.numeric(
                                        errorText:
                                            'Please enter a valid number'),
                                  ]),
                                  extraText: "kg",
                                  onChanged: (weight) => context
                                      .read<CreatePostBloc>()
                                      .add(CreatePostWeightChanged(
                                          weight: weight)),
                                ),
                                Text(
                                  'Contact Email',
                                  style: LostPawsText().primaryRegularGreen,
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'example@email.com',
                                      style: LostPawsText().primarySemiBold,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.info,
                                        color: ConstColors.darkGreen,
                                      ),
                                      onPressed: () {
                                        print("pressed");
                                      },
                                    ),
                                  ],
                                ),
                                CustomTextField(
                                  title: "Phone",
                                  keyboardType: TextInputType.text,
                                  width: MediaQuery.of(context).size.width -
                                      (defaultPadding * 4),
                                  hintText: '6041234567',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  onChanged: (phone) {
                                    context.read<CreatePostBloc>().add(
                                        CreatePostPhoneChanged(phone: phone));
                                  },
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                            vertical:
                                                getProportionateScreenHeight(
                                                    15),
                                            horizontal:
                                                getProportionateScreenWidth(70),
                                          ),
                                          backgroundColor:
                                              ConstColors.darkOrange,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                        ),
                                        onPressed: () {
                                          Beamer.of(context, root: true)
                                              .beamToNamed(
                                                  HomeLocations.homeRoute);
                                        },
                                        child: Text(
                                          'Post',
                                          style: const LostPawsText()
                                              .primarySemiBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
