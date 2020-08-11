
import 'package:nongple/models/rss/rss.dart';

List<Rss> rssHardCoding = [
  Rss(name: '곡성군', option: [
    '곡성군청',
    '곡성농기원'
  ], url: [
    'http://www.gokseong.go.kr/main/?pid=435&act=rss',
    'https://node2.feed43.com/3714372437302370.xml',
  ]),
  Rss(name: '전남농기원', option: [
    '공지사항',
  ], url: [
    'http://feed43.com/4860412735274178.xml',
  ]),
  Rss(
      name: '서울특별시',
      option: ['새소식'],
      url: ['http://news.seoul.go.kr/gov/feed']),
  Rss(
    name: '종로구',
    option: ['공지·행사', '교육', '고시공고'],
    url: [
      'http://www.jongno.go.kr/Rss.do?fid=Notice&cityFlag=N',
      'http://www.jongno.go.kr/Rss.do?fid=Education&cityFlag=N',
      'http://www.jongno.go.kr/Rss.do?fid=NewsPaper1&cityFlag=N',
    ],
  ),
  Rss(name: '중구', option: [
    '공지사항',
    '고시공고'
  ], url: [
    'http://www.junggu.seoul.kr/rss.jsp?bid=457&returnURL=/content.do?cmsid=14231',
    'http://www.junggu.seoul.kr/rss.jsp?bid=469&returnURL=/content.do?cmsid=14232',
  ]),
  Rss(name: '광진구', option: [
    '공지사항',
    '고시공고'
  ], url: [
    'https://www.gwangjin.go.kr/portal/bbs/B0000001/rssService.do?viewType=CONTBODY&bbsId=B01',
    'https://www.gwangjin.go.kr/portal/bbs/B0000003/rssService.do?viewType=CONTBODY&bbsId=B03',
  ]),
  Rss(name: '중랑구', option: [
    '구정소식',
    '고시공고',
    '입찰공고'
  ], url: [
    'http://www.jungnang.go.kr/portal/bbs/rss/B0000002.do?menuNo=200473',
    'http://www.jungnang.go.kr/portal/bbs/rss/B0000117.do?menuNo=200475',
    'http://www.jungnang.go.kr/portal/bbs/rss/B0000119.do?menuNo=200477',
  ]),
  Rss(name: '성북구', option: [
    '구정소식',
    '구정소식'
  ], url: [
    'http://www.sb.go.kr/RssXML3.do?fid=sosik',
    'http://www.sb.go.kr/RssXML3.do?fid=recruit',
  ]),
//  Rss(name: '강북구', option: [
//    '새소식',
//    '고시공고',
//    '수의계약'
//  ], url: [
//    'http://www.gangbuk.go.kr/common/rss/rss_notice.jsp',
//    'http://www.gangbuk.go.kr/common/rss/rss_gosi.jsp',
//    'http://www.gangbuk.go.kr/common/rss/rss_suwi.jsp',
//  ]),
  Rss(name: '도봉구', option: [
    '공지사항',
    '행사모집',
    '고시공고'
  ], url: [
    'http://www.dobong.go.kr/WDB_common/rss/bbs.asp?code=10004124',
    'http://www.dobong.go.kr/WDB_common/rss/bbs.asp?code=10004125',
    'http://www.dobong.go.kr/WDB_common/rss/bbs.asp?code=10004124',
  ]),
//  Rss(name: '노원구', option: [
//    '새소식',
//    '공고/고시'
//  ], url: [
//    'http://www.nowon.kr/help/rss_data.jsp?board_num=101',
//    'http://www.nowon.kr/help/rss_data.jsp?board_num=103',
//  ]),
  Rss(name: '은평구', option: [
    '공지사항'
  ], url: [
    'http://www.ep.go.kr/CmsWeb/rss/PG0000001131_CP0000000002_BO0000000087.xml',
  ]),
  Rss(name: '서대문구', option: [
    '공지사항',
    '고시공고'
  ], url: [
    'http://www.sdm.go.kr/rss/rssBoard.do?seq=106',
    'http://www.sdm.go.kr/rss/rssBoard.do?seq=82',
  ]),
  Rss(name: '양천구', option: [
    '공지사항',
  ], url: [
    'http://www.yangcheon.go.kr/rss/yangcheon/board/254.do?1=1',
  ]),
  Rss(name: '강서구', option: [
    '공지사항',
    '고시공고입찰'
  ], url: [
    'http://www.gangseo.seoul.kr/new_portal/guide/rss.jsp?boardId=5',
    'http://www.gangseo.seoul.kr/new_portal/guide/rss.jsp?boardId=323',
  ]),
  Rss(name: '구로구', option: [
    '새소식',
    '고시공고'
  ], url: [
    'http://www.guro.go.kr/www/rss/NR_index.do?pBoardCode=B00000016',
    'http://www.guro.go.kr/www/board/NR_convertAction.do?type=rss&bbsCd=332&domain=www'
  ]),
  Rss(name: '서초구', option: [
    '공지사항',
    '행사안내'
  ], url: [
    'http://www.seocho.go.kr/rss/notice.jsp',
    'http://www.seocho.go.kr/rss/event.jsp',
  ]),
  Rss(name: '강남구', option: [
    '공지사항',
    '구보 입법예고'
  ], url: [
    'http://www.gangnam.go.kr/portal/bbs/rss.do?bbsId=B_000001',
    'http://www.gangnam.go.kr/portal/bbs/rss.do?bbsId=B_000068',
  ]),
//  Rss(name: '송파구', option: [
//    '송파소식',
//    '고시공고'
//  ], url: [
//    'http://www.songpa.go.kr/rss/rss.jsp?pBBS=',
//    'http://www.songpa.go.kr/rss/rss.jsp?pBBS=2',
//  ]),
  Rss(name: '강동구', option: [
    '강동구청 소식'
  ], url: [
    'http://www.gangdong.go.kr/rss/common/rss.do?bbsId=1140',
  ]),
  Rss(
    name: '전남도청',
    option: ['보도자료', '공지사항', '고시공고', '전남도보', '채용정보', '농정뉴스'],
    url: [
      'http://www.jeonnam.go.kr/M7116/boardRss.do',
      'http://www.jeonnam.go.kr/M7124/boardRss.do',
      'http://www.jeonnam.go.kr/J0203/boardRss.do',
      'http://www.jeonnam.go.kr/J0204/boardRss.do',
      'http://www.jeonnam.go.kr/M7156/boardRss.do',
      'http://www.jeonnam.go.kr/M5409/boardRss.do',
    ],
  ),
  Rss(
    name: '농림부',
    option: ['고지공고', '보도자료', '해명설명'],
    url: [
      'http://www.mafra.go.kr/bbs/mafra/67/rssList.do?row=50',
      'http://www.mafra.go.kr/bbs/mafra/68/rssList.do?row=50',
      'http://www.mafra.go.kr/bbs/mafra/69/rssList.do?row=50',
    ],
  ),
  Rss(name: 'K-Strarup', option: [
    '공지사항',
    '공고신청'
  ], url: [
    'https://www.k-startup.go.kr/common/rssFeed.do?mid=30042&cid=0&bid=101&kid=0&sid=0&boardUrl=/common/post/list.do',
    'https://www.k-startup.go.kr/common/rssFeed.do?mid=30004&cid=0&bid=701&kid=0&sid=0&boardUrl=/common/announcement/announcementList.do',
  ]),
  Rss(name: '사회적기업 진흥원', option: [
    '열린 알림방',
    '공지사항',
  ], url: [
    'http://feed43.com/2783301144874276.xml',
    'http://feed43.com/4808241128344308.xml',
  ]),
  Rss(name: '씽굿', option: [
    '중앙 P1',
    '중앙 P2',
    '지방',
  ], url: [
    'http://feed43.com/5834408711853414.xml',
    'http://feed43.com/0482015233273414.xml',
    'http://feed43.com/7443078224384305.xml',
  ]),
  Rss(name: 'COOP', option: [
    '공지사항',
    '열린 알림방',
  ], url: [
    'http://feed43.com/0250618216420430.xml',
    'http://feed43.com/8151884501338257.xml',
  ]),
  Rss(name: 'jnStartup', option: [
    '사업공고',
    '공모전',
  ], url: [
    'http://feed43.com/1842378740271228.xml',
    'http://feed43.com/7638832624551863.xml',
  ]),
  Rss(name: 'RIPC 지역지식재산', option: [
    '사업공고',
  ], url: [
    'https://feed43.com/8335301052520882.xml',
  ]),
  Rss(name: '전남지식센터', option: [
    '사업공고',
  ], url: [
    'https://feed43.com/0610311412058366.xml',
  ]),
  Rss(name: 'Wevity', option: [
    '공모전',
  ], url: [
    'https://feed43.com/6425001055172478.xml',
  ]),
];
