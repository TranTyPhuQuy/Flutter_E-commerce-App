// import 'package:idb_sqflite/idb_sqflite.dart';
// import 'package:e_commerce_app/models/cart.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io' as io;
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DBHelper {
//   static DatabaseFactory? _dbFactory;

//   Future<DatabaseFactory?> get dbFactory async {
//     if (_dbFactory != null) {
//       return _dbFactory;
//     }

//     _dbFactory = await initDatabase();
//   }

//   initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'cart.db');
//     var dbFactory = getIdbFactorySqflite(databaseFactory);
//     return dbFactory;
//   }

//   _onCreate(Database db, int version) async {
//     await db.transaction((txn) async {
//       var store = txn.createObjectStore('cart', keyPath: 'id', autoIncrement: true);
//       store.createIndex('productId', 'productId', unique: true);
//       store.createIndex('productName', 'productName');
//       store.createIndex('initialPrice', 'initialPrice');
//       store.createIndex('productPrice', 'productPrice');
//       store.createIndex('quantity', 'quantity');
//       store.createIndex('unitTag', 'unitTag');
//       store.createIndex('image', 'image');
//     });
//   }

//   Future<Cart> insert(Cart cart) async {
//     var dbFactory = await dbFactory;
//     var db = await dbFactory!.openDatabase('cart.db', version: 1, onUpgradeNeeded: _onCreate);
//     var txn = db.transaction('cart', idbModeReadWrite);
//     var store = txn.objectStore('cart');
//     await store.put(cart.toMap());
//     return cart;
//   }
// }
