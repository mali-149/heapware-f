import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../db/dbhelpr.dart'; // Make sure this is imported


class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  int _selectedToggle = 0; // 0 = Course Post, 1 = Project Post
  bool _isVideo = false;
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  List<File> _mediaFiles = [];
  List<bool> _isVideoList = []; // Track which file is a video
  List<VideoPlayerController> _videoControllers = [];

  void _pickMedia() async {
    final picked = _isVideo
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);
      setState(() {
        _mediaFiles.add(file);
        _isVideoList.add(_isVideo);
      });

      if (_isVideo) {
        final controller = VideoPlayerController.file(file);
        await controller.initialize();
        controller.setLooping(true);
        controller.play();
        setState(() {
          _videoControllers.add(controller);
        });
      }
    }
  }


  Future<void> submitPost() async {
    final type = _selectedToggle == 0 ? "Course" : "Project";
    final description = _descController.text.trim();
    final price = _priceController.text.trim();

    if (description.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all required fields")),
      );
      return;
    }

    final mediaPaths = _mediaFiles.map((file) => file.path).toList();
    final mediaTypes = _isVideoList;

    final post = PostModel(
      type: type,
      description: description,
      price: price,
      mediaPaths: mediaPaths,
      mediaTypes: mediaTypes,
    );

    await PostDatabaseHelper.instance.createPost(post);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post saved successfully!")),
    );

    // Optionally clear the form
    setState(() {
      _descController.clear();
      _priceController.clear();
      _mediaFiles.clear();
      _isVideoList.clear();
      for (var controller in _videoControllers) {
        controller.dispose();
      }
      _videoControllers.clear();
    });
  }


  @override
  void dispose() {
    _descController.dispose();
    _priceController.dispose();
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCourse = _selectedToggle == 0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(child: Text("Create Post")),
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Added to prevent overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello, M.Ali!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              ToggleButtons(
                borderRadius: BorderRadius.circular(10),
                isSelected: [_selectedToggle == 0, _selectedToggle == 1],
                onPressed: (index) {
                  setState(() {
                    _selectedToggle = index;
                    _isVideo = false;
                    _mediaFiles.clear();
                    _isVideoList.clear();
                    for (var controller in _videoControllers) {
                      controller.dispose();
                    }
                    _videoControllers.clear();
                  });
                },
                fillColor: Colors.tealAccent,
                selectedColor: Colors.black,
                color: Colors.white,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Course Post"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Project Post"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildBoxedTextField(
                controller: _descController,
                hint: 'Enter description...',
                maxLines: 4,
              ),
              const SizedBox(height: 15),

              _buildBoxedTextField(
                controller: _priceController,
                hint: 'Enter price...',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              if (!isCourse)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Upload Video", style: TextStyle(color: Colors.white)),
                    Switch(
                      value: _isVideo,
                      activeColor: Colors.tealAccent,
                      onChanged: (val) {
                        setState(() {
                          _isVideo = val;
                        });
                      },
                    )
                  ],
                ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (_) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _buildMediaPickerButton(),
                      )),
                    ),
                  ),
                  ..._mediaFiles.asMap().entries.map((entry) {
                    final index = entry.key;
                    final file = entry.value;
                    final isVid = _isVideoList[index];

                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.tealAccent, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: isVid && index < _videoControllers.length
                            ? AspectRatio(
                          aspectRatio: _videoControllers[index].value.aspectRatio,
                          child: VideoPlayer(_videoControllers[index]),
                        )
                            : Image.file(file, fit: BoxFit.cover),
                      ),
                    );
                  }).toList(),
                ],
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: submitPost,
                child: const Text("Submit Post"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPickerButton() {
    return GestureDetector(
      onTap: _pickMedia,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.tealAccent, width: 2),
        ),
        child: const Icon(Icons.add, color: Colors.tealAccent, size: 30),
      ),
    );
  }

  Widget _buildBoxedTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.tealAccent, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
