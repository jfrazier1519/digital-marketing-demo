import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/bloc/account_bloc/account_bloc.dart';
import 'package:reefer_review_mobile/data/models/requests/update_profile_request.dart';
import 'package:reefer_review_mobile/presentation/shared/image_selector_round.dart';
import 'package:reefer_review_mobile/repositories/account_repository/fake_account_repository.dart';

import '../../res/routes.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _displayNameController = TextEditingController();
  String? _profileImage;

  final _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(FakeAccountRepository.repository)
        ..add(GetAccountUsecase()),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return BlocListener<AccountBloc, AccountState>(
            listener: (context, state) {},
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: const Text('Profile Details'),
                ),
                body: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageSelector(
                          radius: MediaQuery.of(context).size.width * 0.5,
                          onSubmit: _imageSelected,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _displayNameController,
                          validator: (value) => value?.isNotEmpty ?? false
                              ? null
                              : 'This field is required',
                          decoration:
                              const InputDecoration(labelText: 'Display Name'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ElevatedButton(
                            onPressed: () => _submitDetails(context),
                            child: const Center(child: Text('Next')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _imageSelected(String? image) {
    _profileImage = image;
  }

  _submitDetails(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      BlocProvider.of<AccountBloc>(context).add(
        UpdateProfileUsecase(
          UpdateProfileRequest(
            displayName: _displayNameController.text,
            photoUrl: _profileImage,
          ),
        ),
      );
      Navigator.of(context).pushNamed(preferencesSetupScreenViewRoute);
    }
  }
}
