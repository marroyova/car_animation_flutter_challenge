import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/car.dart';

class CarCardWidget extends StatelessWidget {
  final Car car;
  const CarCardWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '_',
                style: GoogleFonts.quicksand(
                    color: Colors.white,
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
                  car.year.toString(),
                  style: GoogleFonts.aleo(
                    color: Colors.white,
                    fontSize: 50.0,
                  ),
                ),
                Text(
                  ' - ${car.yearUntil.toString()}',
                  style: GoogleFonts.aleo(
                    fontSize: 35.0,
                    textBaseline: TextBaseline.ideographic,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.0
                      ..color = Colors.white.withOpacity(0.3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            Image(
              image: AssetImage(car.mainImage),
              fit: BoxFit.cover,
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
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight:
                          index == 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Image(
                image: AssetImage(car.logo),
                fit: BoxFit.cover,
              ),
            ),
            //const SizedBox(height: 25.0),
            Text(
              car.name,
              style: GoogleFonts.gelasio(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
