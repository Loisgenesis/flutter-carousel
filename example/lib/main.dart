import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Demo',
      home: CarouselExample(),
    );
  }
}

class CarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Carousel(
            height: 300.0,
            width: double.infinity,
            initialPage: 3,
            allowWrap: false,
            type: Types.slideSwiper,
            onCarouselTap: (i) {
              print("onTap $i");
            },
            indicatorType: IndicatorTypes.bar,
            arrowColor: Colors.black,
            axis: Axis.horizontal,
            showArrow: true,
            children: List.generate(
                7,
                (i) => ClipPath(
                    clipper: CustomClip(),
                    child: Center(
                      child:
                          Container(color: Colors.red.withOpacity((i + 1) / 7)),
                    )))),
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addPolygon([
      Offset(size.width / 7, 0),
      Offset(0, size.height / 2),
      Offset(size.width / 2, size.height),
      Offset(size.width, size.height / 2),
      Offset((6 * size.width) / 7, 0),
    ], true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class CustomStroke extends CustomPainter {
  final Color strokeColor;
  CustomStroke({this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = strokeColor; // Change this to fill
    Path path = Path();

    path.moveTo(size.width / 7, 0);
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo((6 * size.width) / 7, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
