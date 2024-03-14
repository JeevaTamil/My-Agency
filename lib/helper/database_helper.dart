import 'package:my_agency/module/customer/model/customer.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    return await openDatabase(
      path,
      version: 2, // Increment the version number
      onCreate: (Database db, int version) async {
        createCustomerTable(db);
        createSupplierTable(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          createSupplierTable(db);
        }
      },
    );
  }

  // Customer Related methods
  Future<void> createCustomerTable(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS customers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            address TEXT,
            city TEXT NOT NULL,
            phn_number INTEGER NOT NULL,
            gst_number TEXT NOT NULL UNIQUE,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
  }

  Future<void> createCustomer(Customer customer) async {
    final db = await database;
    await db.insert('customers', customer.toMap());
  }

  Future<List<Customer>> getCustomers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('customers');
    return List.generate(maps.length, (i) {
      return Customer.fromMap(maps[i]);
    });
  }

  Future<void> updateCustomer(Customer customer) async {
    final db = await database;
    await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<void> deleteCustomerById(int id) async {
    final db = await database;
    await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCustomer(Customer customer) async {
    final db = await database;
    await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  // Supplier Related methods
  Future<void> createSupplierTable(Database db) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS suppliers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            address TEXT,
            city TEXT NOT NULL,
            phn_number INTEGER NOT NULL,
            gst_number TEXT NOT NULL UNIQUE,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
  }

  Future<void> createSupplier(Supplier supplier) async {
    final db = await database;
    await db.insert('suppliers', supplier.toMap());
  }

  Future<List<Supplier>> getSuppliers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('suppliers');
    return List.generate(maps.length, (i) {
      return Supplier.fromMap(maps[i]);
    });
  }

  Future<void> updateSupplier(Supplier supplier) async {
    final db = await database;
    await db.update(
      'suppliers',
      supplier.toMap(),
      where: 'id = ?',
      whereArgs: [supplier.id],
    );
  }

  Future<void> deleteSupplierById(int id) async {
    final db = await database;
    await db.delete(
      'suppliers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteSupplier(Supplier supplier) async {
    final db = await database;
    await db.delete(
      'suppliers',
      where: 'id = ?',
      whereArgs: [supplier.id],
    );
  }
}
