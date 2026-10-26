// lib/demos/expanded_demo.dart
import 'package:flutter/material.dart';

class ExpandedDemoPage extends StatelessWidget {
  const ExpandedDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('自主实践2 · Expanded 弹性分配'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '① flex 1:2:1'),
              Tab(text: '② flex 2:1:1'),
              Tab(text: '③ 超长内容对比'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _FlexSection(title: 'flex:1 | flex:2 | flex:1', flexes: [1, 2, 1]),
            _FlexSection(title: 'flex:2 | flex:1 | flex:1', flexes: [2, 1, 1]),
            _LongTextSection(),
          ],
        ),
      ),
    );
  }
}

class _FlexSection extends StatelessWidget {
  const _FlexSection({required this.title, required this.flexes});
  final String title;
  final List<int> flexes;

  @override
  Widget build(BuildContext context) {
    const colors = [Colors.red, Colors.blue, Colors.green];
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(12),
        child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      Container(
        margin: const EdgeInsets.all(16), padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          for (int i = 0; i < 3; i++)
            Expanded(
              flex: flexes[i],
              child: Container(
                height: 80, color: colors[i], alignment: Alignment.center,
                child: Text('flex:${flexes[i]}', style: const TextStyle(color: Colors.white, fontSize: 14)),
              ),
            ),
        ]),
      ),
      const Padding(
        padding: EdgeInsets.all(12),
        child: Text('观察：中间（或左边）那块明显更宽', style: TextStyle(color: Colors.black54)),
      ),
    ]);
  }
}

class _LongTextSection extends StatelessWidget {
  const _LongTextSection();

  @override
  Widget build(BuildContext context) {
    const colors = [Colors.red, Colors.blue, Colors.green];
    final longText = 'W' * 50;

    return ListView(padding: const EdgeInsets.all(16), children: [
      Text('⚠ 上半：没加 maxLines —— 会溢出！',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade700)),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: Row(children: [
          Expanded(child: _coloredLongBox(longText, false, colors[0])),
          Expanded(child: _coloredLongBox(longText, false, colors[1])),
          Expanded(child: _coloredLongBox(longText, false, colors[2])),
        ]),
      ),
      const SizedBox(height: 24),
      Text('✅ 下半：加了 maxLines:1 + overflow:ellipsis —— 截断正常',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade700)),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        child: Row(children: [
          Expanded(child: _coloredLongBox(longText, true, colors[0])),
          Expanded(child: _coloredLongBox(longText, true, colors[1])),
          Expanded(child: _coloredLongBox(longText, true, colors[2])),
        ]),
      ),
    ]);
  }

  Widget _coloredLongBox(String text, bool fixOverflow, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: color.withValues(alpha: 0.3),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
        maxLines: fixOverflow ? 1 : null,
        overflow: fixOverflow ? TextOverflow.ellipsis : null,
      ),
    );
  }
}
