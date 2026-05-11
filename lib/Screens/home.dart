import 'package:flutter/material.dart';
import '../db/dbhelpr.dart'; // Ensure your PostModel includes mediaPaths and mediaTypes
import 'dart:io'; // Make sure to import this for File class

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostModel> _posts = [];
  List<PostModel> _filteredPosts = [];
  final PostDatabaseHelper _dbHelper = PostDatabaseHelper.instance;
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  final int likeCount = 0;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final data = await _dbHelper.getAllPosts();
    setState(() {
      _posts = data;
      _filteredPosts = data;
      _isLoading = false;
    });
  }

  void _searchPosts(String query) {
    setState(() {
      _filteredPosts = _posts.where((post) =>
      post.type.toLowerCase().contains(query.toLowerCase()) ||
          post.description.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _deletePost(int id) async {
    await _dbHelper.deletePost(id);
    await _loadPosts();
  }

  void _showEditDialog(PostModel post) {
    final typeController = TextEditingController(text: post.type);
    final descriptionController = TextEditingController(text: post.description);
    final priceController = TextEditingController(text: post.price);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Edit Post", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Type",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            TextField(
              controller: descriptionController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
            TextField(
              controller: priceController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Price",
                labelStyle: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () async {
              final updatedPost = PostModel(
                id: post.id,
                type: typeController.text,
                description: descriptionController.text,
                price: priceController.text,
                mediaPaths: post.mediaPaths,
                mediaTypes: post.mediaTypes,
              );
              await _dbHelper.updatePost(updatedPost);
              Navigator.pop(context);
              await _loadPosts();
            },
            child: const Text("Save", style: TextStyle(color: Colors.tealAccent)),
          ),
        ],
      ),
    );
  }

  void _increaseLikeCount(PostModel post) async {
    // likeCount += 1;
    await _dbHelper.updatePost(post); // Assuming PostModel has a likeCount field.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Posts"),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _searchPosts,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[850],
                hintText: 'Search posts...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.tealAccent))
                  : ListView.builder(
                itemCount: _filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = _filteredPosts[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.tealAccent),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Static User Info
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://www.example.com/user_profile_image.jpg'),
                              radius: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'John Doe', // Static Name
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, color: Colors.white),
                              itemBuilder: (BuildContext context) {
                                return ['Edit', 'Delete'].map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                              onSelected: (choice) {
                                if (choice == 'Edit') {
                                  _showEditDialog(post);
                                } else if (choice == 'Delete') {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text("Delete Post"),
                                      content: const Text(
                                          "Are you sure you want to delete this post?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        TextButton(
                                          child: const Text("Delete"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _deletePost(post.id!);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Post Content
                        Text(post.type,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(post.description,
                            style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        if (post.mediaPaths.isNotEmpty)
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: post.mediaPaths.length,
                              itemBuilder: (context, index) {
                                // Convert string path to File object
                                final imageFile = File(post.mediaPaths[index]);
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      imageFile, // Use the File object here
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text("Price: ${post.price}",
                            style: const TextStyle(color: Colors.tealAccent)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_up_alt_outlined,
                                  color: Colors.white70, size: 18),
                              onPressed: () => _increaseLikeCount(post),
                            ),
                            Text("likeCount}",
                                style: const TextStyle(color: Colors.white70)),
                            const SizedBox(width: 16),
                            const Icon(Icons.comment_outlined,
                                color: Colors.white70, size: 18),
                            const SizedBox(width: 4),
                            const Text("0", style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
