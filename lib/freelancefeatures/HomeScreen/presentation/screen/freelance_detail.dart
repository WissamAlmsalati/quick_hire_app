import 'package:flutter/material.dart';

class FreelancerDetailScreen extends StatelessWidget {
  final Map<String, dynamic> freelancer;

  const FreelancerDetailScreen({Key? key, required this.freelancer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Freelancer Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.network(
                freelancer['profilePicture'] ??
                    'https://via.placeholder.com/150',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            Text(
              '${freelancer['username']}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),
            Text(
              '${freelancer['bio']}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            Divider(),


            SizedBox(height: 16),
            Text(
              'Skills & Expertise',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),

            SizedBox(height: 8),

            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: (freelancer['skills'] as List<dynamic>)
                  .map((skill) => Chip(label: Text(skill.toString())))
                  .toList(),
            ),


            SizedBox(height: 16),
            Text(
              'rate: ${freelancer['rate']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),

            SizedBox(height: 8),
            Text(
              'Location: ${freelancer['location']}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'Email: ${freelancer['email']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
