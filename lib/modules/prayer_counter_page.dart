import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_supplications_application/shared/app_cubit/cubit_app.dart';
import 'package:my_supplications_application/shared/app_cubit/status.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PrayerCounterPage extends StatelessWidget {
  String ?title;
  int?number;

  PrayerCounterPage(this.title, this.number);

  @override
  Widget build(BuildContext context) {
    print(title);
    print(number);
    double num = double.parse(number.toString());


    return
      BlocConsumer<AppCubit, AppStatus>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$title", style:
                  TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w500

                  ),),
                  SizedBox(height: 20,),
                  SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                        minimum: 0,
                        maximum: num,
                        showLabels: false,
                        showTicks: false,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          color: Color.fromARGB(30, 0, 169, 181),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: double.parse(AppCubit.get(context).number.toString()),
                            cornerStyle: CornerStyle.bothCurve,
                            width: 0.2,
                            sizeUnit: GaugeSizeUnit.factor,
                            color: Colors.blue, // Set the color here
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              positionFactor: 0.1,
                              angle: 90,
                              widget: Text(
                                '$number / ${AppCubit.get(context).number}',
                                style: const TextStyle(fontSize: 20),
                              ))
                        ])
                  ]),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(onPressed: (){
                        AppCubit.get(context).changeValueOfNumber(number!);
                      },child: const Text(
                        "قم بدعاء",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
  }
}
