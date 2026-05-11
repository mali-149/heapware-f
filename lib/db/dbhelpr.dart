import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PostModel {
  int? id;
  String type;
  String description;
  String price;
  List<String> mediaPaths;
  List<bool> mediaTypes;

  PostModel({
    this.id,
    required this.type,
    required this.description,
    required this.price,
    required this.mediaPaths,
    required this.mediaTypes,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'price': price,
      'mediaPaths': mediaPaths.join('|'),
      'mediaTypes': mediaTypes.map((e) => e ? '1' : '0').join('|'),
    };
  }

  static PostModel fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      type: map['type'],
      description: map['description'],
      price: map['price'],
      mediaPaths: (map['mediaPaths'] as String).split('|'),
      mediaTypes:
      (map['mediaTypes'] as String).split('|').map((e) => e == '1').toList(),

    );
  }
}

class PostDatabaseHelper {
  static final PostDatabaseHelper instance = PostDatabaseHelper._init();
  static Database? _database;

  PostDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('posts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        description TEXT NOT NULL,
        price TEXT NOT NULL,
        mediaPaths TEXT NOT NULL,
        mediaTypes TEXT NOT NULL
      )
    ''');
  }

  Future<int> createPost(PostModel post) async {
    final db = await instance.database;
    return await db.insert('posts', post.toMap());
  }

  Future<List<PostModel>> getAllPosts() async {
    final db = await instance.database;
    final result = await db.query('posts');
    return result.map((json) => PostModel.fromMap(json)).toList();
  }

  Future<int> updatePost(PostModel post) async {
    final db = await instance.database;
    return await db.update(
      'posts',
      post.toMap(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  Future<int> deletePost(int id) async {
    final db = await instance.database;
    return await db.delete('posts', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
