/// svg
const String SVG_SUN_LINE = 'assets/svgs/0.svg';
const String SVG_CELSIUS_FILL = 'assets/svgs/celsius-fill.svg';
const String SVG_TEMP_COLD_LINE = 'assets/svgs/temp-cold-line.svg';
const String SVG_TEMP_HOT_LINE = 'assets/svgs/temp-hot-line.svg';
const String SVG_WINDY_FILL = 'assets/svgs/windy-fill.svg';

const String SVG_WEATHER_ICON_0 = 'assets/svgs/0.svg';
const String SVG_WEATHER_ICON_1 = 'assets/svgs/1.svg';
const String SVG_WEATHER_ICON_2 = 'assets/svgs/2.svg';
const String SVG_WEATHER_ICON_3_7_8_19_21_22 = 'assets/svgs/3_7_8_19_21_22.svg';
const String SVG_WEATHER_ICON_4_5 = 'assets/svgs/4_5.svg';
const String SVG_WEATHER_ICON_6_13_14_15_16_26_27_28_302 = 'assets/svgs/6_13_14_15_16_26_27_28_302.svg';
const String SVG_WEATHER_ICON_9_10_11_12_23_24_25_301 = 'assets/svgs/9_10_11_12_23_24_25_301.svg';
const String SVG_WEATHER_ICON_18_20_29_30_31_32_49_53_54_55_56_57_58 = 'assets/svgs/18_20_29_30_31_32_49_53_54_55_56_57_58.svg';

/// img
const String IMG_HIGH_SIERRA = 'assets/images/HighSierra.jpg';

class AssetsNames {


  static String weatherIconName(String weatherImg) {
    switch(weatherImg) {
      case '0':
        return SVG_WEATHER_ICON_0;
      case '1':
        return SVG_WEATHER_ICON_1;
      case '2':
        return SVG_WEATHER_ICON_2;
      case '3':
      case '7':
      case '8':
      case '19':
      case '21':
      case '22':
        return SVG_WEATHER_ICON_3_7_8_19_21_22;
      case '4':
      case '5':
        return SVG_WEATHER_ICON_4_5;
      case '6':
      case '13':
      case '14':
      case '15':
      case '16':
      case '26':
      case '27':
      case '28':
      case '302':
        return SVG_WEATHER_ICON_6_13_14_15_16_26_27_28_302;
      case '9':
      case '10':
      case '11':
      case '12':
      case '23':
      case '24':
      case '25':
      case '301':
        return SVG_WEATHER_ICON_9_10_11_12_23_24_25_301;
      case '18':
      case '20':
      case '29':
      case '30':
      case '31':
      case '32':
      case '49':
      case '53':
      case '54':
      case '55':
      case '56':
      case '57':
      case '58':
        return SVG_WEATHER_ICON_18_20_29_30_31_32_49_53_54_55_56_57_58;
      default:
        return SVG_WEATHER_ICON_0;
    }
  }
}