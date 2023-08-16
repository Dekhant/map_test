import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_task/gen/assets.gen.dart';

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

const LatLng _kMapCenter = LatLng(52.4478, -3.5402);

class MarkerIconsBodyState extends State<MarkerIconsBody> {
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    unawaited(_createMarkerImageFromAsset(context));
    return SafeArea(
      child: Stack(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _kMapCenter,
                zoom: 7,
              ),
              markers: <Marker>{_createMarker()},
              onMapCreated: _onMapCreated,
            ),
          ),
          PageView(
            controller: _pageController,
            children: [],
          ),
        ],
      ),
    );
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter,
        icon: _markerIcon!,
      );
    } else {
      return const Marker(
        markerId: MarkerId('marker_1'),
        position: _kMapCenter,
      );
    }
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final imageConfiguration = createLocalImageConfiguration(context, size: const Size.square(48));
      await BitmapDescriptor.fromAssetImage(imageConfiguration, Assets.svg.faq).then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
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
      children: [
        const Row(
          children: [],
        ),
        const SizedBox(height: 19),
        Material(
          elevation: 1,
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
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
              ],
            ),
          ),
        )
      ],
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
