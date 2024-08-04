import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/filter/ui/screens/filter_screen.dart';
import '../models/internship_model.dart';
import '../services/internship_service.dart';

final totalInternshipsProvider = StateProvider<int>((ref) {
  return 0;
});

final profilesProvider = StateProvider<List<String>>((ref) {
  return [];
});

final citiesProvider = StateProvider<List<String>>((ref) {
  return [];
});

final durationsProvider = StateProvider<List<String>>((ref) {
  return [];
});

final internshipProvider = FutureProvider<List<Internship>>((ref) async {
  final internshipService = InternshipService();
  final internships = await internshipService.fetchInternships();

  ref.read(totalInternshipsProvider.notifier).state = internships.length;

  final profiles = <String>{};
  final cities = <String>{};
  final durations = <String>{};

  for (var internship in internships) {
    profiles.add(internship.profile);
    durations.add(internship.duration);
    cities.addAll(internship.locations);
  }

  ref.read(profilesProvider.notifier).state = profiles.toList();
  ref.read(citiesProvider.notifier).state = cities.toList();
  ref.read(durationsProvider.notifier).state = durations.toList();

  return internships;
});

final filteredInternshipsProvider = StateNotifierProvider<FilteredInternshipsNotifier, AsyncValue<List<Internship>>>((ref) {
  return FilteredInternshipsNotifier(ref);
});

class FilteredInternshipsNotifier extends StateNotifier<AsyncValue<List<Internship>>> {
  final Ref _ref;

  FilteredInternshipsNotifier(this._ref) : super(const AsyncValue.loading()) {
    fetchInternships();
  }

  Future<void> fetchInternships() async {
    state = const AsyncValue.loading();
    try {
      final internshipService = InternshipService();
      final internships = await internshipService.fetchInternships();
      _ref.read(totalInternshipsProvider.notifier).state = internships.length;
      state = AsyncValue.data(internships);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> filterInternships() async {
    state = const AsyncValue.loading();
    try {
      final profiles = _ref.read(selectedProfilesProvider);
      final cities = _ref.read(selectedCitiesProvider);
      final duration = _ref.read(selectedDurationProvider);

      final internshipService = InternshipService();
      final allInternships = await internshipService.fetchInternships();

      List<Internship> filteredInternships = allInternships;

      if (profiles.isNotEmpty) {
        filteredInternships = filteredInternships.where((internship) {
          return profiles.contains(internship.profile);
        }).toList();
      }

      if (cities.isNotEmpty) {
        filteredInternships = filteredInternships.where((internship) {
          return internship.locations.any((location) => cities.contains(location));
        }).toList();
      }

      if (duration != null) {
        filteredInternships = filteredInternships.where((internship) {
          final int internshipDuration = int.tryParse(internship.duration.split(' ')[0]) ?? 0;
          return internshipDuration == duration;
        }).toList();
      }

      _ref.read(totalInternshipsProvider.notifier).state = filteredInternships.length;

      state = AsyncValue.data(filteredInternships);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

