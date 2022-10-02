import 'package:dzwei_keeper/services/menu/main_menu_service.dart';
import 'package:dzwei_keeper/ui/theme/color_schemes.dart';
import 'package:dzwei_keeper/views/misc/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          child,
          maxWidth: 5000,
          minWidth: 480,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(
            color: const Color(0xFFF5F5F5),
          ),
        );
      },
      home: const AppPage(),
    );
  }
}

class AppPage extends HookConsumerWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationExpanded = ref.watch(menuExpansionProvider);
    final responsiveWrapper = ResponsiveWrapper.of(context);
    return Scaffold(
      body: Row(
        children: [
          if (responsiveWrapper.isLargerThan(MOBILE)) ...[
            NavigationRail(
              extended: responsiveWrapper.isDesktop ? true : navigationExpanded,
              onDestinationSelected: (index) {
                if (index == 0) {
                  ref.read(menuExpansionProvider.notifier).state = !navigationExpanded;
                }
              },
              destinations: [
                if (!responsiveWrapper.isDesktop) ...[
                  const NavigationRailDestination(
                    icon: Icon(Icons.menu),
                    label: Text(
                      'DZWEI KEEPER',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                const NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Übersicht'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.storage),
                  label: Text('Storage'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Profil'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Einstellungen'),
                ),
              ],
              selectedIndex: 0,
            ),
          ],
          CustomPaint(
            size: const Size(1, double.infinity),
            painter: DashedLineVerticalPainter(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ResponsiveRowColumn(
                rowMainAxisAlignment: MainAxisAlignment.start,
                rowPadding: const EdgeInsets.all(30),
                columnPadding: const EdgeInsets.all(30),
                layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: const [
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: ResponsiveVisibility(
                      hiddenWhen: [
                        Condition.equals(name: TABLET),
                      ],
                      child: Text('Fap'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CourseTile extends HookConsumerWidget {
  const CourseTile({super.key, required this.course});

  final String course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text('Kurs $course'),
    );
  }
}

class MenuTextButton extends HookConsumerWidget {
  const MenuTextButton({super.key, this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {},
      child: Text(text),
    );
  }
}
