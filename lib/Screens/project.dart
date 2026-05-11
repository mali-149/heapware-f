import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../Data/project.dart';

class Project extends StatefulWidget {
  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text("Projects")),
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
        toolbarHeight: 40,
      ),
      body: ListView.builder(
        itemCount: projectPosts.length,
        itemBuilder: (context, index) {
          final post = projectPosts[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.tealAccent, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(post.userProfileImage),
                    ),
                    title: Text(post.userName, style: TextStyle(color: Colors.white)),
                    subtitle: Text("Just now", style: TextStyle(color: Colors.white70)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(post.description, style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: post.mediaUrls.length,
                      itemBuilder: (context, mediaIndex) {
                        final mediaType = post.mediaTypes[mediaIndex];
                        final url = post.mediaUrls[mediaIndex];

                        if (mediaType == 'video') {
                          return Container(
                            width: 300,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: VideoWidget(videoUrl: url),
                            ),
                          );
                        } else {
                          return Container(
                            width: 300,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(url, fit: BoxFit.cover),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.thumb_up, color: Colors.white70, size: 20),
                        SizedBox(width: 6),
                        Text('${post.likes} Likes', style: TextStyle(color: Colors.white70)),
                        Spacer(),
                        Icon(Icons.comment, color: Colors.white70, size: 20),
                        SizedBox(width: 6),
                        Text('${post.comments} Comments', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// VideoPlayer widget wrapper
class VideoWidget extends StatefulWidget {
  final String videoUrl;
  const VideoWidget({required this.videoUrl});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }
}
