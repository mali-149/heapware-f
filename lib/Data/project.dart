// lib/Data/project_data.dart

class ProjectPost {
  final String userName;
  final String userProfileImage;
  final String description;
  final List<String> mediaUrls; // Can be image or video URLs
  final List<String> mediaTypes; // 'image' or 'video'
  final int likes;
  final int comments;

  ProjectPost({
    required this.userName,
    required this.userProfileImage,
    required this.description,
    required this.mediaUrls,
    required this.mediaTypes,
    required this.likes,
    required this.comments,
  });
}

List<ProjectPost> projectPosts = [
  ProjectPost(
    userName: 'John Doe',
    userProfileImage: 'https://i.pravatar.cc/150?img=3',
    description: 'Check out this amazing IoT project!',
    mediaUrls: [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://i.ytimg.com/vi/VPvVD8t02U8/hqdefault.jpg',
    ],
    mediaTypes: ['video', 'image'],
    likes: 80,
    comments: 22,
  ),
  ProjectPost(
    userName: 'Mary Jane',
    userProfileImage: 'https://i.pravatar.cc/150?img=4',
    description: 'My latest Flutter app 💻📱',
    mediaUrls: [
      'https://i.imgur.com/OvMZBs9.jpg',
      'https://i.imgur.com/C0oXKzH.jpg',
    ],
    mediaTypes: ['image', 'image'],
    likes: 150,
    comments: 40,
  ),
];
