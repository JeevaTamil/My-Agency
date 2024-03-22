import 'package:my_agency/module/bill_inward/model/bill_inward.dart';
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
    print('opening database');
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    return await openDatabase(
      path,
      version: 1, // Increment the version number
      onCreate: (Database db, int version) async {
        print('database on create');
        createCustomerTable();
        createSupplierTable();
        createBillInwardTable();
      },
      // onUpgrade: (Database db, int oldVersion, int newVersion) async {
      //   if (oldVersion < 2) {
      //     createSupplierTable();
      //     createBillInwardTable();
      //   }
      // },
    );
  }

  Future<void> flushDatabaseAndStartFreshly() async {
    print('flush db');
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    // Delete the existing database
    await deleteDatabase(path);

    // Reinitialize the database
    _database = null; // Ensure the cached database instance is reset
    await initDatabase(); // This will recreate the database
  }

  // Customer Related methods
  Future<void> createCustomerTable() async {
    print('database on createCustomerTable');
    final db = await database;
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

  Future<Customer?> getCustomer(int customerId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'customers',
      where: 'id = ?',
      whereArgs: [customerId],
    );

    if (maps.isNotEmpty) {
      // Assuming your Customer model has a factory constructor fromMap
      return Customer.fromMap(maps.first);
    }
    return null; // Return null if the customer is not found
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
  Future<void> createSupplierTable() async {
    print('database on createSupplierTable');
    final db = await database;
    await db.execute('''
          CREATE TABLE IF NOT EXISTS suppliers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            address TEXT,
            city TEXT NOT NULL,
            phn_number INTEGER NOT NULL,
            gst_number TEXT NOT NULL UNIQUE,
            commission INTEGER NOT NULL DEFAULT 2,
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

  Future<Supplier?> getSupplier(int supplierId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'suppliers',
      where: 'id = ?',
      whereArgs: [supplierId],
    );

    if (maps.isNotEmpty) {
      // Assuming your Supplier model has a factory constructor fromMap
      return Supplier.fromMap(maps.first);
    }
    return null; // Return null if the supplier is not found
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

  // Bill Inward related methods
  Future<void> createBillInwardTable() async {
    print('database on createBillInwardTable');
    final db = await database;
    await db.execute('''
      CREATE TABLE IF NOT EXISTS billInwards(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer TEXT,
        supplier TEXT,
        billNumber TEXT,
        billDate TEXT,
        productQty INTEGER,
        billAmount REAL,
        discountType TEXT,
        discountAmount REAL,
        netAmount REAL,
        taxType TEXT,
        taxAmount REAL,
        finalBillAmount REAL,
        transportName TEXT,
        lrNumber TEXT,
        lrDate TEXT,
        bundleQty INTEGER,
        image BLOB,
        createdAt TEXT,
        updatedAt TEXT,
        FOREIGN KEY (customer) REFERENCES customers(id),
        FOREIGN KEY (supplier) REFERENCES suppliers(id)
      )
    ''');
  }

  Future<List<BillInward>> getBillInwards() async {
    final db =
        await database; // Assuming 'database' is a getter that returns the database instance
    final List<Map<String, dynamic>> maps = await db.query('billInwards');

    return List.generate(maps.length, (i) {
      return BillInward.fromMap(maps[i]);
    });
  }

  Future<void> updateBillInward(BillInward billInward) async {
    final db = await database;
    await db.update(
      'billInwards',
      billInward.toMap(),
      where: 'id = ?',
      whereArgs: [billInward.id],
    );
  }

  Future<void> createBillInward(BillInward billInward) async {
    final db = await database;
    await db.insert(
      'billInwards',
      billInward.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBillInward(BillInward billInward) async {
    final db = await database;
    await db.delete(
      'billInwards',
      where: 'id = ?',
      whereArgs: [billInward.id],
    );
  }
}
