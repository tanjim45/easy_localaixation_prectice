import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('bn')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();

  String userName = 'Tanjim';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appName'.tr()),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.translate, size: 65, color: Colors.blue),
              const SizedBox(height: 20),

              Text(
                'welcome'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              Text('message'.tr(), textAlign: TextAlign.center),
              const SizedBox(height: 25),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'enterName'.tr(),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {
                  final enteredName = nameController.text.trim();

                  if (enteredName.isNotEmpty) {
                    setState(() {
                      userName = enteredName;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('nameRequired'.tr())),
                    );
                  }
                },
                child: Text('showGreeting'.tr()),
              ),
              const SizedBox(height: 20),

              Text(
                'greeting'.tr(args: [userName]),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text('taskCount'.plural(0), style: const TextStyle(fontSize: 18)),
              Text('taskCount'.plural(1), style: const TextStyle(fontSize: 18)),
              Text('taskCount'.plural(5), style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 20),

              DropdownButton<Locale>(
                value: context.locale,
                items: const [
                  DropdownMenuItem(value: Locale('en'), child: Text('English')),
                  DropdownMenuItem(value: Locale('bn'), child: Text('বাংলা')),
                ],
                onChanged: (locale) {
                  if (locale != null) {
                    context.setLocale(locale);
                  }
                },
              ),

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('login'.tr())));
                },
                child: Text('login'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
