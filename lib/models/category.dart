class Category {
  Category({this.id, this.title});

  final String id;
  final String title;

  @override
  String toString() {
    return 'Category{id: $id, title: $title}';
  }
}
