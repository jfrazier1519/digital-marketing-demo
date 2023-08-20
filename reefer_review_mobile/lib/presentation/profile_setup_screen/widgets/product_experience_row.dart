import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/account_bloc/account_bloc.dart';
import 'package:reefer_review_mobile/data/models/requests/update_profile_request.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/widgets/star_row.dart';

import '../../../data/models/product_experience.dart';

class ProductExperienceRow extends StatelessWidget {
  const ProductExperienceRow({super.key, required this.experience});

  final ProductExperience experience;

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      validator: _checkForEmpty,
      builder: (formState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (formState.hasError)
            Text(
              formState.errorText ?? "",
              style: Theme.of(context).inputDecorationTheme.errorStyle,
            ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                StarRow(
                  rating: experience.rating,
                  onSubmit: (rating) =>
                      _updateExperience(experience, rating, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _updateExperience(
      ProductExperience experience, int rating, BuildContext context) {
    final newExperience = experience;
    experience.rating = rating;

    BlocProvider.of<AccountBloc>(context).add(
      UpdateProfileUsecase(
        UpdateProfileRequest(experience: newExperience),
      ),
    );
  }

  String? _checkForEmpty(int? rating) {
    return experience.rating < 1 ? 'Must select rating' : null;
  }
}
