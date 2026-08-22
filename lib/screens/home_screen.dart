import 'package:flutter/material.dart';
import 'products_screen.dart';
import 'profile_screen.dart';
import '../theme/app_colors.dart';

/// Home screen — now a container that hosts three tabs via a working
/// BottomNavigationBar: Home, Products (GridView), Profile.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const List<String> _titles = ['Home', 'Products', 'Profile'];

  static const List<Widget> _tabs = [
    _HomeTab(),
    ProductsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGrey,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

/// The original dashboard content — kept as the "Home" tab, now using
/// a ListView so recent activity can scroll independently of the page.
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Welcome banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back 👋',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: AppColors.primary, size: 28),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: const [
            _QuickAction(icon: Icons.add_circle_outline, label: 'Add'),
            _QuickAction(icon: Icons.receipt_long_outlined, label: 'History'),
            _QuickAction(icon: Icons.pie_chart_outline, label: 'Reports'),
            _QuickAction(icon: Icons.settings_outlined, label: 'Settings'),
          ],
        ),
        const SizedBox(height: 28),

        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 12),

        const _ActivityTile(
          icon: Icons.shopping_bag_outlined,
          title: 'Groceries',
          subtitle: 'Today, 10:24 AM',
          trailing: '- \$42.00',
        ),
        const _ActivityTile(
          icon: Icons.bolt_outlined,
          title: 'Electricity Bill',
          subtitle: 'Yesterday, 6:10 PM',
          trailing: '- \$18.50',
        ),
        const _ActivityTile(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Salary',
          subtitle: 'Mon, 9:00 AM',
          trailing: '+ \$1,200.00',
          positive: true,
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.tint,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String trailing;
  final bool positive;

  const _ActivityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.positive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.tintBorder),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.tint,
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
              ],
            ),
          ),
          Text(
            trailing,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: positive ? AppColors.success : AppColors.danger,
            ),
          ),
        ],
      ),
    );
  }
}