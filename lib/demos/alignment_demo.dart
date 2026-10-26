// lib/demos/alignment_demo.dart
import 'package:flutter/material.dart';

class AlignmentDemoPage extends StatefulWidget {
  const AlignmentDemoPage({super.key});

  @override
  State<AlignmentDemoPage> createState() => _AlignmentDemoPageState();
}

class _AlignmentDemoPageState extends State<AlignmentDemoPage> {
  final rowLabels = const [
    'MainAxisAlignment.start',
    'MainAxisAlignment.center',
    'MainAxisAlignment.end',
    'MainAxisAlignment.spaceBetween',
    'MainAxisAlignment.spaceAround',
    'MainAxisAlignment.spaceEvenly',
  ];
  final rowValues = const [
    MainAxisAlignment.start,
    MainAxisAlignment.center,
    MainAxisAlignment.end,
    MainAxisAlignment.spaceBetween,
    MainAxisAlignment.spaceAround,
    MainAxisAlignment.spaceEvenly,
  ];

  int rowIndex = 0;
  int colIndex = 0;

  Widget _block(Color color, double w, double h) {
    return Container(
      width: w, height: h, color: color,
      alignment: Alignment.center,
      child: Text('${w.toInt()}×${h.toInt()}',
          style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('自主实践1 · 对齐任务卡'),
          bottom: const TabBar(tabs: [Tab(text: 'Row 六场景'), Tab(text: 'Column 六场景')]),
        ),
        body: TabBarView(children: [_buildRowDemo(), _buildColDemo()]),
      ),
    );
  }

  Widget _buildRowDemo() {
    final mja = rowValues[rowIndex];
    return Column(children: [
      Container(
        color: Colors.indigo.shade50, padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 6, runSpacing: 6,
          children: List.generate(rowValues.length, (i) {
            return ChoiceChip(
              label: Text('${i + 1}'), selected: rowIndex == i,
              onSelected: (_) => setState(() => rowIndex = i),
            );
          }),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Text('mainAxisAlignment = ${rowLabels[rowIndex]}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(16), padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: mja, crossAxisAlignment: CrossAxisAlignment.center,
            children: [_block(Colors.red, 50, 60), _block(Colors.blue, 50, 80), _block(Colors.green, 50, 40)],
          ),
        ),
      ),
    ]);
  }

  Widget _buildColDemo() {
    final mja = rowValues[colIndex];
    return Column(children: [
      Container(
        color: Colors.purple.shade50, padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 6, runSpacing: 6,
          children: List.generate(rowValues.length, (i) {
            return ChoiceChip(
              label: Text('${i + 1}'), selected: colIndex == i,
              onSelected: (_) => setState(() => colIndex = i),
            );
          }),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Text('Column + ${rowLabels[colIndex]}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(16), padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: mja, crossAxisAlignment: CrossAxisAlignment.center,
            children: [_block(Colors.red, 60, 50), _block(Colors.blue, 80, 50), _block(Colors.green, 40, 50)],
          ),
        ),
      ),
    ]);
  }
}
