import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/product_experience_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/widgets/product_preference_row.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';

import '../../bloc/user_bloc/user_bloc.dart';

class ProductPreferencesScreen extends StatelessWidget {
  const ProductPreferencesScreen({super.key});

  static const route = '/profile/setup/product-preferences';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Product Preferences",
          ),
          centerTitle: false,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Please select any products you prefer. This will lead to a more customized app experience.',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ProductPreferenceRow(
                            preference: state.user.productPreferences[index]),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: state.user.productPreferences.length,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: ElevatedButton(
                          onPressed: () => _nextPressed(context),
                          child: const Center(child: Text('Next')),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const CustomLoadingIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  _nextPressed(BuildContext context) {
    Navigator.of(context).pushNamed(ProductExperiencesScreen.route);
  }
}
