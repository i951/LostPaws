import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/components/custom_bottom_nav_bar.dart';
import 'package:lostpaws_app/presentation/components/info_card.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const CustomBottomNavBar(),
      appBar: AppBar(
        toolbarOpacity: 1.0,
        toolbarHeight: getProportionateScreenHeight(80),
        backgroundColor: ConstColors.mediumGreen,
        foregroundColor: ConstColors.darkOrange,
        leading: IconButton(
          iconSize: 30.0,
          onPressed: () =>
              Beamer.of(context).beamToNamed(HomeLocations.homeRoute),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
              horizontal: getProportionateScreenWidth(20),
            ),
            decoration: const ShapeDecoration(
              color: ConstColors.lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
            ),
            child: Column(
              children: [
                const InfoCard(
                  title: "Saw a lost animal but can't find the owner?",
                  text: "Create an Animal Sighting post here!",
                  routeName: HomeLocations.homeRoute,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recently posted 👀",
                          style: const LostPawsText().primarySemiBold,
                          textAlign: TextAlign.right,
                        ),
                        InkWell(
                          child: Padding(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(5)),
                            child: Text(
                              "See more",
                              style: const LostPawsText().primaryOrangeBold,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            print("see more recent postings");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Watchlist ✨",
                          style: const LostPawsText().primarySemiBold,
                          textAlign: TextAlign.right,
                        ),
                        InkWell(
                          child: Padding(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(5)),
                            child: Text(
                              "See more",
                              style: const LostPawsText().primaryOrangeBold,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            print("see more bookmarked postings");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Found Pets 🥳",
                          style: const LostPawsText().primarySemiBold,
                          textAlign: TextAlign.right,
                        ),
                        InkWell(
                          child: Padding(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(5)),
                            child: Text(
                              "See more",
                              style: const LostPawsText().primaryOrangeBold,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          onTap: () {
                            print("see more found pets");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(defaultPadding),
                ),
                Container(
                  width: getProportionateScreenWidth(330),
                  height: getProportionateScreenHeight(140),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/charity-donation.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  "Help save someone's new best friend",
                  style: const LostPawsText().primarySemiBoldShadow,
                ),
                Padding(
                  padding: EdgeInsets.all(
                      getProportionateScreenHeight(defaultPadding)),
                  child: SizedBox(
                    height: getProportionateScreenHeight(60),
                    width: getProportionateScreenWidth(130),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ConstColors.darkOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        elevation: 5.0,
                      ),
                      onPressed: () {
                        print("go to charity donation page");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Donate',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(12.0),
                          ),
                          const Icon(
                            Icons.chevron_right_outlined,
                            color: ConstColors.mediumGreen,
                            size: 20,
                          ),
                        ],
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
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   resizeToAvoidBottomInset: false,
    //   body: SafeArea(
    //     bottom: false,
    //     child: Container(
    //       decoration: const ShapeDecoration(
    //         color: ConstColors.lightGreen,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    //         ),
    //       ),
    //       child: Column(
    //         children: [
    //           const InfoCard(
    //               title: "Saw a lost animal but can't find the owner?",
    //               text: "Create an Animal Sighting post here!",
    //               routeName: HomeLocations.homeRoute,
    //             ),
    //           Container(
    //             height: getProportionateScreenHeight(300),
    //             decoration: const BoxDecoration(
    //               image: DecorationImage(
    //                   image: AssetImage('assets/images/lost-paws.png'),
    //                   fit: BoxFit.fitWidth),
    //             ),
    //           ),
    //           SizedBox(
    //             height: getProportionateScreenHeight(defaultPadding),
    //           ),
    //           Expanded(
    //             child: Container(
    //               height: SizeConfig.screenHeight / 2,
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     "Welcome!",
    //                     style: const LostPawsText().primaryTitle,
    //                   ),
    //                   SizedBox(
    //                     height: getProportionateScreenHeight(defaultPadding),
    //                   ),
    //                   SizedBox(
    //                     height: getProportionateScreenHeight(350),
    //                     width: getProportionateScreenWidth(300),
    //                     child: Form(
    //                         child: Column(
    //                       children: [
    //                         TextFormField(
    //                           keyboardType: TextInputType.emailAddress,
    //                           decoration: const InputDecoration(
    //                             border: OutlineInputBorder(),
    //                             labelText: 'Email address',
    //                             fillColor: Colors.white,
    //                             filled: true,
    //                           ),
    //                           autovalidateMode:
    //                               AutovalidateMode.onUserInteraction,
    //                           validator: FormBuilderValidators.compose([
    //                             FormBuilderValidators.required(),
    //                             FormBuilderValidators.email(),
    //                           ]),
    //                         ),
    //                         SizedBox(
    //                           height:
    //                               getProportionateScreenHeight(defaultPadding),
    //                         ),
    //                         TextFormField(
    //                           keyboardType: TextInputType.text,
    //                           decoration: const InputDecoration(
    //                             border: OutlineInputBorder(),
    //                             labelText: 'Password',
    //                             fillColor: Colors.white,
    //                             filled: true,
    //                           ),
    //                           autovalidateMode:
    //                               AutovalidateMode.onUserInteraction,
    //                           validator: FormBuilderValidators.compose([
    //                             FormBuilderValidators.required(),
    //                             FormBuilderValidators.email(),
    //                           ]),
    //                         ),
    //                         SizedBox(
    //                           height:
    //                               getProportionateScreenHeight(defaultPadding),
    //                         ),
    //                         InkWell(
    //                           child: Padding(
    //                             padding: EdgeInsets.all(
    //                                 getProportionateScreenWidth(5)),
    //                             child: Text(
    //                               "Forgot password?",
    //                               style: const LostPawsText().primaryRegular,
    //                               textAlign: TextAlign.right,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height:
    //                               getProportionateScreenHeight(defaultPadding),
    //                         ),
    //                         TextButton(
    //                           style: TextButton.styleFrom(
    //                             padding: EdgeInsets.symmetric(
    //                               vertical: getProportionateScreenHeight(15),
    //                               horizontal: getProportionateScreenWidth(70),
    //                             ),
    //                             backgroundColor: ConstColors.darkOrange,
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(13),
    //                             ),
    //                           ),
    //                           onPressed: () {
    //                             Beamer.of(context, root: true)
    //                                 .beamToNamed(HomeLocations.homeRoute);
    //                           },
    //                           child: Text(
    //                             'Login',
    //                             style: const LostPawsText().primarySemiBold,
    //                           ),
    //                         ),
    //                       ],
    //                     )),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
