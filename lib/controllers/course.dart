import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/course.dart';

class CourseController extends GetxController {
  var isLoading = false.obs;
  var courses = <CourseModel>[].obs;
  var filteredCourses = <CourseModel>[].obs;

  final searchQuery = ''.obs;

  @override
  void onInit() {
    fetchCourses();
    debounce(searchQuery, (_) => filterCourses(), time: Duration(milliseconds: 300));
    super.onInit();
  }

  void fetchCourses() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://heapware.onrender.com/api/courses'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        courses.value = data.map((e) => CourseModel.fromJson(e)).toList();
        filteredCourses.value = courses;
      } else {
        print("Failed to load courses");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterCourses() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredCourses.value = courses;
    } else {
      filteredCourses.value = courses.where((course) {
        return course.userName.toLowerCase().contains(query) ||
            course.description.toLowerCase().contains(query);
      }).toList();
    }
  }
}
