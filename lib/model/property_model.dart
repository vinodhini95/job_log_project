
import 'package:image_picker/image_picker.dart';

class Property {
  final String id;
  final String title;
  int viewCount;
  Duration totalTimeSpent;
  XFile imagePath;

  Property({
    required this.id,
    required this.title,
    required this.imagePath,
    this.viewCount = 0,
    this.totalTimeSpent = Duration.zero,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'viewCount': viewCount,
      'totalTimeSpent': totalTimeSpent.inMilliseconds, // store as int
      'imagePath': imagePath.path, // just store path as String
    };
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      title: json['title'],
      viewCount: json['viewCount'] ?? 0,
      totalTimeSpent: Duration(milliseconds: json['totalTimeSpent'] ?? 0),
      imagePath: json['imagePath'], // reconstruct XFile from path
    );
  }
}
