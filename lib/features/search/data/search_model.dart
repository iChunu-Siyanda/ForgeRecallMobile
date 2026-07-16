/// The base search model. All items that can be searched inherit from this.
sealed class SearchItem {
  final String id;
  final String title;

  /// Every subclass must implement this to return a single string representation
  /// of all its searchable fields. This is what is fed into the fuzzy search index.
  String get searchString;

  const SearchItem({
    required this.id,
    required this.title,
  });
}

/// Model representation for your Project repository
class ProjectItem extends SearchItem {
  /// The client associated with the project (e.g., "Google", "Local Café")
  final String client;
  
  /// The category or department (e.g., "Mobile App", "Branding")
  final String category;

  const ProjectItem({
    required super.id,
    required super.title,
    required this.client,
    required this.category,
  });

  /// Factory constructor to cleanly convert Firestore maps into ProjectItem instances
  factory ProjectItem.fromFirestore(String id, Map<String, dynamic> data) {
    return ProjectItem(
      id: id,
      title: data['title'] ?? '',
      client: data['client'] ?? '',
      category: data['category'] ?? '',
    );
  }

  /// We index the title, client, and category fields for fuzzy searching.
  @override
  String get searchString => '$title $client $category';
}

/// Model representation for your Topics/Content repository
class TopicItem extends SearchItem {
  /// The main body copy/content of the topic
  final String content;
  
  /// Meta-tags attached to the topic (e.g., ["flutter", "dart", "database"])
  final List<String> tags;

  const TopicItem({
    required super.id,
    required super.title,
    required this.content,
    required this.tags,
  });

  /// Factory constructor to cleanly convert Firestore maps into TopicItem instances
  factory TopicItem.fromFirestore(String id, Map<String, dynamic> data) {
    return TopicItem(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      // Explicitly cast dynamic list safely to List<String>
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  /// We index the title, body content, and the tag words.
  @override
  String get searchString => '$title $content ${tags.join(' ')}';
}
