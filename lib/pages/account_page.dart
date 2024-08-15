import 'package:flutter/material.dart';
import 'package:supabase_login_flutter/components/avatar.dart';
import 'package:supabase_login_flutter/main.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _getInitialProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  Future<void> _getInitialProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final data =
        await supabase.from('profiles').select().eq('id', userId).single();
    setState(() {
      _usernameController.text = data['username'];
      _websiteController.text = data['website'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Avatar(
              imageUrl: _imageUrl,
              onUpload: (imageUrl) {
                setState(() {
                  _imageUrl = imageUrl;
                });
              }),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              label: Text('Username'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _websiteController,
            decoration: InputDecoration(
              label: Text('Website'),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              final username = _usernameController.text.trim();
              final website = _websiteController.text.trim();
              final userId = supabase.auth.currentUser!.id;
              await supabase.from('profiles').update({
                'username': username,
                'website': website,
              }).eq('id', userId);

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Your data has been saved')));
              }
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}
