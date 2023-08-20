import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:reefer_review_mobile/presentation/shared/custom_loading_indicator.dart';
import 'package:reefer_review_mobile/repositories/user_repository/fake_user_repository.dart';
import 'package:reefer_review_mobile/res/themes/light_theme.dart';
import 'package:reefer_review_mobile/routes/router.dart' as router;

import 'bloc/user_bloc/user_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(FakeUserRepository.repository),
      child: GlobalLoaderOverlay(
        overlayColor: Colors.black,
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: CustomLoadingIndicator(),
        ),
        child: MaterialApp(
          onGenerateRoute: router.generateRoute,
          theme: lightTheme,
        ),
      ),
    );
  }
}
