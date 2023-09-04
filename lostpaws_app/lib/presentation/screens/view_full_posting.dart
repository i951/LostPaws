import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class ViewFullPostingScreen extends StatefulWidget {
  const ViewFullPostingScreen({super.key});

  @override
  State<ViewFullPostingScreen> createState() => _ViewFullPostingScreenState();
}

class _ViewFullPostingScreenState extends State<ViewFullPostingScreen> {
  final petImages = [
    'assets/images/golden-retriever.png',
    'assets/images/golden-retriever-2.jpg',
    'assets/images/golden-retriever-3.jpg',
  ];

  int _index = 0;
  bool bookmarked = false;

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
          "",
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
        backgroundColor: ConstColors.darkGreen,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(color: ConstColors.darkGreen),
                  height: MediaQuery.of(context).size.height / 3,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) => setState(() {
                      _index = index;
                    }),
                    itemCount: petImages.length,
                    itemBuilder: (_, index) {
                      return Transform.scale(
                        scale: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                              child: Image.asset(
                                petImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: ConstColors.darkGreen),
                  width: double.infinity,
                  height: 40,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: petImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox.square(
                            dimension: 2.0,
                            child: Icon(
                              Icons.circle,
                              size: 10.5,
                              color: index == _index
                                  ? Colors.amber
                                  : Colors.green.withOpacity(0.5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Flexible(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Golden Retriever",
                                style: const LostPawsText().primaryTitleBold,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          bookmarked = !bookmarked;

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  content: Text(
                                                      bookmarked
                                                          ? "Saved post to my watchlist"
                                                          : "Removed post from my watchlist",
                                                      style: const LostPawsText()
                                                          .primaryRegularWhite)));
                                        });
                                      },
                                      child: Icon(
                                        bookmarked
                                            ? Icons.bookmark
                                            : Icons.bookmark_border_outlined,
                                        size: 30,
                                        color: ConstColors.mediumGreen,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("Show sharing options");
                                      },
                                      child: const Icon(
                                        Icons.share,
                                        size: 30,
                                        color: ConstColors.mediumGreen,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Last seen: March 11, 2023 at 4:30 PM in",
                            style: const LostPawsText().primarySemiBoldGreen,
                          ),
                          Text(
                            "Richmond, BC",
                            style: const LostPawsText().primarySemiBoldGreen,
                          ),
                          const SizedBox(height: defaultPadding),
                          Text(
                            "Colour: Light Brown",
                            style: const LostPawsText().primarySemiBoldGreen,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Contact: lukasscott@gmail.com",
                            style: const LostPawsText().primarySemiBoldGreen,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "My golden retriever Kylie was last seen wearing a purple harness around "
                            "Minoru Park. She's very friendly towards humans and responds to her name "
                            "being called.",
                            style: const LostPawsText().primaryRegularGrey,
                          ),
                          const SizedBox(height: defaultPadding),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ConstColors.darkOrange),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenWidth(5),
                                        horizontal:
                                            getProportionateScreenWidth(15)),
                                    child: Text(
                                      "DOG",
                                      style: const LostPawsText()
                                          .primaryRegularWhite,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ConstColors.darkOrange),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenWidth(5),
                                        horizontal:
                                            getProportionateScreenWidth(15)),
                                    child: Text(
                                      "LOST",
                                      style: const LostPawsText()
                                          .primaryRegularWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
