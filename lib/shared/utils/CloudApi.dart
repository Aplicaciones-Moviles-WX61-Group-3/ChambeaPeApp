import 'dart:typed_data';

import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:mime/mime.dart';

class CloudApi{
  final auth.ServiceAccountCredentials credentials;
  auth.AutoRefreshingAuthClient? client;

  CloudApi(String json):credentials = auth.ServiceAccountCredentials.fromJson(json);

  Future<ObjectInfo> save(String name, Uint8List fileBytes) async{
    client ??= await auth.clientViaServiceAccount(credentials, Storage.SCOPES);

    var storage = Storage(client!, 'chambea-pe-app');
    var bucket = storage.bucket('chambeape-files');
    final type = lookupMimeType(name);
    return await bucket.writeBytes(name, fileBytes, metadata: ObjectMetadata(contentType: type));
  }
}