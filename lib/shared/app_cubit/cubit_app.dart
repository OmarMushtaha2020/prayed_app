import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_supplications_application/shared/app_cubit/status.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStatus> {
  late Database db;

  static AppCubit get(context) => BlocProvider.of(context);

  AppCubit() : super(InitialState());

  void crearDb() async {
    openDatabase('supplications.db', version: 1, onCreate: (db, version) {
      db
          .execute(
        'CREATE TABLE myPrayers (id INTEGER PRIMARY KEY, title TEXT, number INTEGER)',
      )
          .then((value) {
        print("Table created");
      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (db) {
      print("Database opened");
    }).then((value) {
      db = value;
      getSupplications(db);
      emit(CreatDb());
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<Map>supplications = [];

  Future<void> insertDb(String title, int number) async {
    await db.rawInsert('INSERT INTO myPrayers(title, number) VALUES(?, ?)',
        [title, number]).then((value) {
      print("Record inserted successfully with ID: $value");
      emit(InsertToDb());
      getSupplications(db);
    }).catchError((error) {
      print(error.toString());
    });
  }

  void getSupplications(Database db) async {
    db.rawQuery('SELECT * FROM myPrayers').then((value) {
      supplications = value;
      print(supplications);
      emit(GetFromDb());
    }).catchError((error) {
      print("Error fetching data: ${error.toString()}");
    });
  }

  void deleteElement(int id) {
    db.rawDelete(
        'DELETE FROM myPrayers WHERE id = ?', [id]).then((value) {
      getSupplications(db);
      emit(DeleteFromDb());
    });
  }
  int number=0;
  void changeValueOfNumber(int num){
    if(number<num){
      number++;
      if(number==num){
        Future.delayed(Duration(seconds: 1)).then((value) {
          number=0;
          emit(ChangeValueNumber());
        });
      }
      print(number);
      emit(ChangeValueNumber());

    }

  }
}
