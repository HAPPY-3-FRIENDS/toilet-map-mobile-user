import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  Future<int?> getAccountId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt("accountId");
  }

  Future<String?> getUsername() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("username");
  }

  Future<String?> getAccessToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("accessToken");
  }

  Future<List<double?>> getCurrentLatLong() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return [
      sharedPreferences.getDouble("latitude"),
      sharedPreferences.getDouble("longtitude"),
    ];
  }

  Future setCurrentLatLong(lat, long) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return [
      sharedPreferences.setDouble("latitude", lat),
      sharedPreferences.setDouble("longtitude", long),
    ];
  }

  Future<List<String>?> getPayment() async {
    print('test get payment');
    final sharedPreferences = await SharedPreferences.getInstance();
    String? paymentMethod = sharedPreferences.getString("defaultPayment");
    String? accountTurn = sharedPreferences.getInt("accountTurn").toString();
    String? accountBalance = sharedPreferences.getInt("accountBalance").toString();
    List<String> payments = [paymentMethod!, accountTurn!, accountBalance!];
    print(payments[0]);
    return payments;
  }
}