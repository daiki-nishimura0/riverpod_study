import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mydata.dart';

final _mydataProvider =
StateNotifierProvider<MyData, double>((ref) => MyData());

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 2-1. Text用にConsumerを使う
          Consumer(builder: (context, ref, child) {
            return Text(
              // 2-2. refを用いてstateの値を取り出す
              ref.watch(_mydataProvider).toStringAsFixed(2),
              style: const TextStyle(fontSize: 100),
            );
          }),
          // 3-1. Slider用にConsumerを使う
          Consumer(builder: (context, ref, child) {
            return Slider(
              // 3-2. refを用いてstateの値を取り出す
                value: ref.watch(_mydataProvider),
                // 3-3. changeStateで状態を変える
                onChanged: (value) =>
                    ref.read(_mydataProvider.notifier).changeState(value));
          }),
        ],
      ),
    );
  }
}