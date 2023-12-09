

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper
{

  Database? db;

  Future<Database> create_db() async
  {
      if(db==null)
        {
          Directory dir = await getApplicationDocumentsDirectory();
          String path = join(dir.path,"shopping_db");
          var db = await openDatabase(path,version: 1,onCreate: create_table);
          return db;
        }
      else
        {
          return db!;
        }
  }
  create_table(Database db,int version) async
  {
    // Table create
    db.execute("create table products (pid integer primary key autoincrement,productname text,description text,price double,category text)");
    //db.execute("create");

    db.execute("create table emoloyes (eid integer primary key autoincrement,employename text,description text,gender text,department text)");
    print("Table Created");
  }

  Future<int> addproduct(title,description,price,category) async
  {
    var db = await create_db();
    var id = await db.rawInsert("insert into products (productname,description,price,category) values (?,?,?,?)",[title,description,price,category]);
    return id;
  }

   Future<int> addemploye(name,description,Gender,department) async
  {
    var db = await create_db();
    var id = await db.rawInsert("insert into emoloyes (employename,description,gender,department) values (?,?,?,?)",[name,description,Gender,department]);
    return id;
  }

  Future<List> getAllProducts() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from products");
    return data.toList();
  }
  deleteProducts(id) async
  {
    var db = await create_db();
    int status = await db.rawDelete("delete from products where pid=?",[id]);
    return status;
  }

  Future<List> getAllemployes() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from emoloyes");
    return data.toList();
  }

  Future<int> deleteEmployes(id) async
  {
    var db = await create_db();
    int status = await db.rawDelete("delete from emoloyes where eid=?",[id]);
    return status;
  }
  Future<List> getsingleemployee(id) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from emoloyes where eid=?",[id]);
    return data.toList();
  }
  Future<int> updateEmployee(name,description,Gender,department,id) async
  {
    var db = await create_db();
    var status = await db.rawUpdate("update emoloyes set employename=?,description=?,gender=?,department=? where eid=?",[name,description,Gender,department,id]);
    return status;
  }
}