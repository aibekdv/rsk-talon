import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class TheBranchMapPage extends StatefulWidget {
  final TalonEntity talon;

  const TheBranchMapPage({super.key, required this.talon});

  @override
  State<TheBranchMapPage> createState() => _TheBranchMapPageState();
}

class _TheBranchMapPageState extends State<TheBranchMapPage> {
  String address = '';
  bool isLoading = false;

  List<Marker>? _markers;
  late GoogleMapController mapController;

  CameraPosition? kGooglePlex;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    address = "${widget.talon.branch!.city}, ${widget.talon.branch!.address}";
    isLoading = true;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocationFromAddress(address);
  }

  void getLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        log("Широта: ${location.latitude}, Долгота: ${location.longitude}");

        // get location
        kGooglePlex = CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 17,
        );
        // makers for location
        _markers = <Marker>[
          Marker(
            markerId: const MarkerId("rsk"),
            position: kGooglePlex!.target,
          ),
        ];
        isLoading = false;
        setState(() {});
      } else {
        log("Локация не найдена");
      }
    } catch (e) {
      log("Ошибка при получении локации: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            color: AppColors.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteConst.homePage,
                  );
                },
                child: Image.asset(
                  'assets/icons/appar.png',
                  width: 162.0,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomAppBarWidget(
                title: S.of(context).map,
                centerTitle: true,
              ),
              const SizedBox(
                height: 10,
              ),
              if (isLoading == true)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              if (kGooglePlex != null && isLoading == false)
                Expanded(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: kGooglePlex!,
                    markers: Set<Marker>.of(_markers!),
                    myLocationButtonEnabled: true,
                    minMaxZoomPreference: const MinMaxZoomPreference(0, 19),
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              if (kGooglePlex == null && isLoading == false)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        S.of(context).notFoundOnTheMap,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
