class EventItem {
  const EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.dateLabel,
    required this.time,
    required this.venue,
    required this.price,
    required this.seatsLeft,
    required this.description,
  });

  final String id;
  final String title;
  final String category;
  final String dateLabel;
  final String time;
  final String venue;
  final int price;
  final int seatsLeft;
  final String description;
}