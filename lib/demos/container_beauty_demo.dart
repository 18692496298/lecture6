// lib/demos/container_beauty_demo.dart
import 'package:flutter/material.dart';

class ContainerBeautyDemoPage extends StatefulWidget {
  const ContainerBeautyDemoPage({super.key});

  @override
  State<ContainerBeautyDemoPage> createState() => _ContainerBeautyDemoPageState();
}

class _ContainerBeautyDemoPageState extends State<ContainerBeautyDemoPage> {
  double borderRadius = 12;
  double shadowBlur = 8;
  double shadowOffsetY = 2;
  double padding = 20;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('自主实践4 · 容器美化四件套'),
          bottom: const TabBar(tabs: [Tab(text: '① 圆角/阴影/留白'), Tab(text: '② 渐变+边框')]),
        ),
        body: TabBarView(children: [_buildAdjustableCard(), _buildGradientBox()]),
      ),
    );
  }

  Widget _buildAdjustableCard() {
    return Column(children: [
      Container(
        color: Colors.indigo.shade50, padding: const EdgeInsets.all(12),
        child: Column(children: [
          _sliderRow('圆角 borderRadius', borderRadius, 0, 32, (v) => setState(() => borderRadius = v)),
          _sliderRow('阴影 blurRadius', shadowBlur, 0, 30, (v) => setState(() => shadowBlur = v)),
          _sliderRow('阴影 offsetY', shadowOffsetY, 0, 20, (v) => setState(() => shadowOffsetY = v)),
          _sliderRow('留白 padding', padding, 0, 50, (v) => setState(() => padding = v)),
        ]),
      ),
      const SizedBox(height: 12),
      Expanded(child: Center(child: Container(
        margin: const EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: shadowBlur, offset: Offset(0, shadowOffsetY))],
        ),
        child: const Text('我是卡片内容\n拖动上方滑块看圆角/阴影/留白变化',
            style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
      ))),
      Text(
        'borderRadius=${borderRadius.toStringAsFixed(0)}  blur=${shadowBlur.toStringAsFixed(0)}  '
        'offsetY=${shadowOffsetY.toStringAsFixed(0)}  padding=${padding.toStringAsFixed(0)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
    ]);
  }

  Widget _sliderRow(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Row(children: [
      SizedBox(width: 120, child: Text(label)),
      Expanded(child: Slider(value: value, min: min, max: max, onChanged: onChanged)),
      SizedBox(width: 50, child: Text(value.toStringAsFixed(1))),
    ]);
  }

  Widget _buildGradientBox() {
    return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Colors.indigo, Colors.purpleAccent]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orangeAccent, width: 2),
          boxShadow: const [BoxShadow(color: Colors.purple, blurRadius: 12, offset: Offset(0, 4))],
        ),
        child: const Text('渐 变 按 钮',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(12), color: Colors.grey.shade100,
        child: const Text(
          '参数：gradient(Linear indigo→purpleAccent) + borderRadius(16) '
          '+ border(orangeAccent width:2) + boxShadow(purple blur:12)',
          style: TextStyle(fontSize: 13),
        ),
      ),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(12), color: Colors.red.shade50,
        child: const Text(
          '⚠ 翻车警告：Container 不能同时写 color 和 decoration！'
          '要放颜色/渐变，全塞进 BoxDecoration 里。',
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
    ]));
  }
}
