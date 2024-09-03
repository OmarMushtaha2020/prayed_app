import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_supplications_application/modules/prayer_counter_page.dart';
import 'package:my_supplications_application/shared/app_cubit/cubit_app.dart';
import 'package:my_supplications_application/shared/app_cubit/status.dart';

class PrayersPage extends StatelessWidget {
  @override
  var form = GlobalKey<FormState>();
  var nameOfTheSupplication = TextEditingController();
  var numberOfTimesYouPray = TextEditingController();

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStatus>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Form(
                                key: form,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "اضافة ذكر",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: nameOfTheSupplication,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "الرجاء ادخال الدعاء";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "ادخل الدعاء",
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: numberOfTimesYouPray,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "الرجاء ادخال عدد مرات الدعاء";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "ادخل عدد مرات  الدعاء",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (form.currentState!.validate()) {
                                              AppCubit.get(context)
                                                  .insertDb(
                                                      nameOfTheSupplication
                                                          .text,
                                                      int.parse(
                                                          numberOfTimesYouPray
                                                              .text))
                                                  .then((value) {
                                                Navigator.pop(context);
                                              });
                                            }
                                          },
                                          child: const Text(
                                            "حفظ الدعاء",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "ادعيتي",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListView.separated(
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrayerCounterPage(
                                      AppCubit.get(context).supplications[index]
                                          ['title'],
                                      AppCubit.get(context).supplications[index]
                                          ['number'])));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${AppCubit.get(context).supplications[index]['title']}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),maxLines: 1,
                                      ),
                                      Text(
                                        "${AppCubit.get(context).supplications[index]['number']}",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      AppCubit.get(context).deleteElement(
                                          AppCubit.get(context)
                                              .supplications[index]['id']);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: AppCubit.get(context).supplications.length),
          ),
        );
      },
    );
  }
}
