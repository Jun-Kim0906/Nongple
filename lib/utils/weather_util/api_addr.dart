/// 하늘상태 [SKY] => { 맑음 : 0 ~ 5 }, { 구름많음 : 6 ~ 8 }, { 흐림 : 9 ~ 10 }

String serviceKey =
    'serviceKey=i4IEpXIP0gP8v4Kvwnz%2FwRwVVcDse7fMVVsqDhG0DeEjXXM7TtD2qHHgeMz%2BMeq6WV0EJ4gLNnLJugGw%2BPBYnw%3D%3D';

String pageNo = '1';
String numOfRows = '999';
String dataType = 'JSON';


/// 동네예보조회
/// 습도 [REH] => % + fcstValue 참고
/// 하늘상태 [SKY] => catagory + fcstValue 코드 값
/// 기온 [T3H] => degrees celcius + fcstValue 참고 ; 3시간 기온
String villageFcstHeader = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst?$serviceKey&pageNo=$pageNo&numOfRows=$numOfRows&dataType=$dataType';


/// 초단기예보조회
/// 기온 [T1H] => fcstValue 참고
String ultraSrtFcstHeader = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst?$serviceKey&pageNo=$pageNo&numOfRows=$numOfRows&dataType=$dataType';

