import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/account_bloc/account_bloc.dart';
import 'package:reefer_review_mobile/data/models/product_preference.dart';
import 'package:reefer_review_mobile/data/models/requests/update_profile_request.dart';

class ProductPreferenceRow extends StatelessWidget {
  const ProductPreferenceRow({
    super.key,
    required this.preference,
  });

  final ProductPreference preference;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            preference.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          IconButton(
            onPressed: () => _starPressed(context),
            icon: Icon(
              preference.hasLiked ? Icons.star : Icons.star_outline,
              color: preference.hasLiked
                  ? Theme.of(context).colorScheme.onSecondary
                  : null,
            ),
            iconSize: 48,
          ),
        ],
      ),
    );
  }

  _starPressed(BuildContext context) {
    BlocProvider.of<AccountBloc>(context).add(
        UpdateProfileUsecase(UpdateProfileRequest(preference: preference)));
  }
}
