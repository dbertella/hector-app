import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyPageView());

List<List<String>> pages = [
  ['assets/images/Cover.png'],
  [
    'assets/images/page1.png',
    'Hector is a little dinosaur\nwho lives in the forest.\nHe spends all his days eating flowers\nand having a rest.',
    'assets/audios/page1.mp3',
  ],
  [
    'assets/images/page2.png',
    'But you see, poor Hector\nis very, very slow.\nFlowers are not so tasty,\nbut what else could he eat?',
    'assets/audios/page2.mp3',
  ],
  [
    'assets/images/page3.png',
    'One day, he finds a carrot.\nLooking around him he wonders:\n“Is there anyone who might steal my food?”\nHopefully no one.',
  ],
  [
    'assets/images/page4.png',
    '“Hi Bunny. How are you?”\n“Hi Hector, not eating flowers today?”\n“I was just about to try this carrot”, replies Hector.\n“Interesting”, the bunny says, thinking for a minute...',
  ],
  [
    'assets/images/page5.png',
    '“Hey! You’re eating my carrot!” cries Hector.\n“Sorry, you’re too slow.\nDidn\'t you know?\nCarrots are my favourite food.”',
  ],
  [
    'assets/images/page6.png',
    'Later, on top of a rock, he’s searching:\n“What else could I eat?”\nSomething sweet and juicy, he’s thinking.\nBut can you see it?',
  ],
  [
    'assets/images/page7.png',
    'Oh look, an apple!\nThat must be good.\nCan you see anyone\nwho might steal his food?',
  ],
  [
    'assets/images/page8.png',
    '“Hi Bear. How are you?” asks Hector.\n“I’m hungry”, says Bear.\n“Me too!” replies Hector.\n“Let’s see who can get this apple first then”, says Bear.',
  ],
  [
    'assets/images/page9.png',
    '“I thought a bear’s favourite food was honey?…”\nBut Bear is already eating the apple.\nHector has been too slow again.',
  ],
  [
    'assets/images/page10.png',
    'He walks some more and... oh look, a salad!\nThat must be good.\nHopefully no one will steal his food.\nWho else might want this salad?',
  ],
  [
    'assets/images/page11.png',
    '“Oh, hi Snail. How are you?”\n“I’m very hungry”, says Snail slowly.\n“I see”, replies Hector, “shall we share then?”\n“Sure, but you better hurry!”',
  ],
  [
    'assets/images/page12.png',
    'Hector wants to run.\nBut he’s very, very slow.\nJust a few more steps.\nBut the snail is getting closer.',
  ],
  [
    'assets/images/page13.png',
    'Hector moves another foot.\nBut the snail is much faster.',
  ],
  [
    'assets/images/page14.png',
    '“Don’t finish it: we can still be friends!”\ntries Hector one more time,\ndesperately...',
  ],
  [
    'assets/images/page15.png',
    'Once again, Hector was too slow.\nThere’s nothing left,\nthe salad is gone,\nand there’s no more food around.',
  ],
  [
    'assets/images/page16.png',
    'When a little mouse\ncomes to offer him a nut.\n“I’m small and fast, I can give you this and more.\nYou’re big and strong, you can be my protector.”',
  ],
  [
    'assets/images/page17.png',
    'Hector is not alone anymore,\nhe is so happy!\nHopefully no one will steal his new friend.\nCan you see anybody?',
  ],
  [
    'assets/images/page18.png',
    'Oh no, a fox! “This mouse looks yummy.\nDo you mind if we share it?” asks Fox.\n“Well”, answers Hector, “if you want it\nYou’ll have to do something for me.',
  ],
  [
    'assets/images/page19.png',
    'Mice are my favourite food,\nbut I think those nuts taste much better.\nGo! I hold the mouse, you try the nut.\nRight behind you, tell me, is it tasty?”',
  ],
  [
    'assets/images/page20.png',
    '“Did you just play a trick on me?” grumbles Fox.\n“Where is the mouse, I want to know!”\n“I’m sorry”, Hector answers the Fox,\n“I ate it all, you’re far too slow!”',
  ],
  [
    'assets/images/End.png',
    'That was the beginning of a beautiful friendship.',
  ],
];

class MyPageView extends StatefulWidget {
  MyPageView({Key key}) : super(key: key);

  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final assetsAudioPlayer = AssetsAudioPlayer();

  List<Widget> pageSlides() {
    var list = pages.map(
      (content) {
        String path = content[0];
        String text = content.length >= 2 ? content[1] : '';
        return Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(path),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            text.isEmpty
                ? SizedBox.shrink()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.9),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.walterTurncoat(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey, // Color(0xff185122),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    ).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.green,
          backgroundColor: Colors.white),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                String audioPath = pages[page][2];
                if (audioPath.isNotEmpty) {
                  assetsAudioPlayer.open(
                    Audio(audioPath),
                    respectSilentMode: true,
                  );
                  assetsAudioPlayer.play();
                }
              },
              children: pageSlides(),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Row(
            //     children: <Widget>[
            //       FlatButton(
            //         onPressed: () {
            //           if (_pageController.hasClients) {
            //             _pageController.animateToPage(
            //               0,
            //               duration: const Duration(milliseconds: 400),
            //               curve: Curves.easeInOut,
            //             );
            //           }
            //         },
            //         child: Text(
            //           "First",
            //         ),
            //       ),
            //       Text(_pageController.page.round().toString() +
            //           '/' +
            //           pages.length.toString()),
            //       FlatButton(
            //         onPressed: () {
            //           if (_pageController.hasClients) {
            //             _pageController.animateToPage(
            //               // _pageController.page.round() + 1,
            //               pages.length,
            //               duration: const Duration(milliseconds: 400),
            //               curve: Curves.easeInOut,
            //             );
            //           }
            //         },
            //         child: Text(
            //           "Last",
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
