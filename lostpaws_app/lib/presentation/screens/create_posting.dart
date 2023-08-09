import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lostpaws_app/business/bloc/create_post_bloc.dart';
import 'package:lostpaws_app/business/cubit/authentication_cubit.dart';
import 'package:lostpaws_app/data/models/pet_colour.dart';
import 'package:lostpaws_app/presentation/components/custom_toggle_buttons.dart';
import 'package:lostpaws_app/presentation/components/date_picker.dart';
import 'package:lostpaws_app/presentation/components/error_message.dart';
import 'package:lostpaws_app/presentation/components/location_picker.dart';
import 'package:lostpaws_app/presentation/components/pet_size_dropdown_menu.dart';
import 'package:lostpaws_app/presentation/components/pet_size_info.dart';
import 'package:lostpaws_app/presentation/components/custom_tooltip.dart';
import 'package:lostpaws_app/presentation/components/uploaded_photo_preview.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';
import 'package:permission_handler/permission_handler.dart';

class CreatePostingScreen extends StatefulWidget {
  const CreatePostingScreen({super.key});

  @override
  State<CreatePostingScreen> createState() => _CreatePostingScreenState();
}

class _CreatePostingScreenState extends State<CreatePostingScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();
  List<XFile> pickedImages = [];
  List<String> pickedImagePaths = [];
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
      resizeToAvoidBottomInset: true,
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
                      key: _formkey,
                      child: BlocProvider(
                        create: (context) => CreatePostBloc(),
                        child: BlocBuilder<CreatePostBloc, CreatePostState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text("Post Type",
                                      style: const LostPawsText()
                                          .primaryRegularGreen),
                                ),
                                CustomToggleButtons(
                                  toggleType: ToggleType.post,
                                  multiselect: false,
                                  options: [
                                    PostTypeOption.lost.value,
                                    PostTypeOption.sighting.value,
                                  ],
                                ),
                                state.formErrors
                                        .containsKey(ErrorType.missingPostType)
                                    ? ErrorMessage(
                                        error: state.formErrors[
                                            ErrorType.missingPostType]!)
                                    : const SizedBox(height: defaultPadding),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text(
                                    "Post Title",
                                    style: const LostPawsText()
                                        .primaryRegularGreen,
                                  ),
                                ),
                                TextFormField(
                                  enabled: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  autovalidateMode: state.autoValidate
                                      ? AutovalidateMode.onUserInteraction
                                      : null,
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
                                      onPressed: () async {
                                        var permissionsGranted = false;

                                        if (Platform.isAndroid) {
                                          final androidInfo =
                                              await DeviceInfoPlugin()
                                                  .androidInfo;
                                          if (androidInfo.version.sdkInt <=
                                              32) {
                                            if (await Permission.storage
                                                .request()
                                                .isGranted) {
                                              permissionsGranted = true;
                                            }
                                          } else {
                                            if (await Permission.photos
                                                .request()
                                                .isGranted) {
                                              permissionsGranted = true;
                                            }
                                          }
                                        } else if (Platform.isIOS) {
                                          // TODO: handle other platforms
                                        }

                                        if (permissionsGranted) {
                                          // Check for MainActivity destruction
                                          // https://pub.dev/packages/image_picker
                                          final LostDataResponse response =
                                              await picker.retrieveLostData();

                                          if (response.isEmpty) {
                                            // No data lost, open image picker
                                            final images =
                                                await picker.pickMultiImage();

                                            setState(() {
                                              for (var image in images) {
                                                if (!pickedImages
                                                    .contains(image)) {
                                                  pickedImages.add(image);
                                                  pickedImagePaths
                                                      .add(image.path);

                                                  context
                                                      .read<CreatePostBloc>()
                                                      .add(CreatePostEvent
                                                          .uploadPhotos(
                                                              photos:
                                                                  pickedImagePaths));
                                                }
                                              }
                                            });
                                          }

                                          // Data was lost, so retrieve it first
                                          final List<XFile>? files =
                                              response.files;

                                          if (files != null) {
                                            setState(() async {
                                              pickedImages = List.from(files);
                                            });
                                          } else {
                                            print(response.exception);
                                          }
                                        } else {
                                          if (mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Storage permissions are denied, please '
                                                  'allow access to photos to continue.',
                                                  style: const LostPawsText()
                                                      .primaryRegularWhite,
                                                ),
                                                action: SnackBarAction(
                                                  label: 'GO TO SETTINGS',
                                                  onPressed: () async {
                                                    await openAppSettings();
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        }
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
                                pickedImages.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0))
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: SizedBox(
                                          height: 140,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  pickedImagePaths.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: UploadedPhotoPreview(
                                                    imagePath:
                                                        pickedImagePaths[index],
                                                    imageIndex: index,
                                                    onPressed: () {
                                                      setState(() {
                                                        pickedImages
                                                            .removeAt(index);
                                                        pickedImagePaths
                                                            .removeAt(index);

                                                        context
                                                            .read<
                                                                CreatePostBloc>()
                                                            .add(CreatePostEvent
                                                                .uploadPhotos(
                                                                    photos:
                                                                        pickedImagePaths));
                                                      });
                                                    },
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text(
                                    "Pet Type",
                                    style: const LostPawsText()
                                        .primaryRegularGreen,
                                  ),
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
                                state.formErrors
                                        .containsKey(ErrorType.missingPetType)
                                    ? ErrorMessage(
                                        error: state.formErrors[
                                            ErrorType.missingPetType]!)
                                    : const SizedBox(height: defaultPadding),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text(
                                    "Breed (optional)",
                                    style: const LostPawsText()
                                        .primaryRegularGreen,
                                  ),
                                ),
                                TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    onChanged: (breed) => context
                                        .read<CreatePostBloc>()
                                        .add(CreatePostBreedChanged(
                                            breed: breed))),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: defaultPadding,
                                        bottom: defaultPadding / 2,
                                      ),
                                      child: Text(
                                        "Colour (optional)",
                                        style: const LostPawsText()
                                            .primaryRegularGreen,
                                      ),
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
                                Text(
                                  state.colour != null
                                      ? state.colour!.name
                                      : '',
                                  style: const LostPawsText().primarySemiBold,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text(
                                    'Weight (optional)',
                                    style: const LostPawsText()
                                        .primaryRegularGreen,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        autovalidateMode: state.autoValidate
                                            ? AutovalidateMode.onUserInteraction
                                            : null,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.numeric(
                                              errorText:
                                                  'Please enter a valid number.'),
                                        ]),
                                        onChanged: (weight) =>
                                            context.read<CreatePostBloc>().add(
                                                  CreatePostWeightChanged(
                                                      weight: weight),
                                                ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding),
                                      child: Text(
                                        'kg',
                                        style: const LostPawsText()
                                            .primarySemiBoldGreen,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text(
                                    "Size (optional)",
                                    style: const LostPawsText()
                                        .primaryRegularGreen,
                                  ),
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
                                        child: const PetSizeDropdownMenu()),
                                    const PetSizeInfo(),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date Last Seen",
                                            style: const LostPawsText()
                                                .primaryRegularGreen,
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => BlocProvider.value(
                                              value: context
                                                  .read<CreatePostBloc>(),
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
                                                    padding:
                                                        EdgeInsets.all(8.0),
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
                                ),
                                state.formErrors
                                        .containsKey(ErrorType.missingDate)
                                    ? ErrorMessage(
                                        error: state
                                            .formErrors[ErrorType.missingDate]!)
                                    : Text(
                                        state.dateLastSeen != null
                                            ? DateFormat(
                                                    DateFormat.YEAR_MONTH_DAY)
                                                .format(
                                                state.dateLastSeen!,
                                              )
                                            : "",
                                        style: const LostPawsText()
                                            .primarySemiBold,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  if (mounted) {
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                setState(() {
                                                  isLoading = false;
                                                });

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
                                                  setState(() {
                                                    isLoading = false;
                                                  });

                                                  if (mounted) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Location services are disabled, please enable '
                                                          'location services to continue.',
                                                          style: const LostPawsText()
                                                              .primaryRegularWhite,
                                                        ),
                                                        action: SnackBarAction(
                                                          label:
                                                              'GO TO SETTINGS',
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

                                                final position =
                                                    await Geolocator
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
                                                      value: context.read<
                                                          CreatePostBloc>(),
                                                      child: Dialog(
                                                        insetPadding:
                                                            const EdgeInsets
                                                                    .all(
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
                                                            child:
                                                                LocationPicker(
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
                                                      color: ConstColors
                                                          .darkOrange,
                                                    ),
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .add_location_alt_outlined,
                                                    color:
                                                        ConstColors.darkOrange,
                                                  ),
                                          ),
                                        ],
                                      ),
                                      state.formErrors.containsKey(
                                              ErrorType.missingLocation)
                                          ? ErrorMessage(
                                              error: state.formErrors[
                                                  ErrorType.missingLocation]!)
                                          : Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    state.locationLastSeen ==
                                                            null
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text(
                                    "Description",
                                    style: const LostPawsText()
                                        .primaryRegularGreen,
                                  ),
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
                                  autovalidateMode: state.autoValidate
                                      ? AutovalidateMode.onUserInteraction
                                      : null,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  onChanged: (description) {
                                    context.read<CreatePostBloc>().add(
                                        CreatePostDescriptionChanged(
                                            description: description));
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text(
                                    'Contact Email',
                                    style: const LostPawsText()
                                        .primaryRegularGreen,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BlocBuilder<AuthenticationCubit,
                                        AuthenticationState>(
                                      builder: (context, state) {
                                        return Text(
                                          state.email,
                                          style: const LostPawsText()
                                              .primarySemiBold,
                                        );
                                      },
                                    ),
                                    Tooltip(
                                      richMessage: TextSpan(
                                        text: 'This is your verified email.\n',
                                        style: const LostPawsText()
                                            .primarySemiBoldWhite,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  'To change it, go to the Profile page.',
                                              style: const LostPawsText()
                                                  .primaryRegularWhite),
                                        ],
                                      ),
                                      padding:
                                          const EdgeInsets.all(defaultPadding),
                                      showDuration: const Duration(seconds: 3),
                                      decoration: ShapeDecoration(
                                        color: ConstColors.darkGreen,
                                        shape: CustomToolTip(
                                            MediaQuery.of(context).size.width),
                                      ),
                                      preferBelow: false,
                                      verticalOffset: 20,
                                      triggerMode: TooltipTriggerMode.tap,
                                      child: const IconButton(
                                        icon: Icon(
                                          Icons.info,
                                          color: ConstColors.darkGreen,
                                        ),
                                        onPressed: null,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding,
                                    bottom: defaultPadding / 2,
                                  ),
                                  child: Text(
                                    'Contact Phone Number (optional)',
                                    style: const LostPawsText()
                                        .primaryRegularGreen,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: '123',
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        onChanged: (phone) => context
                                            .read<CreatePostBloc>()
                                            .add(CreatePostEvent.phoneChanged(
                                              phone: phone,
                                              phonePart: 0,
                                            )),
                                      ),
                                    ),
                                    Text(
                                      ' - ',
                                      style: const LostPawsText()
                                          .primarySemiBoldGreen,
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: '456',
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        onChanged: (phone) => context
                                            .read<CreatePostBloc>()
                                            .add(CreatePostEvent.phoneChanged(
                                              phone: phone,
                                              phonePart: 1,
                                            )),
                                      ),
                                    ),
                                    Text(
                                      ' - ',
                                      style: const LostPawsText()
                                          .primarySemiBoldGreen,
                                    ),
                                    SizedBox(
                                      width: 90,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: '7890',
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        onChanged: (phone) => context
                                            .read<CreatePostBloc>()
                                            .add(CreatePostEvent.phoneChanged(
                                              phone: phone,
                                              phonePart: 2,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                state.formErrors
                                        .containsKey(ErrorType.invalidPhone)
                                    ? ErrorMessage(
                                        error: state.formErrors[
                                            ErrorType.invalidPhone]!)
                                    : const SizedBox(height: defaultPadding),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: defaultPadding * 2,
                                    bottom: defaultPadding,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: state.status ==
                                                CreatePostStatus
                                                    .submissionInProgress
                                            ?
                                            // TODO: replace with loading animation
                                            const Text("loading...")
                                            : TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        getProportionateScreenHeight(
                                                            15),
                                                    horizontal:
                                                        getProportionateScreenWidth(
                                                            70),
                                                  ),
                                                  backgroundColor:
                                                      ConstColors.darkOrange,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (!state.autoValidate) {
                                                    context
                                                        .read<CreatePostBloc>()
                                                        .add(
                                                            const CreatePostSetAutovalidate());

                                                    if (!_formkey.currentState!
                                                        .validate()) {
                                                      return;
                                                    }
                                                  }

                                                  if (state
                                                      .formErrors.isEmpty) {
                                                    final userName = context
                                                        .read<
                                                            AuthenticationCubit>()
                                                        .state
                                                        .user!
                                                        .displayName;

                                                    final userId = context
                                                        .read<
                                                            AuthenticationCubit>()
                                                        .state
                                                        .user!
                                                        .uid;

                                                    final contactEmail = context
                                                        .read<
                                                            AuthenticationCubit>()
                                                        .state
                                                        .email;

                                                    context
                                                        .read<CreatePostBloc>()
                                                        .add(CreatePostEvent
                                                            .sendToServer(
                                                          userName: userName,
                                                          userId: userId,
                                                          contactEmail:
                                                              contactEmail,
                                                        ));
                                                  }
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
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom)),
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
