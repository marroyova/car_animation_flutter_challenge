import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/car.dart';
import '../provider/expanded_card_provider.dart';

class CarDetailPage extends ConsumerStatefulWidget {
  final Car car;
  const CarDetailPage({super.key, required this.car});

  @override
  CarCardWidgetState createState() => CarCardWidgetState();
}

class CarCardWidgetState extends ConsumerState<CarDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> rightAnimation;
  late Animation<double> traslateAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 500),
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
    rightAnimation = Tween<double>(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
    traslateAnimation = Tween<double>(begin: 200.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.decelerate),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textColor = Color.lerp(Colors.black, Colors.white, controller.value);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          controller.reverse().then((_) {
            Navigator.pop(context);
            ref.read(expandedCardProvider.notifier).update((state) => !state);
          });
        },
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Container(
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: const [Colors.white, Colors.black],
                  stops: [controller.value, controller.value],
                ),
              ),
              //child: child,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '_',
                        style: GoogleFonts.quicksand(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 25.0),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.car.year.toString(),
                          style: GoogleFonts.aleo(
                            color: textColor,
                            fontSize: 50.0,
                          ),
                        ),
                        Text(
                          ' - ${widget.car.yearUntil.toString()}',
                          style: GoogleFonts.aleo(
                            fontSize: 35.0,
                            textBaseline: TextBaseline.ideographic,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1.0
                              ..color = textColor!.withAlpha(77),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    Transform.scale(
                      scale: scaleAnimation.value,
                      child: Transform.translate(
                        offset: Offset(rightAnimation.value, 0.0),
                        child: Image(
                          image: AssetImage(widget.car.mainImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            (index + 1).toString(),
                            style: GoogleFonts.gelasio(
                              color: textColor,
                              fontSize: 14.0,
                              fontWeight: index == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image(
                        image: AssetImage(widget.car.logo),
                        fit: BoxFit.cover,
                        height: 75.0,
                        width: 75.0,
                      ),
                    ),
                    Text(
                      widget.car.name,
                      style: GoogleFonts.gelasio(
                        color: textColor,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Expanded(child: SizedBox(height: 50.0)),
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(0.0, traslateAnimation.value),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Production',
                                      style: GoogleFonts.gelasio(
                                        color: textColor,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      "${widget.car.year}-${widget.car.yearUntil}",
                                      style: GoogleFonts.gelasio(
                                        color: textColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Class',
                                      style: GoogleFonts.gelasio(
                                        color: textColor,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      'Sportcars',
                                      style: GoogleFonts.gelasio(
                                        color: textColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            Expanded(
                              child: Center(
                                child: Text(
                                  widget.car.subtitle,
                                  style: GoogleFonts.gelasio(
                                    color: textColor,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
