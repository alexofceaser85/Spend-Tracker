import 'package:flutter/material.dart';
import 'package:spend_tracker/model/weather.dart';
import 'package:spend_tracker/service/api_services.dart';
import 'package:spend_tracker/view/components/buttons/add_spend_button.dart';
import 'package:spend_tracker/view/components/containers/animated_slide_out_container.dart';
import 'package:spend_tracker/view/components/forms/new_spend_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<Weather> weather = List.empty(growable: true);
  bool loading = false;
  bool addSpendFormVisible = false;
  String? error;

  late Animation<double> animation;
  late AnimationController animationController;

  Future<void> _getWeather() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final services = ApiServices();
      final receivedWeather = await services.getWeather(context);
      setState(() {
        weather = receivedWeather;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getWeather();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggleAddSpendForm() {
    setState(() {
      addSpendFormVisible = !addSpendFormVisible;
      if (addSpendFormVisible) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 131, 0),
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
           child: AddButton(onTap: () { toggleAddSpendForm(); })
          ),
          AnimatedSlideOutContainer(title: "Add Spending", isVisible: addSpendFormVisible, onExit: toggleAddSpendForm, animation: animation, content: const NewSpendForm())
        ]
      ),
    );
  }
}