import 'package:expense_manager/models/category_model.dart';
import 'package:flutter/material.dart';
import 'db/offline_db_provider.dart';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// Above two imports were for the below Error handling code

void main(){

  // FlutterError.onError = (FlutterErrorDetails details){
  //   FlutterError.dumpErrorToConsole(details);
  //   if(kReleaseMode){
  //     exit(1);
  //   }
  // };
  OfflineDbProvider.provider.initDB();
  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // CategoryBloc ctB;

  TabController _tabController;

  List<String> _tabs = ["Home", "Category", "Report"];
  List<CategoryModel> _lsCategories = List<CategoryModel>();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabs.length, vsync: this);

    _initCategories();
  }

  _initCategories() {
    var cat1 = CategoryModel().rebuild((b) => b
      ..id = 0
      ..title = "Home Utils"
      ..desc = "Home utility related expenses"
      ..iconCodePoint = Icons.home.codePoint);

    _lsCategories.add(cat1);

    var cat2 = CategoryModel().rebuild((b) => b
      ..id = 1
      ..title = "Grocery"
      ..desc = "Grocery related expenses"
      ..iconCodePoint = Icons.local_grocery_store.codePoint);

    _lsCategories.add(cat2);

    var cat3 = CategoryModel().rebuild((b) => b
      ..id = 2
      ..title = "Food"
      ..desc = "Food related expenses"
      ..iconCodePoint = Icons.fastfood.codePoint);

    _lsCategories.add(cat3);

    var cat4 = CategoryModel().rebuild((b) => b
      ..id = 3
      ..title = "Auto"
      ..desc = "Car/Bike related expenses"
      ..iconCodePoint = Icons.directions_bike.codePoint);

    _lsCategories.add(cat4);
  }


  Widget _getCategoryTab() {
    return ListView.builder(
      itemCount: _lsCategories.length,
      itemBuilder: (BuildContext context, int index) {
        var category = _lsCategories[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0), // this is 4
            border: new Border.all(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.white,
            ),
          ),
          margin: EdgeInsets.all(12.0),
          child: ListTile(
            onTap: () {
              print("HI");
            },
            leading: Icon(
              IconData(
                category.iconCodePoint,
                fontFamily: 'MaterialIcons'
              ),
              color: Theme.of(context).accentColor,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).primaryColorLight, 
              onPressed: () =>
                  // ctB.deleteCategory(category.id)
                print("Delete button in pressed"),
                // _categoryBloc.deleteCategory(category.id)
              
              ),
            title: Text(
              category.title,
              style: Theme.of(context).textTheme.body2.copyWith(
                color: Theme.of(context).accentColor,
              ),
            ),
            subtitle: Text(
              category.desc,
            ),
          ),
        );
      },
    );
  }
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
         "Expense Manager",
       ),
       bottom: TabBar(
         controller: _tabController,
         tabs: <Widget>[
           Tab(
             icon: Icon(
               Icons.home,
              ),
           ),
           Tab(
             icon: Icon(
               Icons.category,
              ),
           ),
           Tab(
             icon: Icon(
               Icons.report,
              ),
           ),
         ],
       ), 
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: Text(
              "Home",
              style: Theme.of(context).textTheme.display1,
            ),
            // child: _getCategoryTab(),
          ),

          Center(
            // child: Text(
            //   "Category",
            //   style: Theme.of(context).textTheme.display1,
            // ),
            child: _getCategoryTab(),
          ),
          
          Center(
            child: Text(
              "Report",
              style: Theme.of(context).textTheme.display1,
            ),
            // child: _getCategoryTab(),
          ),
          
        ],
      ),
    );
  }
}