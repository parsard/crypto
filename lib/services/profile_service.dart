import 'dart:convert';
import 'package:crypto_app/model/user_profile.dart';
import 'package:crypto_app/services/nobitex_service.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  final String _baseUrl = 'https://apiv2.nobitex.ir';
  final NobitexService _nobitexService;
  ProfileService(this._nobitexService);
  Future<UserProfile> fetchUserProfile({required String token}) async {
    final url = Uri.parse('$_baseUrl/users/profile');

    try {
      final response = await _nobitexService.sendRequest(
        () => http.get(url, headers: _nobitexService.tokenHeaders(token)),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok' && data['profile'] != null) {
          // Pass the nested 'profile' object to our model's fromJson factory
          return UserProfile.fromJson(data['profile']);
        } else {
          throw Exception('Failed to parse profile data.');
        }
      } else {
        throw Exception('Failed to load profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Re-throw the exception to be caught by the Cubit
      throw Exception('An error occurred: $e');
    }
  }
}
