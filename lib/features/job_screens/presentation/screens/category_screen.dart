import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/theme/app_theme.dart';
import 'package:quick_hire/core/utils/constants.dart';
import 'package:quick_hire/features/job_screens/presentation/widgets/job_offer_card.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: SvgPicture.asset('assets/images/quickhire logo.svg'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.categoryName, style: Theme.of(context).textTheme.displayMedium),
              SizedBox(height: 20),
              Text(
                'Available jobs:',
                style: TextStyle(
                  color: AppColors.typographyColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 600, // Set a fixed height for the ListView
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    JobOfferCard(jobTitle: 'Logo Designer', jobDescription: 'Looking for a logo designer for my company', budgetMax: '500', budgetMin: '100'),
                    JobOfferCard(jobTitle: 'Logo Designer', jobDescription: 'Looking for a logo designer for my company', budgetMax: '500', budgetMin: '100'),
                    JobOfferCard(jobTitle: 'Logo Designer', jobDescription: 'Looking for a logo designer for my company', budgetMax: '500', budgetMin: '100'),
                    JobOfferCard(jobTitle: 'Logo Designer', jobDescription: 'Looking for a logo designer for my company', budgetMax: '500', budgetMin: '100'),
                    JobOfferCard(jobTitle: 'Logo Designer', jobDescription: 'Looking for a logo designer for my company', budgetMax: '500', budgetMin: '100'),
                    JobOfferCard(jobTitle: 'Logo Designer', jobDescription: 'Looking for a logo designer for my company', budgetMax: '500', budgetMin: '100'),
                    JobOfferCard(jobTitle: 'Logo Designer', jobDescription: 'Looking for a logo designer for my company', budgetMax: '500', budgetMin: '100'),
                    JobOfferCard(jobTitle: 'Logo Designer', jobDescription: 'Looking for a logo designer for my company', budgetMax: '500', budgetMin: '100'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}