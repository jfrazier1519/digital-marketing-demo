import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/profile_setup_screen/widgets/product_preference_row.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';
import 'package:reefer_review_mobile/repositories/account_repository/fake_account_repository.dart';
import 'package:reefer_review_mobile/res/routes.dart';

import '../../bloc/account_bloc/account_bloc.dart';

class ProductPreferencesScreen extends StatelessWidget {
  const ProductPreferencesScreen({super.key});

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
          child: BlocProvider(
            create: (context) => AccountBloc(FakeAccountRepository.repository)
              ..add(GetAccountUsecase()),
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountLoaded) {
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
                              preference:
                                  state.account.productPreferences[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: state.account.productPreferences.length,
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
      ),
    );
  }

  _nextPressed(BuildContext context) {
    Navigator.of(context).pushNamed(productExperienceViewRoute);
  }
}
