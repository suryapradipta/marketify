import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketify/pages/chat/three_dots.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../base/custom_app_bar.dart';
import 'chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  OpenAI? chatGPT;

  StreamSubscription? _subscription;
  bool _isTyping = false;

  @override
  void initState() {
    chatGPT = OpenAI.instance;
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: 'user',
    );
    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    final request = CompleteText(
        prompt: message.text, model: kTranslateModelV3, maxTokens: 200);

    _subscription = chatGPT!
        .build(
            token: "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",
            baseOption: HttpSetup(receiveTimeout: 6000),
            isLogger: true)
        .onCompleteStream(request: request)
        .listen((response) {
      Vx.log(response!.choices[0].text);
      ChatMessage botMessage =
          ChatMessage(text: response.choices[0].text, sender: "bot");
      setState(() {
        _isTyping = false;
        _messages.insert(0, botMessage);
      });
    })..onError((err) {
      print("$err");
    });
  }


  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: InputDecoration.collapsed(hintText: "Send a message"),
          ),
        ),
        IconButton(onPressed: () => _sendMessage(), icon: Icon(Icons.send))
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "AI | Chat Bot"),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    reverse: true,
                    padding: Vx.m8,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    }),
              ),
              if(_isTyping) ThreeDots(),
               Divider(height: 1.0,),

              Container(
                decoration: BoxDecoration(color: context.cardColor),
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }
}
