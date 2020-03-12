/*The CategoryBloc is just a regular class. 
It takes an object of CategoryService class 
in the constructor which communicates with the database layer.
*/
import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:expense_manager/db/services/category_service.dart';
import 'package:expense_manager/models/category_model.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final CategoryServiceBase categoryService;

  CategoryBloc(this.categoryService) {
    getCategories();
  }

  var _createCategoryController = BehaviorSubject<CategoryModel>();
  Stream<CategoryModel> get createCategoryStream => _createCategoryController.stream;

  updateCreateCategory(CategoryModel cat) => _createCategoryController.sink.add(cat);

  var _catergoryListController = BehaviorSubject<BuiltList<CategoryModel>>();
  Stream<BuiltList<CategoryModel>> get categoryListStream => _catergoryListController.stream;

  getCategories() {
    categoryService.getAllCategories().then((cats) {
      _catergoryListController.sink.add(cats);
    }
    ).catchError((err) {
      _catergoryListController.sink.add(err);
    });
  }

  Future<void> deleteCategory(int categoryId) async {
    await categoryService.deleteCategory(categoryId).then((value) {
      // re-create list after delete

      getCategories();
    }
    ); 
  } 

  Future<int> createNewCategory(CategoryModel catgory) async {
    return await categoryService.createCategory(catgory);
  }

  dispose() {
    _createCategoryController.close();
    _catergoryListController.close();
  }
}