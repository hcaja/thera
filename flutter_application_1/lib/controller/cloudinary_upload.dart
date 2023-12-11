import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

final cloudinaryURI =
    Uri.parse('https://api.cloudinary.com/v1_1/ddkz37nxf/upload');

class UploadController {
  Future<String> uploadFile(XFile filepath) async {
    print('Uploadin');
    final request = http.MultipartRequest('POST', cloudinaryURI)
      ..fields['upload_preset'] = 'ml_default'
      ..files.add(await http.MultipartFile.fromPath('file', filepath.path));
    final response = await request.send();
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      print(jsonMap['url']);
      return jsonMap['url'];
    } else {
      return '';
    }
  }
}
