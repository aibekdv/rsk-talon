import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class TheBranchMapPage extends StatefulWidget {
  const TheBranchMapPage({super.key});

  @override
  State<TheBranchMapPage> createState() => _TheBranchMapPageState();
}

class _TheBranchMapPageState extends State<TheBranchMapPage> {
  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: const MarkerId("rsk"),
      position: kGooglePlex.target,
    ),
  ];
  late GoogleMapController mapController;

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(42.86923338434879, 74.61263345276244),
    zoom: 17,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: kGooglePlex,
                  markers: Set<Marker>.of(_markers),
                  myLocationButtonEnabled: true,
                  minMaxZoomPreference: const MinMaxZoomPreference(0, 19),
                  padding: const EdgeInsets.all(10),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
