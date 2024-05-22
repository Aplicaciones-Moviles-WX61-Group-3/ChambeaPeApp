import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class MediaService{
  final ImagePicker _picker = ImagePicker();

  MediaService(){}

  Future<File?> getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<File?> getVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      return File(video.path);
    }
    return null;
  }

  Future<File?> getImageOrVideoFromGallery() async {
    final XFile? media = await _picker.pickMedia();
    if (media != null) {
      return File(media.path);
    }
    return null;
  }

  String getFileName(String path){
    return path.split('/').last;
  }

  MediaType getMessageMediaType(String fileName){
    String fileType = lookupMimeType(fileName)!.split('/')[0];

    switch(fileType){
      case 'image':
        return MediaType.image;
      case 'video':
        return MediaType.video;
      default:
        return MediaType.file;
    }
  }
}