import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_bloc/demo_category/category_blog.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryCubit _categoryCubit = CategoryCubit();
  @override
  void initState() {
    _categoryCubit.createListCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' List of categories'),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: _categoryCubit,
        builder: (_, state) {
          if (state is CategoryGettingData) {
            return Center(child: const CircularProgressIndicator());
          }
          if (state is CategoryGetFailed){
            return Center(child: Text('Getting Failed'));
          }
          if (state is CategoryGetSuccess && _categoryCubit.listCategory.isNotEmpty){
            return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 160,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
            ), itemBuilder: (context,index){
              return CategoryItems(categoryModel: _categoryCubit.listCategory[index],
              );
            },
              itemCount: _categoryCubit.listCategory.length,
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
class CategoryItems extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryItems({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(categoryModel.urlPicture??'',
          width: 80,
          height: 80,
        ),
        Text(categoryModel.name??''),
      ],
    );
  }
}
