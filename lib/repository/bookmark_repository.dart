import 'package:hive/hive.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'dart:typed_data';

import 'package:nytimes/models/bookmark.dart';

Future<Uint8List> networkImageToByte(String link) async {
  Uint8List byteImage = await networkImageToByte(link);
  return byteImage;
}
addItem(Bookmark item) async {
  var box = await Hive.openBox<Bookmark>('bookmarks');

  box.add(item);

}