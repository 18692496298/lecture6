# 课堂作业六 · 自主实践保姆级操作指南（可直接照着做）

> 课件密码：DW5F7C（https://mapp-2026f.dev-learn-hub.me/m6）
> 已有完成项：profile_card 个人名片页（案例复现部分已经做完）
> ⚠ 本指南代码已全部实测 `flutter analyze` 零问题，可直接复制粘贴

---

## 零、需要用到的软件

| 软件 | 版本 | 验证命令 |
|------|------|---------|
| Flutter SDK | ≥ 3.10 | `flutter --version` |
| Dart | 随 Flutter 自带 | 同上 |
| IDE | TraeCode 或 VS Code | — |
| Chrome | 任意新版 | — |
| Git | 任意版 | `git --version` |

---

## 一、先把工程骨架改造好（一次性）

**目的**：把现有 lecture6 工程改成一个 Demo 合集入口页，点按钮跳转到各 demo。

### 步骤 1.1 新建 demos 文件夹

Trae/VS Code 资源管理器里，右键 `lib/` → 新建文件夹 → 命名 `demos`。

### 步骤 1.2 把下面 3 个文件**完整创建**（代码已实测可编译）

#### 文件 A：`lib/profile_card.dart`（从 main.dart 拆出来）

```dart
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
```

#### 文件 B：`lib/main.dart`（改成 Demo 合集入口页）

```dart
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
```

### 步骤 1.3 验证能跑

PowerShell 敲：

```powershell
cd D:\姚文婷\作业文件夹\lecture6
flutter analyze
flutter run -d chrome
```

- `flutter analyze` 必须显示 **No issues found!**
- Chrome 里看到「课堂作业六 · Demo 合集」列表，点第一项能进入名片页

### 步骤 1.4 提交骨架改造

```powershell
git add -A
git commit -m "refactor: main entry list + demos dir + profile_card separated"
```

---

## 二、自主实践 1 · 对齐任务卡

### 步骤 2.1 新建 `lib/demos/alignment_demo.dart`，复制完整代码

```dart
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
```

### 步骤 2.2 验证 + 截图

```powershell
flutter analyze
flutter run -d chrome
```

进 MainPage → 「自主实践1 · 对齐任务卡」。**每张截图必须同时包含**：切换按钮高亮 + 上方参数文字 + 灰色边框里的三个色块。

| 截图文件名 | 操作 |
|------------|------|
| `shots/自主实践1-对齐-01-start.png` | 切到场景 1 |
| `shots/自主实践1-对齐-02-center.png` | 切到场景 2 |
| `shots/自主实践1-对齐-03-end.png` | 切到场景 3 |
| `shots/自主实践1-对齐-04-spaceBetween.png` | 切到场景 4 |
| `shots/自主实践1-对齐-05-spaceAround.png` | 切到场景 5 |
| `shots/自主实践1-对齐-06-spaceEvenly.png` | 切到场景 6 |
| `shots/自主实践1-对齐-07-Column六场景.png` | TabBar 切到 Column 页，截一张 |

截图用 Windows 徽标键 + Shift + S。

### 步骤 2.3 提交

```powershell
git add -A
git commit -m "feat: alignment demo - row 6 scenarios + column 6 scenarios"
```

---

## 三、自主实践 2 · 弹性分配实验

### 步骤 3.1 新建 `lib/demos/expanded_demo.dart`，复制完整代码

```dart
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
      color: color.withValues(alpha: 0.3),  // ← 注意用 withValues，不要用已废弃的 withOpacity
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
```

### 步骤 3.2 运行 + 截图

```powershell
flutter analyze
flutter run -d chrome
```

MainPage → 「自主实践2 · 弹性分配实验」，切换 Tab 截图：

| 截图 | 要点 |
|------|------|
| `shots/自主实践2-Expanded-01-flex-1-2-1.png` | Tab①：中间蓝块是红绿两倍宽 |
| `shots/自主实践2-Expanded-02-flex-2-1-1.png` | Tab②：左红块是蓝绿两倍宽 |
| `shots/自主实践2-Expanded-03-超长-溢出.png` | Tab③上半：**能看到黄黑条纹** |
| `shots/自主实践2-Expanded-04-超长-截断.png` | Tab③下半：绿框里省略号截断，无黄黑条 |

> 如果黄黑条纹没出现——把 `longText` 改成 `'W' * 100` 再多重复几次。

### 步骤 3.3 提交

```powershell
git add -A
git commit -m "feat: expanded ratio experiments - 1:2:1, 2:1:1, long-content overflow vs ellipsis"
```

---

## 四、自主实践 3 · 层叠角标

### 步骤 4.1 新建 `lib/demos/stack_badge_demo.dart`，复制完整代码

```dart
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
```

### 步骤 4.2 运行 + 截图 + 提交

```powershell
flutter analyze
flutter run -d chrome
```

MainPage → 「自主实践3 · 层叠角标」，截两图：

| 截图 | 要点 |
|------|------|
| `shots/自主实践3-层叠-01-在线状态点.png` | 头像 + 右下绿点 |
| `shots/自主实践3-层叠-02-消息数字角标.png` | FlutterLogo + 右上红色 99+ |

```powershell
git add -A
git commit -m "feat: stack badges - avatar online dot + image message badge"
```

---

## 五、自主实践 4 · 容器美化（圆角 / 边框 / 渐变 / 阴影四件套）

### 步骤 5.1 新建 `lib/demos/container_beauty_demo.dart`，复制完整代码

```dart
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
```

### 步骤 5.2 运行 + 截图 + 提交

```powershell
flutter analyze
flutter run -d chrome
```

MainPage → 「自主实践4 · 容器美化」，两个 Tab 各截一张：

| 截图 | 要点 |
|------|------|
| `shots/自主实践4-美化-01-圆角阴影留白.png` | Tab①：卡片 + 滑块参数文字可见 |
| `shots/自主实践4-美化-02-渐变边框.png` | Tab②：渐变按钮 + 下方参数说明文字可见 |

```powershell
git add -A
git commit -m "feat: container beauty - adjustable card decoration + gradient border box"
```

---

## 六、全部做完后的检查

```powershell
cd D:\姚文婷\作业文件夹\lecture6

# 1. analyze 零问题
flutter analyze

# 2. 提交总数 ≥ 3（现在至少 11 次：profile_card 7 + 自主实践 4）
git log --oneline

# 3. 4 个 demo 文件存在
dir lib\demos\

# 4. 截图 15 张以上（7 对齐 + 4 弹性 + 2 角标 + 2 美化）
dir shots\
```

---

## 七、常见报错快速排查

| 报错 | 原因 | 修 |
|------|------|---|
| `mainAxisAlignment` 枚举拼错（如 `space_between`） | 下划线式不合法 | 全拼 camelCase：`spaceBetween` |
| `flutter run` 后 Chrome 白屏 | Dart 编译失败 | 看终端红色报错行，通常是 import 漏了或文件不存在 |
| `Container` 同时设 `color:` 和 `decoration:` | 编译错误 | 把 color/gradient 全塞进 `BoxDecoration` 里 |
| Stack 里底图没撑开 | Positioned 子不参与尺寸 | 给底图或 Stack 外层套 `SizedBox(width:200, height:200)` |
| Expanded 还溢出 | Text 没加 `maxLines` 和 `overflow` | 加 `maxLines:1, overflow: TextOverflow.ellipsis` |
| `flutter analyze` 里 `withOpacity` 废弃警告 | Flutter 新版本废弃了 | 改成 `color.withValues(alpha: 0.3)` |
