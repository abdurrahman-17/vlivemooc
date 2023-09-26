import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/components/category/categories.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';

import '../../../core/helpers/app_screen_dimen.dart';
import '../../constants/colors.dart';
import '../appbar/top_bar.dart';

class AboutUs extends StatefulWidget {
  final bool renderNavs;
  const AboutUs({Key? key, this.renderNavs = true}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Map dummyData = {
    "section2": {
      "title": "Core Team:",
      "data": [
        {
          "image": "assets/images/KiritMehta.png",
          "title": "Kirit C. Mehta",
          "subTitle": "Founder and Managing Director",
          "description":
              "An expert with decades of experience in broadcast television, media production, distribution, streaming media, business development, and strategic planning, Kirit C. Mehta is the man behind Aastha TV Channel, the world’s first TV channel showcasing India’s rich cultural, spiritual, and mythological heritage.\n\nA Customs House Agent turned international trader, Kirit C. Mehta began his journey in media production 25 years ago with iconic TV productions for ZEE TV and Doordarshan under his first media start-up, CMM Studios, a 17,000-square-feet state-of-the-art video and audio production and post-production facility in Mumbai, India, that executed visual effects for over 250 Bollywood films. CMM Studios became Southeast Asia's most modern post-production studio.\n\nMoving forward, Kirit C. Mehta established Aastha Broadcasting Network Ltd. and as the Founder and Managing Director, his vision and entrepreneurial spirit ensured the channel’s strong and widespread follower base spanning over 160 countries. He launched the International Beam in the US, UK, and Canada in 2004/5. Now, as the Founder and Managing Director of EnrichTV, he intends to enrich one billion lives by helping individuals tap into expert knowledge through this new TV channel and OTT platform."
        },
        {
          "image": "assets/images/Bhakti.png",
          "title": "Bhakti K. Mehta",
          "subTitle": "Founder and Chief Executive Officer",
          "description":
              "Bhakti Mehta embarked on her entrepreneurial journey in 2003 after graduating from the renowned New York Film Academy (NYFA). In 2005, she became Aastha TV's UK Chief Operating Officer, expanding its reach. After departing Aastha TV in 2011, Bhakti and her family faced numerous hardships. \n\nIn 2019, a pivotal moment changed Bhakti's perspective on life forever. It was during this time that she realized the immense value of mentorship, inspiring her to learn from esteemed global experts like Tony Robbins, Blair Singer, Robin Sharma, Mac Attram, Lisa Nichols, T. Harv Eker, Thaddeus Lawrence, Vishen Lakhiani, Mary Buffett, Ankur Warikoo, Rajiv Talreja, Ron Malhotra, Siddharth Rajsekar, Puja Puneet, and many others. Through their mentorship, she honed her skills in various domains, including business, sales, leadership, communication, marketing, and personal development. Blair Singer certified her as a trainer, solidifying her expertise in imparting knowledge and inspiring others. \n\nThis life-altering journey not only transformed Bhakti personally but also ignited a profound sense of purpose within her. Driven by her mission to inspire and empower others to dream, believe, and achieve, Bhakti co-founded EnrichTV with her father, Mr. Kirit Mehta. EnrichTV, the world's premier TV channel and digital platform for coaching, mentoring, and motivational content, aims to positively impact over a billion lives. Bhakti's own story serves as a testament to resilience, the power of mentorship, and unwavering self-belief."
        },
        {
          "image": "assets/images/Vaibhav.png",
          "title": "Vaibhav J. Parab",
          "subTitle": "Chief Technology Officer",
          "description":
              "With over two decades of experience in the media industry, Vaibhav brings a wealth of expertise in planning, budgeting, and implementing technology platforms. His extensive background includes working with national news channels, edit houses, OTT platforms, and digital product-based businesses. \n\nVaibhav has a deep technical understanding of media processing and hosting platforms, allowing them to lead product implementation and performance monitoring effectively. His ability to implement best practices for operations teams has consistently demonstrated his strong leadership skills. \n\nKeeping up with the latest trends and technologies in media standards, Vaibhav ensures that EnrichTV stays ahead of the curve. Additionally, his hands-on experience in the development of media processing products adds valuable insights to our team.\n\nWith his proven track record and industry knowledge, Vaibhav plays a vital role in shaping our company's success and driving innovation in the media industry."
        },
      ]
    },
    "section4": {
      "title":
          "EnrichTV's Revolutionary Platform \n6 Verticals for Tailored Content and Experiences",
      "data": [
        {
          "title": "24x7 Satellite TV Channel",
          "description":
              "We bring the world's most engaging and inspiring holistic transformational coaching, mentoring, and motivational content right to your living room.",
        },
        {
          "title": "On-Demand OTT Platform",
          "description":
              "Access an infinite library of videos and series by globally acclaimed coaches, trainers, experts, masters, mentors, healers, knowledge givers, and motivational speakers, whenever and wherever you want.",
        },
        {
          "title": "On-Demand Courses",
          "description":
              "Access an infinite library of videos and series by globally acclaimed coaches, trainers, experts, masters, mentors, healers, knowledge givers, and motivational speakers, whenever and wherever you want.",
        },
        {
          "title": "Live-Streamed Events and Workshops",
          "description":
              "Connect with fellow seekers and renowned experts through offline and virtual events and workshops for interactive learning experiences.",
        },
        {
          "title": "Personalized Coaching Sessions",
          "description":
              "Experience custom-tailored one-to-one or group sessions with top-notch coaches, trainers, mentors, and healers.",
        },
        {
          "title": " Comprehensive Mentorship Programs",
          "description":
              "Immerse yourself in a world of holistic transformation through a synergistic blend of courses, events, workshops, and coaching sessions.",
        },
      ]
    }
  };
  Map lifeCycleData = {
    "section1": {
      "title": "The Complete Life Cycle Of Learning And Transformation",
      "Desc":
          "At EnrichTV, we pride ourselves on offering a comprehensive and engaging learning experience that covers every stage of your personal and professional growth journey. Our platform is designed to provide the resources, support, and guidance you need to transform your life and unlock your limitless potential.",
      "data": [
        {
          "title": "Discover",
          "description":
              "Explore our vast library of content spanning ten life-changing categories, including Wealth, Business, Career, Health, Wellness, Spirituality, Personal Growth, Women Empowerment, Relationships, and Parenting. With resources that cater to various aspects of life, you're sure to find the perfect starting point for your transformative journey.",
        },
        {
          "title": "Learn",
          "description":
              "Access a treasure trove of on-demand, pre-recorded courses, enabling you to delve deeper into your chosen area of growth at your own pace. Our courses are created by globally acclaimed coaches, trainers, experts, masters, mentors, healers, knowledge givers, and motivational speakers, ensuring you receive world-class guidance and insights.",
        },
        {
          "title": "Engage",
          "description":
              "Attend live-streamed offline and virtual events and workshops that connect you with fellow seekers and renowned experts. These interactive learning experiences foster a vibrant community of growth and exploration, where you can exchange ideas, share your progress, and support one another.",
        },
        {
          "title": "Personalize",
          "description":
              "Book one-to-one and group coaching sessions with top-notch coaches, trainers,mentors, and healers, who provide customized and personalized, authentic, and credible advice tailored to your unique needs and goals. These personalized sessions help you overcome specific challenges and accelerate your growth journey.",
        },
        {
          "title": "Implement",
          "description":
              "Put your newfound knowledge and skills into practice, and start experiencing the transformative effects of your learning journey. As you apply what you've learned, you'll begin to see tangible improvements in your personal and professional life.",
        },
        {
          "title": "Reflect",
          "description":
              "Regularly assess your progress and adjust your learning path. Reflect on your achievements, identify areas for further growth, and continue to refine your approach to ensure you reach your full potential.",
        },
        {
          "title": "Evolve",
          "description":
              "Embrace the ongoing process of learning, growth, and transformation. As you continue to evolve, you'll unlock new levels of success and fulfilment, paving the way for a life of boundless achievement.",
        },
      ]
    }
  };
  var leftRightsize = 30.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.renderNavs
          ? TopBar(
              logoPath: "assets/images/logo_white.png",
              backgroundColor: AppColors.primaryColor,
              renderNav: true,
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            tryitWidget(),
            const SizedBox(height: 20),
            visionWidget(context),
            const SizedBox(height: 20),
            ourTeamWidget(context),
            const SizedBox(height: 20),
            languageWidget(context),
            const SizedBox(height: 20),
            categoryWidget(context),
            const SizedBox(height: 20),
            tailoredWidget(),
            const SizedBox(height: 20),
            lifeCycleWidget(),
            const SizedBox(height: 20),
            milstoneWidget(context),
            const SizedBox(height: 20),
            widget.renderNavs ? const WebFooter() : Container(),
          ],
        ),
      ),
    );
  }

  Widget tryitWidget() {
    return Container(
      decoration: const BoxDecoration(color: Color(0xffF8E892)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Your Ultimate gateway to ',
                        style: TextStyle(
                          color: Color(0xFF490A53),
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'personal ',
                        style: TextStyle(
                          color: Color(0xFF490A53),
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'and\n',
                        style: TextStyle(
                          color: Color(0xFF490A53),
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'professional mastery',
                        style: TextStyle(
                          color: Color(0xFF490A53),
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF3C023B)),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20)),
                  ),
                  child: const Text(
                    'Try it FREE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/aboutusMain.png', height: 500),
        ],
      ),
    );
  }

  Widget tailoredWidget() {
    return Padding(
      padding: EdgeInsets.only(left: leftRightsize, right: leftRightsize),
      child: Column(
        children: [
          Text(
            dummyData['section4']['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF322440),
              fontSize: 25,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 320,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemCount: dummyData['section4']['data'].length,
            itemBuilder: (context, index) {
              return Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFF490A53),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.8999999761581421),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 2.50, color: Color(0xFF490A53)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Image.asset(
                          'assets/images/aboutus${index + 1}.png',
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      child: Text(
                        dummyData['section4']['data'][index]['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFF1CE78),
                          fontSize: 18,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      child: Text(
                        dummyData['section4']['data'][index]['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8999999761581421),
                          fontSize: 15,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget lifeCycleWidget() {
    return Container(
      color: const Color(0xFF200424),
      child: Stack(
        children: [
          Positioned(
              bottom: 40,
              right: leftRightsize,
              child: Image.asset(
                'assets/images/aboutUsLifeCycleImg.png',
                height: 150,
                width: 600,
              )),
          Padding(
            padding: EdgeInsets.only(left: leftRightsize, right: leftRightsize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 60),
                  child: Text(
                    lifeCycleData['section1']['title'],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20, right: 60),
                  child: Text(
                    lifeCycleData['section1']['Desc'],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 180,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: lifeCycleData['section1']['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFF490A53),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(
                                lifeCycleData['section1']['data'][index]
                                    ['title'],
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Color(0xFFF1CE78),
                                  fontSize: 18,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              child: Text(
                                lifeCycleData['section1']['data'][index]
                                    ['description'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white
                                      .withOpacity(0.8999999761581421),
                                  fontSize: 15,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildTeam(image, name, subTitle, description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 300, child: Image.asset(image)),
        Text(name,
            style: const TextStyle(
                fontSize: 22,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
                color: Color(0xff322440))),
        Text(subTitle,
            style: const TextStyle(
                fontSize: 14,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                color: Color(0xff322440))),
        const SizedBox(height: 5),
        InkWell(
            onTap: () {
              Map bioData = {
                'title': name,
                'image': image,
                'subTitle': subTitle,
                'description': description,
              };
              showAlertDialog(context, bioData);

              //context.go('/${NavigationRoute.bioFullScreen}', extra: bioData);
            },
            child: const Text('Read Bio >',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff490a53)))),
      ],
    );
  }

  Widget visionWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftRightsize, right: leftRightsize),
      child: Column(
        children: [
          const Center(
              child: Text('Our Vision & Mission',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500))),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xff3C023B),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/aboutUsVision.png',
                                height: 50,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Our vision',
                                style: TextStyle(
                                  color: Color(0xffF1CE78),
                                  fontSize: 22,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0xff320031),
                      width: double.infinity,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'EnrichTV envisions a world where transformative learning from world-class experts is available to everyone, anytime, anywhere, on any device. We strive to break down barriers of geography, culture, language, age, gender, education, social status, and financial means to make knowledge accessible to all.',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xff3C023B),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/aboutUsTarget.png',
                                height: 50,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Our Mission',
                                style: TextStyle(
                                  color: Color(0xffF1CE78),
                                  fontSize: 22,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0xff320031),
                      width: double.infinity,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'EnrichTVs mission is to empower over a billion lives to Dream, Believe, and Achieve, and spark a global ripple effect of shared wisdom and collective growth, fostering a world where knowledge knows no boundaries and nurturing a growth mindset for continuous development, to shape a brighter future for all.',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                    color: const Color(0xff3C023B),
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Dream. Believe. Achieve',
                          style: TextStyle(
                              color: Color(0xffF1CE78),
                              fontSize: 22,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500)),
                    ))),
                Container(
                  color: const Color(0xff320031),
                  width: double.infinity,
                  child: const SizedBox(
                    width: 400,
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                          'In a world where the traditional education and employment systems are failing us, and an unprecedented number of people are grappling with confusion, loneliness, and unhappiness, EnrichTV emerges as a shining beacon of hope and inspiration. As the worlds premier TV channel and digital platform, EnrichTV is dedicated to providing curated holistic transformational coaching, mentoring, training, healing, and motivational content that transcends the boundaries of conventional education.',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ourTeamWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftRightsize, right: leftRightsize),
      child: Column(
        children: [
          const Center(
              child: Text('Meet Our Core Team',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600))),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTeam(
                  dummyData['section2']['data'][0]['image'],
                  dummyData['section2']['data'][0]['title'],
                  dummyData['section2']['data'][0]['subTitle'],
                  dummyData['section2']['data'][0]['description']),
              buildTeam(
                  dummyData['section2']['data'][1]['image'],
                  dummyData['section2']['data'][1]['title'],
                  dummyData['section2']['data'][1]['subTitle'],
                  dummyData['section2']['data'][1]['description']),
              buildTeam(
                  dummyData['section2']['data'][2]['image'],
                  dummyData['section2']['data'][2]['title'],
                  dummyData['section2']['data'][2]['subTitle'],
                  dummyData['section2']['data'][2]['description']),
            ],
          ),
        ],
      ),
    );
  }

  Widget languageWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffC38632), width: 8),
          color: const Color(0xffF8E892)),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Language And Cultural Accessibility',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff490a53))),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                  'We understand the importance of connecting with our audience on a deeper level. Thats why we offer resources in English, Hindi, Marathi, Gujarati, Tamil, Telugu, Malayalam, Kannada, and other Indian regional languages, to ensure that learners can connect with life-changing wisdom in their native language.',
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff490a53))),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget milstoneWidget(BuildContext context) {
    return Column(
      children: [
        const Center(
            child: Text('EnrichTV Milestones',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600))),
        SizedBox(
          width: double.infinity,
          child: Image.asset('assets/images/milstonePic.png'),
        ),
      ],
    );
  }

  Widget categoryWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff490a53),
        image: DecorationImage(
          image: AssetImage("assets/images/aboutUsCategoryBg.png"),
          opacity: 0.2,
          fit: BoxFit.cover,
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Categories(renderScrollButtons: !isMobile(context),),
      ),
    );
  }

  showAlertDialog(BuildContext context, Map bioData) {
    AlertDialog alert = AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            bioData['image'],
            width: 150,
            height: 200,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(bioData['title'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  )),
              Text(bioData['subTitle'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ))
            ],
          )
        ],
      ),
      content: Text(bioData['description'],
          style: const TextStyle(
              fontSize: 14,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
              color: Colors.black)),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
