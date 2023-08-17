import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_task/gen/assets.gen.dart';
import 'package:map_task/gen/colors.dart';
import 'package:map_task/widget/add_point.dart';

class MarkerIconsPage extends StatelessWidget {
  const MarkerIconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MarkerIconsBody());
  }
}

class MarkerIconsBody extends StatefulWidget {
  const MarkerIconsBody({super.key});

  @override
  State<StatefulWidget> createState() => MarkerIconsBodyState();
}

class MarkerIconsBodyState extends State<MarkerIconsBody> {
  GoogleMapController? _mapController;
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final Set<Marker> _markers = {};
  static const List<LatLng> _points = [LatLng(52.4478, -3.5402), LatLng(42.4478, -13.5402), LatLng(32.4478, 8.5402)];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'The Office BOSS Locations',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w700,
              height: 1,
              letterSpacing: -0.32,
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.primaryRed,
          centerTitle: true,
          leading: IconButton(
            onPressed: () async => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => const AddPoint(),
              ),
            ),
            icon: const Icon(
              Icons.menu,
              size: 20,
              color: Colors.white,
            ),
          ),
          actions: [IconButton(onPressed: () {}, icon: SvgPicture.asset(Assets.svg.faq))],
        ),
        body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _points.first,
                zoom: 7,
              ),
              markers: _markers,
              onMapCreated: _onMapCreated,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 284,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) async {
                    await _mapController?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: _markers.elementAt(value).position,
                          zoom: 7,
                        ),
                      ),
                    );
                  },
                  itemCount: _markers.length,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: PointInfoCard(
                      pointName: 'Truckee Office BOSS',
                      number: 1,
                      phone: '530-587-1620 opt. 2',
                      mf: '8:30 AM - 5:00 PM',
                      status: 'Closed',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> getBytesFromCanvas(int customNum, int width, int height) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final path_0 = Path()
      ..moveTo(width * 0.8409091, height * 0.3466568)
      ..cubicTo(
        width * 0.8409091,
        height * 0.5255568,
        width * 0.5943182,
        height * 0.9621205,
        width * 0.4886364,
        height * 0.9621205,
      )
      ..cubicTo(
        width * 0.3829545,
        height * 0.9621205,
        width * 0.1363636,
        height * 0.5255568,
        width * 0.1363636,
        height * 0.3466568,
      )
      ..cubicTo(
        width * 0.1363636,
        height * 0.1677552,
        width * 0.2940818,
        height * 0.02272727,
        width * 0.4886364,
        height * 0.02272727,
      )
      ..cubicTo(
        width * 0.6831909,
        height * 0.02272727,
        width * 0.8409091,
        height * 0.1677552,
        width * 0.8409091,
        height * 0.3466568,
      )
      ..close();
    final paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.primaryRed;
    canvas.drawPath(path_0, paint0Fill);
    final paint1Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(Offset(width * 0.4886364, height * 0.3863636), width * 0.2500000, paint1Fill);
    final painter = TextPainter(textDirection: TextDirection.ltr);
    painter
      ..text = TextSpan(
        text: customNum.toString(),
        style: const TextStyle(
          color: Color(0xFF020202),
          fontSize: 40,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.32,
        ),
      )
      ..layout()
      ..paint(canvas, Offset((width * .62) - painter.width, (height * .37) - painter.height * .5));

    final img = await pictureRecorder.endRecording().toImage(width + 20, height + 20);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data?.buffer.asUint8List();
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    final imageFile = File(imagePath);

    final imageBytes = imageFile.readAsBytesSync();

    final completer = Completer<ui.Image>();

    ui.decodeImageFromList(imageBytes, completer.complete);

    return completer.future;
  }

  Future<void> _onMapCreated(GoogleMapController controllerParam) async {
    for (var i = 0; i < _points.length; i++) {
      final markerIcon = await getBytesFromCanvas(i + 1, 88, 88);
      _markers.add(
        Marker(
          markerId: MarkerId('Marker_$i'),
          position: _points[i],
          icon: markerIcon != null ? BitmapDescriptor.fromBytes(markerIcon) : BitmapDescriptor.defaultMarker,
        ),
      );
    }
    final style = await rootBundle.loadString('assets/map_style.json');
    await controllerParam.setMapStyle(style);
    setState(() {
      _mapController = controllerParam;
    });
  }
}

class PointInfoCard extends StatelessWidget {
  const PointInfoCard({
    required this.pointName,
    required this.number,
    required this.phone,
    required this.mf,
    required this.status,
    super.key,
  });

  final String pointName;
  final int number;
  final String phone;
  final String mf;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PointActionButton(onPressed: () {}, text: 'Drive'),
            const SizedBox(width: 16),
            Expanded(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 5,
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryBlack,
                ),
                child: const Text(
                  'Truckee, CA',
                  style: TextStyle(
                    color: Color(0xFF020202),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            PointActionButton(onPressed: () {}, text: 'Details'),
          ],
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          pointName,
                          style: const TextStyle(
                            color: Color(0xFF020202),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.32,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        number.toString(),
                        style: const TextStyle(
                          color: Color(0xFF020202),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OfficeOption(icon: Assets.svg.shipment, name: 'Shipping'),
                      OfficeOption(icon: Assets.svg.kiosk, name: 'Kiosk'),
                      OfficeOption(icon: Assets.svg.store, name: 'Store'),
                      OfficeOption(icon: Assets.svg.print, name: 'Printing'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OfficeInfo(title: 'Phone:', value: ' 530-587-1620 opt. 2'),
                      SizedBox(height: 10),
                      OfficeInfo(title: 'M - F:', value: ' 8:30 AM - 5:00 PM'),
                      SizedBox(height: 10),
                      OfficeInfo(title: 'S:', value: ' Closed'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PointActionButton extends StatelessWidget {
  const PointActionButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Material(
        elevation: 5,
        color: AppColors.primaryRed,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class OfficeInfo extends StatelessWidget {
  const OfficeInfo({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: const TextStyle(
          color: Color(0xFF020202),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.32,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Color(0xFF020202),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.32,
            ),
          )
        ],
      ),
    );
  }
}

class OfficeOption extends StatelessWidget {
  const OfficeOption({required this.icon, required this.name, super.key});

  final String icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(icon, width: 20, height: 20),
        const SizedBox(height: 4),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFF020202),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.32,
          ),
        )
      ],
    );
  }
}
