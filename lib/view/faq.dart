import 'package:flutter/material.dart';
import 'package:nex2u/viewModel/contact_view_model.dart';
import 'package:provider/provider.dart';

import '../models/resources/faq_response.dart';
import '../page_routing/app_routes.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  FAQScreenState createState() => FAQScreenState();
}

class FAQScreenState extends State<FAQScreen> {
  List<Faqs> faqlist = []; // Move list inside the state
  String title = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ContactViewModel>(context, listen: false);
      await provider.getfaq(context);

      setState(() {
        faqlist = provider.faqresponse?.faqs ?? [];
        title = provider.faqresponse!.title!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hi Agent,\nHow can we help?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              // FAQ List
              FAQList(faqlist: faqlist),

              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Need to get in touch?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8280FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.contact);
                        },
                        child: const Text(
                          "Contact Us",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// FAQ List Widget (Now uses passed list instead of global variable)
class FAQList extends StatelessWidget {
  final List<Faqs> faqlist;

  const FAQList({super.key, required this.faqlist});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: faqlist.length,
      itemBuilder: (context, index) {
        return FAQItem(
          question: faqlist[index].question ?? "No Question",
          answer: faqlist[index].answer ?? "No Answer",
          isLastItem: index == faqlist.length - 1,
        );
      },
    );
  }
}

// Expandable FAQ Item Widget
class FAQItem extends StatefulWidget {
  final String question;
  final String answer;
  final bool isLastItem;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
    required this.isLastItem,
  });

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Removes default divider
          ),
          child: ExpansionTile(
            title: Text(
              widget.question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            onExpansionChanged: (expanded) {
              setState(() {
                isExpanded = expanded;
              });
            },
            maintainState: true,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child:
                    Text(widget.answer, style: const TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
        if (!widget.isLastItem) const Divider(), // Custom divider between items
      ],
    );
  }
}
