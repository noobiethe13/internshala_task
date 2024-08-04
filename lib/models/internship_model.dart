class Internship {
  final int id;
  final String title;
  final String companyName;
  final String companyLogo;
  final List<String> locations;
  final String startDate;
  final String duration;
  final String stipend;
  final String postedOn;
  final List<String> labels;
  final String profile;

  Internship({
    required this.id,
    required this.title,
    required this.companyName,
    required this.companyLogo,
    required this.locations,
    required this.startDate,
    required this.duration,
    required this.stipend,
    required this.postedOn,
    required this.labels,
    required this.profile,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      companyName: json['company_name'] ?? 'Unknown Company',
      companyLogo: json['company_logo'] ?? '',
      locations: List<String>.from(json['location_names'] ?? []),
      startDate: json['start_date'] ?? 'Not specified',
      duration: json['duration'] ?? 'Not specified',
      stipend: json['stipend'] != null && json['stipend']['salary'] != null
          ? json['stipend']['salary']
          : 'Not specified',
      postedOn: json['posted_on'] ?? 'Unknown',
      labels: json['labels'] != null && json['labels'].isNotEmpty && json['labels'][0]['label_value'] != null
          ? List<String>.from(json['labels'][0]['label_value'])
          : [],
      profile: json['profile_name'] ?? '',
    );
  }
}