class CourseModel {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final int likes;
  final List comments;
  final int price;
  final String duration;
  final String userId;
  final String userName;
  final String userImage;

  CourseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.likes,
    required this.comments,
    required this.price,
    required this.duration,
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      images: List<String>.from(json['images']),
      likes: json['likes'],
      comments: json['comments'],
      price: json['price'],
      duration: json['duration'],
      userId: json['userId'],
      userName: json['userName'],
      userImage: json['userImage'],
    );
  }
}
