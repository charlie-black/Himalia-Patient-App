class EventImages {
  final int id;
  final String imageUrl;

  EventImages({
    this.id,
    this.imageUrl,

  });

  factory EventImages.fromJson(Map<String, dynamic> jsonData) {
    return EventImages(
      id: jsonData['id'],
      imageUrl: jsonData['thumbnailUrl'],
    );
  }
}