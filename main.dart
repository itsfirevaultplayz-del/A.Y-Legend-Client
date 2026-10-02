import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const AYLegendApp());

class AYLegendApp extends StatelessWidget {
  const AYLegendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A.Y Legend Client',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF07080D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1677FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class ClientSettings {
  bool hud = true;
  bool pvp = true;
  bool fps = true;
  bool lowGraphics = false;
  bool crosshair = true;
  bool keystrokes = false;
  bool neon = true;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    hud = p.getBool('hud') ?? true;
    pvp = p.getBool('pvp') ?? true;
    fps = p.getBool('fps') ?? true;
    lowGraphics = p.getBool('lowGraphics') ?? false;
    crosshair = p.getBool('crosshair') ?? true;
    keystrokes = p.getBool('keystrokes') ?? false;
    neon = p.getBool('neon') ?? true;
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('hud', hud);
    await p.setBool('pvp', pvp);
    await p.setBool('fps', fps);
    await p.setBool('lowGraphics', lowGraphics);
    await p.setBool('crosshair', crosshair);
    await p.setBool('keystrokes', keystrokes);
    await p.setBool('neon', neon);
  }

  Future<void> reset() async {
    final p = await SharedPreferences.getInstance();
    await p.clear();
    hud = true; pvp = true; fps = true; lowGraphics = false;
    crosshair = true; keystrokes = false; neon = true;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final settings = ClientSettings();
  bool ready = false;

  @override
  void initState() {
    super.initState();
    settings.load().then((_) => setState(() => ready = true));
  }

  void snack(String text) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );

  @override
  Widget build(BuildContext context) {
    if (!ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('A.Y LEGEND CLIENT',
            style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'A.Y Legend Client',
              applicationVersion: '1.0.0',
              applicationLegalese: 'A safe Minecraft Bedrock companion app.',
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _hero(),
          const SizedBox(height: 18),
          _button(
            icon: Icons.sports_esports,
            text: 'LAUNCH MINECRAFT',
            onTap: () => snack(
              'Minecraft launch requested. If Minecraft is installed, open it from your home screen.',
            ),
          ),
          const SizedBox(height: 12),
          _button(
            icon: Icons.tune,
            text: 'OPEN MOD MENU',
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ModMenu(settings: settings),
                ),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 20),
          _statusCard(),
          const SizedBox(height: 18),
          const Text('Safety',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'This app provides UI and performance preferences. It does not inject code into Minecraft, modify memory, bypass anti-cheat, or provide unfair cheats.',
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _hero() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: const LinearGradient(
        colors: [Color(0xFF151823), Color(0xFF090B12)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: const Color(0xFF267CFF), width: 1.2),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('A.Y', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900)),
        Text('LEGEND CLIENT',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                color: Color(0xFF2D8BFF))),
        SizedBox(height: 8),
        Text('Minecraft Bedrock companion • Android',
            style: TextStyle(color: Colors.white70)),
      ],
    ),
  );

  Widget _button({required IconData icon, required String text,
      required VoidCallback onTap}) => SizedBox(
    height: 58,
    child: FilledButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
    ),
  );

  Widget _statusCard() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _row('Custom HUD', settings.hud),
          _row('PvP UI', settings.pvp),
          _row('FPS Mode', settings.fps),
          _row('Crosshair', settings.crosshair),
          _row('A.Y Neon Theme', settings.neon),
        ],
      ),
    ),
  );

  Widget _row(String title, bool value) => ListTile(
    dense: true,
    contentPadding: EdgeInsets.zero,
    title: Text(title),
    trailing: Icon(value ? Icons.check_circle : Icons.cancel,
      color: value ? const Color(0xFF36D47A) : Colors.white38),
  );
}

class ModMenu extends StatefulWidget {
  final ClientSettings settings;
  const ModMenu({super.key, required this.settings});

  @override
  State<ModMenu> createState() => _ModMenuState();
}

class _ModMenuState extends State<ModMenu> {
  void toggle(String key, bool value) {
    switch (key) {
      case 'hud': widget.settings.hud = value; break;
      case 'pvp': widget.settings.pvp = value; break;
      case 'fps': widget.settings.fps = value; break;
      case 'lowGraphics': widget.settings.lowGraphics = value; break;
      case 'crosshair': widget.settings.crosshair = value; break;
      case 'keystrokes': widget.settings.keystrokes = value; break;
      case 'neon': widget.settings.neon = value; break;
    }
    widget.settings.save();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.settings;
    return Scaffold(
      appBar: AppBar(title: const Text('MOD MENU')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _switch('Custom HUD', s.hud, 'hud'),
          _switch('PvP UI', s.pvp, 'pvp'),
          _switch('FPS Mode', s.fps, 'fps'),
          _switch('Low Graphics Mode', s.lowGraphics, 'lowGraphics'),
          _switch('Custom Crosshair', s.crosshair, 'crosshair'),
          _switch('Keystrokes HUD', s.keystrokes, 'keystrokes'),
          _switch('A.Y Neon Theme', s.neon, 'neon'),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () async {
              await s.reset();
              setState(() {});
            },
            icon: const Icon(Icons.restart_alt),
            label: const Text('RESET SETTINGS'),
          ),
        ],
      ),
    );
  }

  Widget _switch(String title, bool value, String key) => Card(
    child: SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (v) => toggle(key, v),
    ),
  );
}
