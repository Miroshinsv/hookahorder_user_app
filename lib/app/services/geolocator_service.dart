import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocatorService extends GetxService {
  Position? _lastKnownPosition;

  @override
  Future<void> onInit() async {
    await Geolocator.requestPermission();
    _lastKnownPosition = await Geolocator.getLastKnownPosition();
    super.onInit();
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getLastKnowPosition() async {
    return _lastKnownPosition == null ? await getCurrentPosition() : _lastKnownPosition!;
  }
}
