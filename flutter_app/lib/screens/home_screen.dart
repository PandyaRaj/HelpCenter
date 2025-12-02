import 'package:flutter/material.dart';
import 'messages_screen.dart';
import 'dashboard_screen.dart';
import '../services/message_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final MessageService _messageService = MessageService();

  final List<Widget> _screens = [
    const MessagesScreen(),
    const DashboardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: Badge(
              label: StreamBuilder<int>(
                stream: Stream.periodic(const Duration(seconds: 1), (_) {
                  return _messageService.getUnreadCount();
                }),
                builder: (context, snapshot) {
                  final count = snapshot.data ?? 0;
                  return count > 0 ? Text('$count') : const SizedBox.shrink();
                },
              ),
              isLabelVisible: _messageService.getUnreadCount() > 0,
              child: const Icon(Icons.message_outlined),
            ),
            selectedIcon: const Badge(
              child: Icon(Icons.message),
            ),
            label: 'Messages',
          ),
          const NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
