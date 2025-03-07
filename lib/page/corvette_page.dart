import 'package:car_animation_challenge/data/data.dart';
import 'package:car_animation_challenge/provider/expanded_card_provider.dart';
import 'package:car_animation_challenge/provider/index_list_provider.dart';
import 'package:car_animation_challenge/widget/car_card_widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'car_detail_page.dart';

class CorvettePage extends ConsumerStatefulWidget {
  const CorvettePage({super.key});

  @override
  CorvettePageState createState() => CorvettePageState();
}

class CorvettePageState extends ConsumerState<CorvettePage>
    with SingleTickerProviderStateMixin {
  late SwiperController swiperController;

  void changeIndexCard(int value) {
    ref.read(indexSelectedProvider.notifier).update((state) => value);
    swiperController.move(value);
  }

  void _expandContainer() {
    ref.read(expandedCardProvider.notifier).update((state) => !state);
  }

  void _toGo(int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return CarDetailPage(car: listCar[index]);
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          final begin = Offset(0.0, MediaQuery.of(context).size.height / 1.0);
          const end = Offset(0.0, 0.0);

          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    swiperController = SwiperController();
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = ref.watch(expandedCardProvider);
    int indexSelected = ref.watch(indexSelectedProvider);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            top: isExpanded ? -100 : 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 25.0,
                  ),
                  child: Text(
                    'Timeline',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200.0,
                  child: Swiper(
                    controller: swiperController,
                    index: indexSelected,
                    itemCount: listCar.length,
                    loop: false,
                    viewportFraction: 0.40,
                    onIndexChanged: (value) => changeIndexCard(value),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          listCar[index].year.toString(),
                          style: indexSelected == index
                              ? GoogleFonts.aleo(
                                  color: Colors.black,
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                )
                              : GoogleFonts.aleo(
                                  backgroundColor: Colors.white,
                                  fontSize: 50.0,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.0
                                    ..color = Colors.black,
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 350,
            ),
            curve: Curves.easeOut,
            top: isExpanded ? -20 : size.height / 3.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: Swiper(
              controller: swiperController,
              index: indexSelected,
              itemCount: listCar.length,
              loop: false,
              onTap: (index) {
                _expandContainer();
                _toGo(index);
              },
              layout: SwiperLayout.STACK,
              axisDirection: AxisDirection.right,
              itemWidth: 1000.0,
              itemHeight: 1000.0,
              fade: 1.0,
              onIndexChanged: (value) => changeIndexCard(value),
              itemBuilder: (BuildContext context, int index) {
                return CarCardWidget(car: listCar[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
