/**
 * 쓰리알솔루션 - 카카오맵 연동
 * 전자정부프레임워크 3.9 ES5 호환
 */

var map = null;
var infowindow = null;
var center = null;
var level = 3;

function locationMap() {
    console.log("카카오지도 호출");

    try {
        infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
        center     = new kakao.maps.LatLng(37.2149453444309, 127.0999870429);

        var mapContainer = document.getElementById('mapWrap');
        var mapOption    = { center: center, level: level };

        map = new kakao.maps.Map(mapContainer, mapOption);

        /* ── 마커 생성 ── */
        var markerPosition = new kakao.maps.LatLng(37.2149453444309, 127.0999870429);
        var marker = new kakao.maps.Marker({ position: markerPosition });
        marker.setMap(map);

        /* ── 인포윈도우 (말풍선) ── */
        var iwContent  = '<div style="padding:10px 14px;font-size:13px;font-weight:700;color:#4f46e5;white-space:nowrap;">'
                       + '<i style="margin-right:6px;">📍</i>쓰리알솔루션 (효성ICT타워 604호)</div>';
        var iwRemoveable = false;

        infowindow = new kakao.maps.InfoWindow({
            content  : iwContent,
            removable: iwRemoveable
        });
        infowindow.open(map, marker);

        /* ── 마커 클릭 시 인포윈도우 토글 ── */
        kakao.maps.event.addListener(marker, 'click', function() {
            if (infowindow) {
                infowindow.open(map, marker);
            }
        });

        console.log("카카오지도 로드 성공");

    } catch (e) {
        console.log("카카오 api 연동 실패", e);

        var mapWrap = document.getElementById('mapWrap');
        if (mapWrap) {
            mapWrap.innerHTML =
                '<div style="display:flex;flex-direction:column;align-items:center;justify-content:center;height:100%;gap:12px;">'
              + '<p style="font-size:2rem;">🗺️</p>'
              + '<p style="font-size:1rem;font-weight:700;color:#475569;">외부 지도 서버의 장애로</p>'
              + '<p style="font-size:1rem;color:#94a3b8;">지도 표출이 되지 않습니다.</p>'
              + '<a href="https://map.kakao.com/link/search/경기도 화성시 동탄대로 677-12 효성ICT타워" '
              + 'target="_blank" style="margin-top:8px;padding:10px 20px;background:#fee500;color:#3c1e1e;border-radius:8px;font-weight:700;text-decoration:none;font-size:0.9rem;">'
              + '카카오맵에서 보기</a>'
              + '</div>';
        }
    }
}

/* ── 카카오맵 SDK 로드 완료 후 실행 ── */
function kakaoMapInit() {
    kakao.maps.load(function() {
        locationMap();
    });
}
