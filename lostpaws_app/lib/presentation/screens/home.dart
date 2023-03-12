import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/components/custom_app_bar.dart';
import 'package:lostpaws_app/presentation/components/custom_bottom_nav_bar.dart';
import 'package:lostpaws_app/presentation/components/info_card.dart';
import 'package:lostpaws_app/presentation/components/posting_preview.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/routes/home_locations.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final recentPostings = [
    const PostingPreview(
      imagePath: 'assets/images/golden-retriever.png',
      title: "GOLDEN RETRIEVER",
      date: "Mar 11, 2023",
      time: "4:30 PM",
      city: "Richmond",
      province: "BC",
    ),
    const PostingPreview(
      imagePath: 'assets/images/british-shorthair.png',
      title: "BRITISH SHORTHAIR",
      date: "Feb 23, 2023",
      time: "11:!5 AM",
      city: "Surrey",
      province: "BC",
    ),
    const PostingPreview(
      imagePath: 'assets/images/tabby-cat.png',
      title: "TABBY CAT",
      date: "Feb 23, 2023",
      time: "11:!5 AM",
      city: "Surrey",
      province: "BC",
    ),
  ];

  final bookmarks = [
    const PostingPreview(
      imagePath: 'assets/images/tabby-cat.png',
      title: "TABBY CAT",
      date: "Feb 23, 2023",
      time: "11:!5 AM",
      city: "Surrey",
      province: "BC",
    ),
  ];

  final foundPets = [
    const PostingPreview(
      imagePath: 'assets/images/black-dog.png',
      title: "BLACK DOG AT MINORU",
      date: "Mar 11, 2023",
      time: "4:30 PM",
      city: "Richmond",
      province: "BC",
    ),
    const PostingPreview(
      imagePath: 'assets/images/british-shorthair.png',
      title: "GRAY CAT",
      date: "Feb 23, 2023",
      time: "11:!5 AM",
      city: "Surrey",
      province: "BC",
    )
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const CustomBottomNavBar(),
      appBar: CustomAppBar(),
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
                  routeName: HomeLocations.createPostingRoute,
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
                    SizedBox(
                      height: getProportionateScreenHeight(270),
                      child: ListView.builder(
                        itemCount: recentPostings.length,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              PostingPreview(
                                imagePath: recentPostings[index].imagePath,
                                title: recentPostings[index].title,
                                date: recentPostings[index].date,
                                time: recentPostings[index].time,
                                city: recentPostings[index].city,
                                province: recentPostings[index].province,
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                            ],
                          );
                        }),
                        scrollDirection: Axis.horizontal,
                      ),
                    )
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
                    SizedBox(
                      height: getProportionateScreenHeight(270),
                      child: ListView.builder(
                        itemCount: bookmarks.length,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              PostingPreview(
                                imagePath: bookmarks[index].imagePath,
                                title: bookmarks[index].title,
                                date: bookmarks[index].date,
                                time: bookmarks[index].time,
                                city: bookmarks[index].city,
                                province: bookmarks[index].province,
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                            ],
                          );
                        }),
                        scrollDirection: Axis.horizontal,
                      ),
                    )
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
                    SizedBox(
                      height: getProportionateScreenHeight(270),
                      child: ListView.builder(
                        itemCount: foundPets.length,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              PostingPreview(
                                imagePath: foundPets[index].imagePath,
                                title: foundPets[index].title,
                                date: foundPets[index].date,
                                time: foundPets[index].time,
                                city: foundPets[index].city,
                                province: foundPets[index].province,
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                            ],
                          );
                        }),
                        scrollDirection: Axis.horizontal,
                      ),
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
  }
}
