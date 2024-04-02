import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/Secret.dart';

class SecretLoader {
  final String secretPath;

  SecretLoader({required this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath,
        (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
