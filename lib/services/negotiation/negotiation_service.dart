import 'dart:convert';

import 'package:chambeape/infrastructure/models/negotiation.dart';
import 'package:http/http.dart' as http;

class NegotiationService {
  final uri = Uri.parse(
      'https://chambeape.azurewebsites.net/api/v1/contracts');

  Future<Negotiation> createNegotiation(Negotiation negotiation) async {
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(negotiation.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Negotiation.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception(
          'Failed to create negotiation: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }

  Future<Negotiation> getNegotiationByWorkerIdAndEmployerId(int workerId, int employerId) async {
    final queryParameters = {
      'workerId': workerId.toString(),
      'employerId': employerId.toString(),
    };

    final parsedUri = uri.replace(queryParameters: queryParameters);
    final response = await http.get(parsedUri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      dynamic body = json.decode(utf8.decode(response.bodyBytes));
      Negotiation negotiation = Negotiation.fromJson(body);
      return negotiation;
    }
    else if(response.statusCode == 404 || response.statusCode == 500) {
      return Negotiation(
        id: 0, 
        workerId: 0, 
        employerId: 0, 
        startDay: DateTime.now(), 
        endDay: DateTime.now().add(const Duration(days: 1)), 
        salary: 0, 
        postId: 0
      );
    }
    else {
      throw Exception(
          'Failed to fetch negotiation: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }

  Future<List<Negotiation>> getAllNegotiationsByUserId(String userId) async {
    final response = await http.get(
      Uri.parse('$uri/user/$userId'),);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Negotiation> negotiations =
          body.map((dynamic item) => Negotiation.fromJson(item)).toList();
      return negotiations;
    } else {
      throw Exception(
          'Failed to fetch negotiations: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }

  Future<Negotiation> updateNegotiation(Negotiation negotiation) async {
    final response = await http.put(
      Uri.parse('$uri/${negotiation.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(negotiation.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Negotiation.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception(
          'Failed to update negotiation: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }

}
