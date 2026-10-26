// lib/profile_card.dart
import 'package:flutter/material.dart';

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '个人名片',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ProfileCardPage(),
    );
  }
}

class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(title: const Text('个人名片')),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 48, backgroundColor: Colors.indigo,
                          child: Text('姚', style: TextStyle(fontSize: 36, color: Colors.white)),
                        ),
                        Positioned(
                          right: 2, bottom: 2,
                          child: Container(
                            width: 18, height: 18,
                            decoration: BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('姚文婷', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('移动应用开发学习者 · Flutter 在路上',
                        style: TextStyle(fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FB), borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))],
                      ),
                      child: const Row(
                        children: [
                          Expanded(child: _StatItem(value: '128', label: '帖子')),
                          Expanded(child: _StatItem(value: '256', label: '关注')),
                          Expanded(child: _StatItem(value: '1024', label: '粉丝')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8, runSpacing: 8, alignment: WrapAlignment.center,
                      children: const [
                        _TagChip('摄影'), _TagChip('读书'), _TagChip('Flutter'),
                        _TagChip('旅行'), _TagChip('美食'), _TagChip('音乐'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
    ]);
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(16)),
      child: Text(text, style: TextStyle(fontSize: 13, color: Colors.indigo.shade700)),
    );
  }
}
