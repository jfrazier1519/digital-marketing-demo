import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reefer_review_mobile/presentation/brands_screen/brands_widget.dart';
import 'package:reefer_review_mobile/presentation/shared/navigation_menu.dart';
import '../../bloc/brand_bloc/brand_bloc.dart';
import '../../repositories/brand_repository/fake_brand_repository_impl.dart';
import '../products_screen/products_category_enum.dart';
import './brands_sort_enum.dart';
import 'brands_category_modal.dart';
import 'brands_sort_modal.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({Key? key}) : super(key: key);
  static const route = '/brands';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BrandBloc(FakeBrandRepository.repository)..add(FetchBrands()),
      child: _BrandsScreenContent(),
    );
  }
}

class _BrandsScreenContent extends StatefulWidget {
  @override
  _BrandsScreenContentState createState() => _BrandsScreenContentState();
}

class _BrandsScreenContentState extends State<_BrandsScreenContent> {
  final int _currentIndex = 3;
  final bool _filterActive = false;
  bool _isCategorySelected = false;
  bool _isSortSelected = false;
  ProductsCategoryEnum? selectedCategory;
  BrandsSortEnum? _selectedSortOption;
  bool _isAscending = true;

  final GlobalKey _categoryButtonKey = GlobalKey();
  final GlobalKey _sortButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          if (_filterActive)
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    key: _categoryButtonKey,
                    onPressed: () {
                      if (_isCategorySelected) {
                        Navigator.pop(context);
                        setState(() {
                          _isCategorySelected = false;
                        });
                      } else {
                        setState(() {
                          _isCategorySelected = true;
                          _isSortSelected = false;
                        });
                        showBrandCategoriesModal(
                          context,
                          _categoryButtonKey,
                          BlocProvider.of<BrandBloc>(context),
                          selectedCategory,
                          (category) {
                            if (category == selectedCategory) {
                              setState(() {
                                selectedCategory = null;
                              });
                            } else {
                              setState(() {
                                selectedCategory = category;
                              });
                            }
                          },
                        ).then((_) {
                          setState(() {
                            _isCategorySelected = false;
                          });
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) =>
                              _isCategorySelected || selectedCategory != null
                                  ? colorScheme.outlineVariant
                                  : null),
                    ),
                    child: const Text('Brand Category'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    key: _sortButtonKey,
                    onPressed: () {
                      if (_isSortSelected) {
                        Navigator.pop(context);
                        setState(() {
                          _isSortSelected = false;
                        });
                      } else {
                        setState(() {
                          _isCategorySelected = false;
                          _isSortSelected = true;
                        });
                        showBrandSortModal(
                          context,
                          _sortButtonKey,
                          BlocProvider.of<BrandBloc>(context),
                          (sortOption, isAscendingDirection) {
                            setState(() {
                              _selectedSortOption = sortOption;
                              _isAscending = isAscendingDirection;
                            });
                          },
                          initialSortOption: _selectedSortOption,
                          initialIsAscending: _isAscending,
                          selectedCategory: selectedCategory,
                        ).then((_) {
                          setState(() {
                            _isSortSelected = false;
                          });
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => _isSortSelected ||
                                (_selectedSortOption != null &&
                                    !(_selectedSortOption ==
                                            BrandsSortEnum.Brand &&
                                        _isAscending))
                            ? colorScheme.outlineVariant
                            : null,
                      ),
                    ),
                    child: const Text('Sort'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {
                if (state is BrandLoading) {
                  return const CircularProgressIndicator();
                } else if (state is BrandsLoaded) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: state.brands.length,
                    itemBuilder: (context, index) =>
                        BrandWidget(brand: state.brands[index]),
                  );
                } else {
                  return const Text('Something went wrong!');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
