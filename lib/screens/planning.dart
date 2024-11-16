import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_plan/components/arrow_back.dart';
import 'package:travel_plan/models/plan.dart';
import 'package:travel_plan/models/planning.dart';
import 'package:travel_plan/services/plan_service.dart';
import 'package:travel_plan/widgets/field_input_message.dart';
import 'package:travel_plan/widgets/filter.dart';
import 'package:travel_plan/widgets/plan_response.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  final List<Planning> messages = [];
  final List<String> destinations = [
    'Vũng Tàu',
  ];
  final TextEditingController userInput = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late String destination;
  @override
  void initState() {
    super.initState();
    destination = destinations[0];
  }

  Future<void> sendMessage() async {
    String messageText = userInput.text;

    if (messageText.isEmpty) {
      return;
    }

    // Add user message to the list
    setState(() {
      messages.add(Planning(
        isUser: true,
        plan: Plan(
          textUserInput: messageText,
          destination: destination,
        ),
      ));
    });

    // Clear the input field
    userInput.clear();

    // Generate a plan
    final generatedPlan =
        await PlanService().generatePlan(destination, messageText);

    // Add the generated plan to the list
    setState(() {
      messages.add(Planning(
        isUser: false,
        plan: generatedPlan,
      ));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leadingWidth: 64,
        leading: const ArrowBack(),
        title: FilterButton(
          items: destinations,
          onSelected: (selectDestination) {
            setState(() {
              destination = selectDestination;
            });
            print('Destination: $destination');
          },
        ),
        actions: [
          Builder(
            builder: (context) => Container(
              margin: EdgeInsets.only(right: 20),
              height: 43,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/history.svg',
                  width: 24,
                  height: 24,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          )
        ],
      ),
      endDrawer: HistoryDrawer(), // Add the drawer here
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(bottom: 76),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return PlanResponse(plan: messages[index]);
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: FieldInputMessage(
                    sendMessage: sendMessage,
                    userInput: userInput,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryDrawer extends StatefulWidget {
  const HistoryDrawer({super.key});

  @override
  State<HistoryDrawer> createState() => _HistoryDrawerState();
}

class _HistoryDrawerState extends State<HistoryDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('History'),
          ),
        ],
      ),
    );
  }
}
