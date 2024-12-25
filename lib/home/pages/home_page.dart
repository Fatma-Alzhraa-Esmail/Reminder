import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quickcue/utils/app_text_style.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Reminders",
                      style: AppTextStyle.w700.copyWith(fontSize: 28),
                    ),
                  ),
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Pinned",
                          style: AppTextStyle.w500
                              .copyWith(color: Colors.grey.shade700),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 2 / 1,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 14,
                          ),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 12,
                                  children: [
                                    Text(
                                      "Coffee",
                                      style: AppTextStyle.w800,
                                    ),
                                    Text(
                                      "Prepare hot coffie for friends. Prepare hot coffie for friends",
                                      maxLines: 2,
                                      style: AppTextStyle.w500
                                          .copyWith(fontSize: 17),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: Text(
                                          "Todat, 4:30",
                                          style: AppTextStyle.w500
                                              .copyWith(fontSize: 17),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Upcoming",
                          style: AppTextStyle.w500
                              .copyWith(color: Colors.grey.shade700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 12,
                                  children: [
                                    Text(
                                      "Coffee",
                                      style: AppTextStyle.w800,
                                    ),
                                    Text(
                                      "Prepare hot coffie for friends. Prepare hot coffie for friends",
                                      maxLines: 2,
                                      style: AppTextStyle.w500
                                          .copyWith(fontSize: 17),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: Text(
                                          "Todat, 4:30",
                                          style: AppTextStyle.w500
                                              .copyWith(fontSize: 17),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 12,
                                  children: [
                                    Text(
                                      "Coffee",
                                      style: AppTextStyle.w800,
                                    ),
                                    // Text(
                                    //   "Prepare hot coffie for friends. Prepare hot coffie for friends",
                                    //   maxLines: 2,
                                    //   style: AppTextStyle.w500.copyWith(fontSize: 17),
                                    // ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: Text(
                                          "Todat, 4:30",
                                          style: AppTextStyle.w500
                                              .copyWith(fontSize: 17),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 12,
                                  children: [
                                    Text(
                                      "Coffee is ldmfskfjdskl ldf;vmgdsfgklsfd",
                                      style: AppTextStyle.w800,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "Prepare hot coffie for friends. Prepare hot coffie for friends",
                                      maxLines: 2,
                                      style: AppTextStyle.w500
                                          .copyWith(fontSize: 17),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: Text(
                                          "Todat, 4:30",
                                          style: AppTextStyle.w500
                                              .copyWith(fontSize: 17),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 12,
                                  children: [
                                    Text(
                                      "Coffee is ldmfskfjdskl ldf;vmgdsfgklsfd",
                                      style: AppTextStyle.w800,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "Prepare hot coffie for friends. Prepare hot coffie for friends",
                                      maxLines: 2,
                                      style: AppTextStyle.w500
                                          .copyWith(fontSize: 17),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: Text(
                                          "Todat, 4:30",
                                          style: AppTextStyle.w500
                                              .copyWith(fontSize: 17),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
