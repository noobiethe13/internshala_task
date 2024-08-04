import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/common/responsive.dart';
import '../../../../providers/internship_provider.dart';
import 'internship_card.dart';

class InternshipListScreen extends ConsumerWidget {
  const InternshipListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internshipsAsyncValue = ref.watch(filteredInternshipsProvider);

    return internshipsAsyncValue.when(
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.lightBlue,
        ),
      ),
      error: (error, stackTrace) {
        print(error);
        return Center(child: Text('Error: $error'));
      },
      data: (internships) {
        if (internships.isEmpty) {
          return const Center(child: Text('No internships found'));
        } else {
          return ListView.builder(
            itemCount: internships.length,
            itemBuilder: (context, index) {
              final internship = internships[index];
              return InternshipCard(internship: internship);
            },
          );
        }
      },
    );
  }
}
