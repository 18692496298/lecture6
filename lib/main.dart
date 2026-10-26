// lib/main.dart
import 'package:flutter/material.dart';
import 'package:lecture6/profile_card.dart';
import 'package:lecture6/demos/alignment_demo.dart';
import 'package:lecture6/demos/expanded_demo.dart';
import 'package:lecture6/demos/stack_badge_demo.dart';
import 'package:lecture6/demos/container_beauty_demo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '课堂作业六',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = const [
      '案例复现 · profile_card',
      '自主实践1 · 对齐任务卡',
      '自主实践2 · 弹性分配实验',
      '自主实践3 · 层叠角标',
      '自主实践4 · 容器美化',
    ];
    final routes = <Widget Function()>[
      () => const ProfileCardPage(),
      () => const AlignmentDemoPage(),
      () => const ExpandedDemoPage(),
      () => const StackBadgeDemoPage(),
      () => const ContainerBeautyDemoPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('课堂作业六 · Demo 合集')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: titles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          return ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => routes[i]()),
            ),
            icon: const Icon(Icons.chevron_right),
            label: Text(titles[i], style: const TextStyle(fontSize: 16)),
          );
        },
      ),
    );
  }
}
