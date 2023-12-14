import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

final cloudinaryURI =
    Uri.parse('https://api.cloudinary.com/v1_1/ddkz37nxf/upload');

class UploadController {
  Future<String> uploadHeader(XFile filepath) async {
    final request = http.MultipartRequest('POST', cloudinaryURI)
      ..fields['upload_preset'] = 'jwjcgwcy'
      ..files.add(await http.MultipartFile.fromPath('file', filepath.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    } else {
      return '';
    }
  }

  Future<String> uploadFile(File filepath) async {
    final request = http.MultipartRequest('POST', cloudinaryURI)
      ..fields['upload_preset'] = 'jwjcgwcy'
      ..files.add(await http.MultipartFile.fromPath('file', filepath.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    } else {
      return '';
    }
  }
}
