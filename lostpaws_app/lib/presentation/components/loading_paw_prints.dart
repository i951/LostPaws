import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class LoadingPawPrints extends StatefulWidget {
  const LoadingPawPrints({super.key});

  @override
  State<LoadingPawPrints> createState() => _LoadingPawPrintsState();
}

class _LoadingPawPrintsState extends State<LoadingPawPrints>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  void repeatOnce() async {
    await _animationController.forward();
    await _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 7000))
      ..forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: ClipPath(
                    clipper: LoadingClipper(anim: _animation.value),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/loading-paw-prints-1.png',
                        ),
                        Image.asset(
                          "assets/images/loading-paw-prints-2.png",
                        ),
                        Image.asset(
                          "assets/images/loading-paw-prints-3.png",
                        ),
                        Image.asset(
                          "assets/images/loading-paw-prints-4.png",
                        ),
                        Image.asset(
                          "assets/images/loading-paw-prints-5.png",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Image.asset(
                            "assets/images/loading-cat.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Posting...",
                  style: const LostPawsText().primarySemiBoldGreen,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class LoadingClipper extends CustomClipper<Path> {
  final double anim;
  LoadingClipper({required this.anim});
  @override
  getClip(Size size) {
    var rect = Rect.fromLTWH(0.0, 0.0, size.width * anim, size.height);
    var path = Path();
    path.addRect(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant LoadingClipper oldClipper) {
    return oldClipper != this;
  }
}
