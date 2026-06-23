
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/story_model.dart';
import '../provider/audio_provider.dart';
import '../provider/quiz_provider.dart';
import '../services/json_service.dart';
import '../widgets/answer_card.dart';

class StoryScreen extends ConsumerStatefulWidget {
  const StoryScreen({super.key});

  @override
  ConsumerState<StoryScreen> createState() =>
      _StoryScreenState();
}

class _StoryScreenState
    extends ConsumerState<StoryScreen> {
  final JsonService service = JsonService();

  late ConfettiController confettiController;

  int currentStoryIndex = 0;
  List<StoryModel> stories = [];

  @override
  void initState() {
    super.initState();

    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  void nextStory() {
    if (currentStoryIndex <
        stories.length - 1) {
      setState(() {
        currentStoryIndex++;
      });

      ref
          .read(quizProvider.notifier)
          .reset();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "No more stories available",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(
      quizProvider,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6D28D9),
              Color(0xffEC4899),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<
              List<StoryModel>>(
            future:
                service.loadStories(),
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child:
                      CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error
                        .toString(),
                  ),
                );
              }

              if (!snapshot.hasData ||
                  snapshot
                      .data!.isEmpty) {
                return const Center(
                  child: Text(
                    "No Stories Found",
                  ),
                );
              }

              stories = snapshot.data!;

              final story =
                  stories[
                      currentStoryIndex];

              return Stack(
                children: [
                  Align(
                    alignment:
                        Alignment.topCenter,
                    child:
                        ConfettiWidget(
                      confettiController:
                          confettiController,
                      blastDirectionality:
                          BlastDirectionality
                              .explosive,
                    ),
                  ),
                  SingleChildScrollView(
                    padding:
                        const EdgeInsets
                            .all(5),
                    child: Column(
                      children: [
                        const SizedBox(
                            height: 10),

                        Container(
                          height: 45,
                          padding:
                              const EdgeInsets
                                  .all(5),
                          decoration:
                              BoxDecoration(
                            color: Colors
                                .white,
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        20),
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                child: Icon(
                                  Icons
                                      .smart_toy,
                                  size: 35,
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      12),
                              const Expanded(
                                child: Text(
                                  "Hi there! I'm your AI Buddy. Let's read a story together.",
                                  style:
                                      TextStyle(
                                    fontSize:
                                        15,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                            height: 10),

                        Container(
                          height: 170,
                          padding:const EdgeInsets.all(10),
                          decoration:BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.circular(25),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                story.title,
                                style:const TextStyle(
                                  fontSize:20,
                                  fontWeight:FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                  height: 15),
                              Text(
                                story.story,
                                style:const TextStyle(
                                  fontSize:15,
                                  height:1.5,
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      15),
                              SizedBox(
                                width: double
                                    .infinity,
                                child:
                                    ElevatedButton
                                        .icon(
                                  onPressed:
                                      () {
                                    ref
                                        .read(
                                            audioProvider)
                                        .speak(
                                            story.story);
                                  },
                                  icon:
                                      const Icon(
                                    Icons
                                        .volume_up,
                                  ),
                                  label:
                                      const Text(
                                    "Read Me A Story",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                            height: 10),

                        Container(
                          padding:const EdgeInsets.all(10),
                          decoration:BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Text(
                                story.question,
                                textAlign:TextAlign.center,
                                style:const TextStyle(
                                  fontSize:20,
                                  fontWeight:FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                  height:15),
                              GridView
                                  .builder(
                                shrinkWrap:true,
                                physics:const NeverScrollableScrollPhysics(),
                                itemCount:story.options.length,
                                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 2,
                                 crossAxisSpacing: 12,
                                 mainAxisSpacing: 12,
                                 childAspectRatio: 2.5,
                                      
                                ),
                                itemBuilder:
                                    (
                                  context,
                                  index,
                                ) {
                                  return AnswerCard(
                                    text: story.options[index],
                                    onTap:() {
                                      ref
                                          .read(quizProvider.notifier)
                                              
                                          .selectAnswer(
                                            story.options[index],
                                            story.correctAnswer,
                                          );

                                      if (story.options[index] ==
                                          story.correctAnswer) {
                                        confettiController
                                            .play();
                                      }
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                  height:
                                      20),
                              if (quiz
                                  .answered)
                                Column(
                                  children: [
                                    Text(
                                      quiz.isCorrect
                                          ? "🎉 Correct!"
                                          : "❌ Wrong Answer",
                                      style:
                                          TextStyle(
                                        fontSize:
                                            24,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: quiz.isCorrect
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            10),
                                    if (quiz
                                        .isCorrect)
                                      const Text(
                                        "Great Job!",
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(
                            height: 20),

                        SizedBox(
                          width: double
                              .infinity,
                          height: 55,
                          child:
                              ElevatedButton(
                            onPressed:
                                nextStory,
                            child:
                                const Text(
                              "Try Another Story",
                              style:
                                  TextStyle(
                                fontSize:
                                    18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 20),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
