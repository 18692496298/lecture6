// lib/demos/stack_badge_demo.dart
import 'package:flutter/material.dart';

class StackBadgeDemoPage extends StatelessWidget {
  const StackBadgeDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自主实践3 · Stack 层叠角标')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('场景一：头像右下角在线状态点', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Stack 里 CircleAvatar 是底图（参与尺寸），Positioned 的绿色角标不参与尺寸',
            style: TextStyle(color: Colors.black54, fontSize: 13)),
        const SizedBox(height: 16),
        Center(child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
          child: Stack(children: [
            const CircleAvatar(
              radius: 48, backgroundColor: Colors.indigo,
              child: Text('姚', style: TextStyle(fontSize: 36, color: Colors.white)),
            ),
            Positioned(right: 2, bottom: 2,
              child: Container(
                width: 18, height: 18,
                decoration: BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                ),
              ),
            ),
          ]),
        )),
        const SizedBox(height: 24),
        const Text('场景二：图片右上角红色消息数字角标', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('底图用 FlutterLogo，角标 Positioned 到右上角', style: TextStyle(color: Colors.black54, fontSize: 13)),
        const SizedBox(height: 16),
        Center(child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
          child: SizedBox(width: 200, height: 200, child: Stack(children: [
            Container(width: 200, height: 200, color: Colors.blueGrey.shade100,
                alignment: Alignment.center, child: const FlutterLogo(size: 120)),
            Positioned(right: 0, top: 0,
              child: Container(
                constraints: const BoxConstraints(minWidth: 24), height: 24,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                alignment: Alignment.center,
                child: const Text('99+',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          ])),
        )),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(12), color: Colors.orange.shade50,
          child: const Text(
            '⚠ 翻车警告：Stack 的非 Positioned 子（如底图）参与 Stack 尺寸计算，Positioned 子不参与。'
            '把 Stack 撑不满时，先给底图或 SizedBox 一个固定尺寸。',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
      ]),
    );
  }
}
