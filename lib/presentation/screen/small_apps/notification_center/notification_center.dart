import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_note/exports.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _backgroundContainer(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Thursday, September 30',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  '8:23',
                  style: TextStyle(
                      fontSize: 100,
                      height: 1.1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                _notifications()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _backgroundContainer({required Widget child}) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.red,
                Colors.yellow,
                Colors.white,
              ],
            ),
          ),
        ),
        child
      ],
    );
  }

  Widget _notifications() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notification Center',
                style: TextStyle(fontSize: 26, color: Colors.white),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        // ListView.builder(
        //   physics: const ClampingScrollPhysics(),
        //   itemCount: _notificationContents.length,
        //   itemBuilder: (_, index) {
        //     return _notificationContents[index];
        //   },
        // ),
        NotificationCard(
          title: '리디',
          subTitle: '<세이노의 가르침> 다운로드 성공',
          time: 'now',
          iconRes: IconRes(
            iconData: Icons.menu_book_rounded,
            color: Palette.paletteBlue100,
          ),
        ),
        NotificationCard(
          title: '긴급재난문자',
          subTitle:
          '[기상청] 11월30일04:55 경북 경주시 동남동쪽 19km 지역 규모4.3 지진발생/낙하물 주의, 국민재난안전포털 행동ㅇ요령에 따라 대응, 여진주의',
          time: '3h ago',
          iconRes: IconRes(
            iconData: Icons.warning,
            color: Palette.paletteYellow100,
          ),
        ),
        NotificationCard(
          title: '책한민국',
          subTitle: '애프터 라이프(1부) /브루스 그레이슨 / 현대지성',
          time: '12:35 AM',
          iconRes: IconRes(
            iconData: Icons.play_circle_filled,
            color: Palette.red03Basic,
          ),
        ),
        NotificationCard(
          title: '리디',
          subTitle: '<세이노의 가르침> 다운로드 성공',
          time: 'now',
          iconRes: IconRes(
            iconData: Icons.menu_book_rounded,
            color: Palette.paletteBlue100,
          ),
        ),
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;
  final IconRes iconRes;

  const NotificationCard({
    required this.title,
    required this.subTitle,
    required this.time,
    required this.iconRes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        color: Palette.white.withAlpha(90),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconRes.color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(iconRes.iconData),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Palette.paletteGray10050p,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    subTitle,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

final List<Widget> _notificationContents = [
  NotificationCard(
    title: '리디',
    subTitle: '<세이노의 가르침> 다운로드 성공',
    time: 'now',
    iconRes: IconRes(
      iconData: Icons.menu_book_rounded,
      color: Palette.paletteBlue100,
    ),
  ),
  NotificationCard(
    title: '긴급재난문자',
    subTitle:
    '[기상청] 11월30일04:55 경북 경주시 동남동쪽 19km 지역 규모4.3 지진발생/낙하물 주의, 국민재난안전포털 행동ㅇ요령에 따라 대응, 여진주의',
    time: '3h ago',
    iconRes: IconRes(
      iconData: Icons.warning,
      color: Palette.paletteYellow100,
    ),
  ),
  NotificationCard(
    title: '책한민국',
    subTitle: '애프터 라이프(1부) /브루스 그레이슨 / 현대지성',
    time: '12:35 AM',
    iconRes: IconRes(
      iconData: Icons.play_circle_filled,
      color: Palette.red03Basic,
    ),
  ),
  NotificationCard(
    title: '리디',
    subTitle: '<세이노의 가르침> 다운로드 성공',
    time: 'now',
    iconRes: IconRes(
      iconData: Icons.menu_book_rounded,
      color: Palette.paletteBlue100,
    ),
  ),
];

class IconRes {
  final IconData iconData;
  final Color color;

  IconRes({
    required this.iconData,
    required this.color,
  });
}