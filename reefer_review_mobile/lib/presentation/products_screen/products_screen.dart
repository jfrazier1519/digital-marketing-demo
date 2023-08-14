import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_bloc/product_bloc.dart';
import '../../repositories/product_repository/fake_product_repository_impl.dart';
import '../shared/bottom_nav_bar.dart';
import '../shared/navigation_menu.dart';
import 'category_modal.dart';
import 'sort_modal.dart';
import './category_options_enum.dart';
import './sort_options_enum.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(FakeProductRepository())..add(FetchProducts()),
      child: _ProductsScreenContent(),
    );
  }
}

class _ProductsScreenContent extends StatefulWidget {
  @override
  _ProductsScreenContentState createState() => _ProductsScreenContentState();
}

class _ProductsScreenContentState extends State<_ProductsScreenContent> {
  int _currentIndex = 1;
  bool _filterActive = false;
  bool _isCategorySelected = false;
  bool _isSortSelected = false;
  CategoryOptionsEnum? selectedCategory;
  SortOptionsEnum? _selectedSortOption;
  bool _isAscending = true;

  final GlobalKey _categoryButtonKey = GlobalKey();
  final GlobalKey _sortButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.filter_alt_outlined,
                color: _filterActive
                    ? colorScheme.outlineVariant
                    : Colors.white, // Highlighted when active
              ),
              onPressed: () {
                setState(() {
                  _filterActive = !_filterActive; // Toggle filter state
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const NavigationMenu(name: 'User name'),
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
                          showCategoriesModal(
                            context,
                            _categoryButtonKey,
                            BlocProvider.of<ProductBloc>(context),
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
                            (states) => _isCategorySelected ||
                                    selectedCategory != null
                                ? colorScheme.outlineVariant
                                : null), // Highlight if a category is currently selected or _isCategorySelected is true
                      ),
                      child: const Text('Product Category'),
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
                          showSortModal(
                            context,
                            _sortButtonKey,
                            BlocProvider.of<ProductBloc>(context),
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
                                              SortOptionsEnum.Product &&
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
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return CircularProgressIndicator();
                  } else if (state is ProductsLoaded) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) =>
                          state.products[index].displayContent(context),
                    );
                  } else {
                    return Text('Something went wrong!');
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
