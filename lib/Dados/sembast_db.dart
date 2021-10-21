import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembastteste1/Models/Cadastro.dart';


class SembastDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  late Database _db;
  final store = intMapStoreFactory.store('cadastros');
  static SembastDb _singleton = SembastDb._internal();

  SembastDb._internal(){}

  factory SembastDb() {
    return _singleton;
  }

  Future<Database> init() async {
    if (_db == null) {
      _db = await _openDb();
    }
    return _db;
  }

  Future _openDb() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docsDir.path, 'cadastro.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> addCadastro(Cadastro cadastro) async {
    int id = await store.add(_db, cadastro.toMap());
    return id;
  }

  Future getCadastro() async {
    await init();
    final finder = Finder(sortOrders: [SortOrder('nome')]);
    final snapshot = await store.find(_db, finder: finder);
    return snapshot.map((item) {
      final pwd = Cadastro.fromMap(item.value);
      pwd.id = item.key;
      return pwd;
    }).toList();
  }

  Future updateCadastro(Cadastro cad) async {
    final finder = Finder(filter: Filter.byKey(cad.id));
    await store.update(_db, cad.toMap(), finder: finder);
  }

  Future deleteCadastro(Cadastro cad) async {
    final finder = Finder(filter: Filter.byKey(cad.id));
    await store.delete(_db, finder: finder);
  }

  Future deleteAll() async {
    await store.delete(_db);
  }
}
