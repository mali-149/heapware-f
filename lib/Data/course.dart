// course_data.dart

class CoursePost {
  final String userName;
  final String userProfileImage;
  final String description;
  final List<String> courseImages; // <-- Changed from String to List<String>
  final int likes;
  final int comments;

  CoursePost({
    required this.userName,
    required this.userProfileImage,
    required this.description,
    required this.courseImages,
    required this.likes,
    required this.comments,
  });
}

List<CoursePost> coursePosts = [
  CoursePost(
    userName: 'Ali Khan',
    userProfileImage: 'https://i.pravatar.cc/150?img=1',
    description: 'Master Flutter in just 30 days!',
    courseImages: [
      'https://i.ytimg.com/vi/VPvVD8t02U8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAXFRlICUnzTXy51j-WokQLu8SIjA',
      'https://i.ytimg.com/vi/VPvVD8t02U8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAXFRlICUnzTXy51j-WokQLu8SIjA',
    ],
    likes: 120,
    comments: 45,
  ),
  CoursePost(
    userName: 'Sara Ali',
    userProfileImage: 'https://i.pravatar.cc/150?img=2',
    description: 'Learn Data Science from scratch 🚀',
    courseImages: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdYmoGba7NbOJCPZuW1nCSREfnpXmm9YWk6A&s',
    ],
    likes: 95,
    comments: 30,
  ),
  CoursePost(
    userName: 'Sara Ali',
    userProfileImage: 'https://i.pravatar.cc/150?img=2',
    description: 'Learn Data Science from scratch 🚀',
    courseImages: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdYmoGba7NbOJCPZuW1nCSREfnpXmm9YWk6A&s',
    ],
    likes: 95,
    comments: 30,
  ),
];
