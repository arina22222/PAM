import 'package:get/get.dart';
import '../models/wine_response.dart';
import '../services/api_service.dart';

class WineController extends GetxController {
  var isLoading = true.obs;
  var wineResponse = WineResponse(winesBy: [], carousel: []).obs;

  @override
  void onInit() {
    fetchWines();
    super.onInit();
  }

  void fetchWines() async {
    try {
      isLoading(true);
      ApiService apiService = ApiService();
      wineResponse.value = await apiService.loadWines();
    } finally {
      isLoading(false);
    }
  }
}
