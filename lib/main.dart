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
  String selectedGender = 'male';

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: () {
                final currentLocale = context.locale.languageCode;

                context.setLocale(
                  currentLocale == 'en'
                      ? const Locale('bn')
                      : const Locale('en'),
                );
              },
              child: Text(
                context.locale.languageCode == 'en' ? 'বাংলা' : 'English',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
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

              // Male / Female selection
              Text(
                'selectGender'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              DropdownButton<String>(
                value: selectedGender,
                items: [
                  DropdownMenuItem(value: 'male', child: Text('male'.tr())),
                  DropdownMenuItem(value: 'female', child: Text('female'.tr())),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedGender = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 12),

              Text(
                selectedGender == 'male'
                    ? 'welcomeMale'.tr()
                    : 'welcomeFemale'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Pluralization practice
              Text('taskCount'.plural(0), style: const TextStyle(fontSize: 18)),
              Text('taskCount'.plural(1), style: const TextStyle(fontSize: 18)),
              Text('taskCount'.plural(5), style: const TextStyle(fontSize: 18)),

              const SizedBox(height: 20),

              // Language selection
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

              const SizedBox(height: 12),

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
