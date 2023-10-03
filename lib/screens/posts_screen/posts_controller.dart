import 'package:bptracker/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/base_controller.dart';
import '../../models/post_model.dart';
import '../../utils/admob_ads_manager.dart';
import 'posts_view.dart';

class PostsController extends BaseController {

  final List<PostModel> posts = [
    PostModel(
      title: "Learn More About Blood Pressure?",
      icon: AppAssets().icBloodPressureG,
      content: [
        Para(txt: "Blood pressure is a measure of the force of blood pushing against the walls of the arteries as it is pumped around the body by the heart. It is expressed in terms of two numbers: systolic blood pressure and diastolic blood pressure.",),
        Para(txt: "Systolic blood pressure is the higher of the two numbers and represents the pressure in the arteries when the heart beats, or contracts. Diastolic blood pressure is the lower number and represents the pressure in the arteries when the heart is resting, or between beats.",),
        Para(txt: "Normal blood pressure for an adult is generally considered to be a systolic pressure of less than 120 mmHg and a diastolic pressure of less than 80 mmHg. These numbers can vary depending on age, gender, and other factors. For example, normal blood pressure for a man in his 60s may be slightly higher than for a woman in her 20s.",),
        Para(txt: "High blood pressure, or hypertension, is a common condition that occurs when the blood pressure in the arteries is consistently too high. It can be caused by a variety of factors, including unhealthy diet, lack of exercise, obesity, and stress. High blood pressure can lead to serious health problems, including heart disease, stroke, and kidney failure."),
        Para(txt: "Low blood pressure, or hypotension, is less common than high blood pressure and occurs when the blood pressure in the arteries is consistently too low. It can be caused by certain medications, dehydration, and certain medical conditions. Low blood pressure can cause symptoms such as dizziness, fainting, and fatigue."),
        Para(txt: "Blood pressure can be measured using a blood pressure monitor, which consists of an inflatable cuff that is placed around the upper arm and a device that measures the pressure in the cuff. It is important to have regular blood pressure checks, as high or low blood pressure may not have any symptoms."),
        Para(txt: "There are several ways to manage blood pressure, including lifestyle changes such as eating a healthy diet, exercising regularly, and managing stress. In some cases, medication may also be necessary to help control blood pressure."),
        Para(txt: "It is important to pay attention to blood pressure and take steps to maintain normal levels to reduce the risk of health problems. This includes regular check-ups with a healthcare provider, monitoring blood pressure at home, and making necessary lifestyle changes."),
        Para(txt: "In summary, blood pressure is a measure of the force of blood in the arteries. Normal blood pressure is considered to be less than 120/80 mmHg. High blood pressure, or hypertension, can lead to serious health problems, while low blood pressure, or hypotension, can cause symptoms such as dizziness and fainting. Blood pressure can be managed through lifestyle changes and, in some cases, medication. It is important to have regular blood pressure checks and take steps to maintain normal levels."),
      ],
    ),
    PostModel(
        title: "Is my blood pressure normal?",
        icon: AppAssets().icBloodPressureExe,
        content: [
          Para(txt: "If you are wondering whether your blood pressure is normal, it is important to have it checked by a healthcare provider. Normal blood pressure for an adult is generally considered to be a systolic pressure (the higher of the two numbers) of less than 120 mmHg and a diastolic pressure (the lower number) of less than 80 mmHg. These numbers can vary depending on age, gender, and other factors."),
          Para(txt: "It is important to note that blood pressure can fluctuate throughout the day and may be affected by various factors such as stress, caffeine, and exercise. A single high or low reading does not necessarily mean that you have high or low blood pressure. A diagnosis of high or low blood pressure is typically based on multiple readings taken over a period of time."),
          Para(txt: "If you have high blood pressure, it is important to take steps to lower it. High blood pressure, or hypertension, is a common condition that occurs when the blood pressure in the arteries is consistently too high. It can lead to serious health problems, including heart disease, stroke, and kidney failure. Lifestyle changes, such as eating a healthy diet, exercising regularly, and managing stress, can help lower blood pressure. In some cases, medication may also be necessary."),
          Para(txt: "On the other hand, if you have low blood pressure, it may not necessarily be a cause for concern. Low blood pressure, or hypotension, is less common than high blood pressure and occurs when the blood pressure in the arteries is consistently too low. It can cause symptoms such as dizziness, fainting, and fatigue. Low blood pressure can be caused by certain medications, dehydration, and certain medical conditions. In some cases, it may be necessary to treat low blood pressure, but in other cases, it may not cause any problems."),
        ]),
    PostModel(
      title: "Who is at risk of high blood pressure?",
      icon: AppAssets().icHighBloodPressure,
      content: [
        Para(
            txt:
            "High blood pressure, or hypertension, is a common condition that occurs when the blood pressure in the arteries is consistently too high. It can lead to serious health problems, including heart disease, stroke, and kidney failure."),
        const SizedBox(height: 10),
        H4(txt: "Certain individuals may be at higher risk of developing high blood pressure. These include:"),
        const SizedBox(height: 10),
        Para(txt: "Older adults: As you get older, your risk of developing high blood pressure increases."),
        Para(txt: "Those with a family history of high blood pressure: If your parents or other close relatives have high blood pressure, you may be more likely to develop it as well."),
        Para(txt: "African Americans: African Americans have a higher risk of developing high blood pressure compared to other racial groups."),
        Para(txt: "Those who are overweight or obese: Being overweight or obese can increase your risk of high blood pressure."),
        Para(txt: "Those who do not exercise regularly: Lack of physical activity can increase your risk of high blood pressure."),
        Para(txt: "Those who eat a diet high in salt: A diet that is high in salt can increase your risk of high blood pressure."),
        Para(txt: "Those who smoke: Smoking can damage the blood vessels and increase your risk of high blood pressure."),
        Para(txt: "It is important to be aware of your risk factors for high blood pressure and take steps to reduce your risk. This can include maintaining a healthy weight, exercising regularly, eating a healthy diet, and not smoking. If you are at high risk of developing high blood pressure, it is important to have your blood pressure checked regularly and discuss any concerns with a healthcare provider."),

      ],
    ),
    PostModel(
        title:
        "How can I prevent high blood pressure?",
        icon: AppAssets().icPreventBloodPressure,
        content: [
          Para(
              txt:
              "High blood pressure, or hypertension, is a common condition that occurs when the blood pressure in the arteries is consistently too high. It can lead to serious health problems, including heart disease, stroke, and kidney failure."),
          const SizedBox(height: 10),
          H4(txt: "There are several steps that you can take to help prevent high blood pressure:"),
          const SizedBox(height: 10),
          Para(
              txt:
              "Maintain a healthy weight: Being overweight or obese can increase your risk of high blood pressure. Losing excess weight through diet and exercise can help lower your blood pressure."),
          Para(txt: "Exercise regularly: Regular physical activity can help lower blood pressure and improve overall health. Aim for at least 150 minutes of moderate-intensity exercise per week."),
          Para(txt: "Eat a healthy diet: A diet that is rich in fruits, vegetables, and whole grains and low in sodium, saturated fat, and cholesterol can help lower blood pressure."),
          Para(txt: "Limit alcohol intake: Heavy alcohol consumption can contribute to high blood pressure. It is recommended to limit alcohol to no more than one drink per day for women and two drinks per day for men."),
          Para(txt: "Quit smoking: Smoking can damage the blood vessels and increase your risk of high blood pressure. Quitting smoking can help lower your blood pressure and reduce your risk of other health problems."),
          Para(txt: "Manage stress: Chronic stress can contribute to high blood pressure. Finding healthy ways to manage stress, such as through exercise, meditation, or talking to a mental health professional, can help lower blood pressure."),
          Para(txt: "ake medications as prescribed: If you have been prescribed blood pressure medication, it is important to take it as directed. Do not stop taking your medication without first consulting with your healthcare provider."),
          Para(txt: "By making lifestyle changes and following your healthcare provider's recommendations, you can help prevent high blood pressure and maintain healthy blood pressure levels."),
        ]),

    PostModel(
        title:
        "How Do I know if anyone have diabetes?",
        icon: AppAssets().icPreventBloodPressure,
        content: [
          Para(
              txt:
              "There are several signs and symptoms that may indicate someone has diabetes. These include:"),
          Para(txt: "Increased thirst: People with diabetes may feel very thirsty and may drink large amounts of fluids."),
          Para(txt: "Frequent urination: Because the body is trying to get rid of excess glucose (sugar) through urine, people with diabetes may need to urinate more frequently, especially at night."),
          Para(txt: "Hunger: People with diabetes may feel very hungry, even after eating."),
          Para(txt: "Fatigue: Diabetes can cause fatigue, as the body is unable to properly use and store energy."),
          Para(txt: "Blurred vision: High levels of glucose in the blood can affect the lens of the eye and cause blurry vision."),
          Para(txt: "Slow healing: High blood sugar levels can interfere with the body's ability to heal cuts and wounds."),
          Para(txt: "Dry skin: Diabetes can cause dry, itchy skin."),
          Para(txt: "Tingling or numbness in the hands and feet: High blood sugar levels can cause nerve damage, leading to tingling or numbness in the hands and feet."),
          Para(txt: "Frequent infections: People with diabetes may be more prone to infections, such as bladder, kidney, or skin infections."),
          Para(txt: "If you are experiencing any of these symptoms, it is important to see a healthcare provider for evaluation and testing. It is also important to note that some people with diabetes may not have any symptoms and may only be diagnosed during a routine medical check-up."),

        ]),

    PostModel(
        title:
        "Knowledge about heart rate?",
        icon: AppAssets().icBloodPressureG,
        content: [
          Para(txt: "Your heart rate, also known as your pulse, is the number of times your heart beats per minute. It is a measure of the strength and speed of your heart's contractions. The heart pumps blood around the body to provide oxygen and nutrients to the tissues."),
          Para(txt: "A normal heart rate for an adult at rest is typically between 60 and 100 beats per minute. However, this can vary depending on age, physical activity level, and other factors. For example, a highly fit person may have a lower resting heart rate compared to someone who is less active."),
          Para(txt: "Heart rate can be measured by feeling the pulse at the wrist, neck, or chest. It can also be measured using a device called a pulse oximeter, which is placed on the finger and measures the oxygen level in the blood."),
          Para(txt: "Heart rate can be affected by various factors, such as physical activity, stress, and certain medications. A heart rate that is consistently too high or too low may be a sign of a medical condition and should be evaluated by a healthcare provider."),
          Para(txt: "Maintaining a healthy heart rate is important for overall health. This can be achieved through regular physical activity, maintaining a healthy diet, and managing stress. It is also important to have regular check-ups with a healthcare provider to monitor heart health."),

        ]),
  ];

  late AdmobAdsManager admobAdsManager;
  bool bannerLoaded = false;

  @override
  void onInit() {
    super.onInit();
    admobAdsManager = AdmobAdsManager();
    admobAdsManager.loadBannerAd((val) {
      bannerLoaded = val;
      update();
    });
    admobAdsManager.loadIntertitialAd();
  }

  @override
  void dispose() {
    admobAdsManager.disposeBannerAd();
    super.dispose();
  }


}
