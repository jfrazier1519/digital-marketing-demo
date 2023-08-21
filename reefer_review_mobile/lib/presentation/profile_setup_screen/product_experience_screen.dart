import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/profile_setup_screen.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/widgets/product_experience_row.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';

import '../../bloc/user_bloc/user_bloc.dart';

class ProductExperiencesScreen extends StatefulWidget {
  const ProductExperiencesScreen({super.key});

  static const route = '/profile/setup/product-experience';

  @override
  State<ProductExperiencesScreen> createState() =>
      _ProductExperiencesScreenState();
}

class _ProductExperiencesScreenState extends State<ProductExperiencesScreen> {
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Experience'),
                centerTitle: false,
              ),
              body: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Please rate each item with how much experience You have using each Product. ',
                            ),
                            TextSpan(
                              text:
                                  '1 star being the least experience 5 being most experience.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _globalKey,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ProductExperienceRow(
                              experience:
                                  state.account.productExperiences[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: state.account.productExperiences.length,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: ElevatedButton(
                          onPressed: () => _finishPressed(context),
                          child: const Center(child: Text('Finish')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CustomLoadingIndicator());
        }
      },
    );
  }

  _finishPressed(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      Navigator.of(context).pushNamed(ProfileSetupScreen.route);
    }
  }
}
