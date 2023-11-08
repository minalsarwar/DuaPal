import 'package:flutter/material.dart';
import 'package:flutter_application_1/networking/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // TRY THIS: Try running your application with "flutter run". You'll see
      //   // the application has a blue toolbar. Then, without quitting the app,
      //   // try changing the seedColor in the colorScheme below to Colors.green
      //   // and then invoke "hot reload" (save your changes or press the "hot
      //   // reload" button in a Flutter-supported IDE, or press "r" if you used
      //   // the command line to start the app).
      //   //
      //   // Notice that the counter didn't reset back to zero; the application
      //   // state is not lost during the reload. To reset the state, use hot
      //   // restart instead.
      //   //
      //   // This works for code too, not just values: Most code changes can be
      //   // tested with just a hot reload.
      //   colorScheme:
      //       ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 226, 182, 220)),
      //   useMaterial3: true,
      // ),
      theme: ThemeData(
        primarySwatch: Colors.blue, // Light theme
      ),
      //Adding dark theme
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Color.fromARGB(255, 90, 85, 85),
      ),

      //System's theme setting or use the light/dark theme explicitly.
      themeMode: ThemeMode.system, // Or use ThemeMode.light or ThemeMode.dark
      // home: const MyHomePage(title: 'Flutter Demo Home Page: Minal'),
      home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        // actions: [Icon(Icons.notifications_active_rounded)],
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active_rounded),
            onPressed: () {
              // Show a SnackBar when the notification icon is pressed.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have subscribed'),
                ),
              );
            },
          ),
        ],
      ),
      // body: Container(
      //   decoration: BoxDecoration(color: Color.fromARGB(255, 242, 255, 64)),
      //   // color: Colors.lightBlueAccent,
      //   // width: 100,
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     //
      //     // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
      //     // action in the IDE, or press "p" in the console), to see the
      //     // wireframe for each widget.
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     // crossAxisAlignment: CrossAxisAlignment.end,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //     ],
      //   ),
      // ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 207, 252, 248)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const CustomButton(),
                    // const Image(
                    //   image: NetworkImage(
                    //       'https://images.unsplash.com/photo-1444080748397-f442aa95c3e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80'),
                    // ),
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                  ],
                )),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Badge(
            backgroundColor: Colors.lightGreen,
            label: const Icon(Icons.emoji_emotions_rounded),
            largeSize: 24,
            child: FloatingActionButton(
              backgroundColor: Colors.yellow,
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              // child: const Icon(Icons.sentiment_satisfied_alt_rounded),
              child: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(width: 50), // Add some spacing between the buttons
          Badge(
            backgroundColor: Colors.lightGreen,
            label: const Icon(Icons.emoji_emotions_rounded),
            largeSize: 24,
            child: FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ],
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
