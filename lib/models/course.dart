enum CourseType { ACCESSIBLE, FREE }

class Course {
  Course({
    this.id,
    this.title,
    this.description,
    this.type = CourseType.ACCESSIBLE,
    this.image,
    this.url,
  });

  final String id;
  final String title;
  final String description;
  final CourseType type;
  final String image;
  final String url;

  @override
  String toString() {
    return 'Course{id: $id, title: $title, description: $description, type: $type, url: $url}';
  }
}
