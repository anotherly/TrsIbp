<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>THREE-R SOLUTION | Right Time / Value / Service</title>
  <link rel="stylesheet" href="css/style.css" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;900&family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.0/css/all.min.css" />
</head>
<body>

  <!-- ===== HEADER / NAV ===== -->
  <header id="header" class="header">
    <nav class="nav container">
      <!-- 헤더 로고: 풀로고 이미지 (Two-R Solution 텍스트+아이콘) -->
      <a href="#" class="nav-logo">
        <img src="images/logo/logo-full_1.png" alt="Three-R Solution 로고" class="logo-full-img" />
      </a>
      <ul class="nav-menu" id="nav-menu">
        <li><a href="#about" class="nav-link">회사소개</a></li>
        <li><a href="#services" class="nav-link">서비스</a></li>
        <li><a href="#stats" class="nav-link">실적</a></li>
        <li><a href="#team" class="nav-link">팀</a></li>
        <li><a href="#news" class="nav-link">뉴스</a></li>
        <li><a href="#contact" class="nav-link nav-cta">문의하기</a></li>
      </ul>
      <button class="hamburger" id="hamburger" aria-label="메뉴 열기">
        <span></span><span></span><span></span>
      </button>
    </nav>
  </header>

  <main>

    <!-- ===== HERO ===== -->
    <section id="hero" class="hero">
      <div class="hero-bg-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
      </div>
      <div class="container hero-content">
        <div class="hero-badge"><i class="fa-solid fa-star"></i> 2026 신규 창설 여성대표기업</div>
        <h1 class="hero-title">
          미래를 향한<br />
          <span class="highlight">혁신</span>의 시작,<br />
          <span class="highlight">3RSOLUTION</span>
        </h1>
        <p class="hero-desc">
          저희는 기술과 창의성으로 비즈니스의 경계를 넓힙니다.<br />
          고객의 성공이 곧 우리의 성공입니다.
        </p>
        <div class="hero-actions">
          <a href="#services" class="btn btn-primary">서비스 살펴보기 <i class="fa-solid fa-arrow-right"></i></a>
          <a href="#contact" class="btn btn-outline">상담 신청</a>
        </div>
        <!-- ===== PARTNER SLIDER (hero 하단 통합) ===== -->
        <div class="partner-section" id="partner">
          <div class="partner-header">
            <div class="partner-header-left">
              <h2 class="partner-title">PARTNER</h2>
              <p class="partner-desc">
                쓰리알솔루션은 국내 다양한 업체 및 기관에 최적화된<br />
                시스템 및 고급 기술 서비스를 제공하였습니다.
              </p>
            </div>
            <div class="partner-header-right">
              <a href="#contact" class="btn-reference">
                REFERENCE <i class="fa-solid fa-chevron-right"></i>
              </a>
            </div>
          </div>

          <!-- 슬라이더 래퍼 -->
          <div class="partner-slider-wrap">
            <div class="partner-track" id="partnerTrack">

              <!-- 카드 1: 도로교통공단 -->
              <div class="partner-card"
                   data-img=""
                   data-icon="fa-solid fa-road"
                   data-color="#1e40af">
                <div class="partner-card-inner">
                  <div class="partner-logo-area">
                    <div class="partner-icon-placeholder" style="background:#dbeafe; color:#1e40af;">
                      <i class="fa-solid fa-road"></i>
                    </div>
                  </div>
                  <div class="partner-card-body">
                    <h4>도로교통공단</h4>
                    <time>2022. 02</time>
                  </div>
                </div>
                <div class="partner-card-hover-img">
                  <div class="partner-hover-placeholder" style="background:linear-gradient(135deg,#1e3a8a,#2563eb);">
                    <i class="fa-solid fa-road"></i>
                    <span>도로교통공단</span>
                  </div>
                  <div class="partner-hover-info">
                    <strong>도로교통공단</strong>
                    <time>2022. 02</time>
                  </div>
                </div>
              </div>

              <!-- 카드 2: 한국교통안전공단 -->
              <div class="partner-card"
                   data-icon="fa-solid fa-shield-halved"
                   data-color="#065f46">
                <div class="partner-card-inner">
                  <div class="partner-logo-area">
                    <div class="partner-icon-placeholder" style="background:#d1fae5; color:#065f46;">
                      <i class="fa-solid fa-shield-halved"></i>
                    </div>
                  </div>
                  <div class="partner-card-body">
                    <h4>한국교통안전공단</h4>
                    <time>2024. 06</time>
                  </div>
                </div>
                <div class="partner-card-hover-img">
                  <div class="partner-hover-placeholder" style="background:linear-gradient(135deg,#064e3b,#059669);">
                    <i class="fa-solid fa-shield-halved"></i>
                    <span>한국교통안전공단</span>
                  </div>
                  <div class="partner-hover-info">
                    <strong>한국교통안전공단</strong>
                    <time>2024. 06</time>
                  </div>
                </div>
              </div>

              <!-- 카드 3: 코레일 -->
              <div class="partner-card"
                   data-icon="fa-solid fa-train"
                   data-color="#7c3aed">
                <div class="partner-card-inner">
                  <div class="partner-logo-area">
                    <div class="partner-icon-placeholder" style="background:#ede9fe; color:#7c3aed;">
                      <i class="fa-solid fa-train"></i>
                    </div>
                  </div>
                  <div class="partner-card-body">
                    <h4>코레일</h4>
                    <time>2025. 05</time>
                  </div>
                </div>
                <div class="partner-card-hover-img">
                  <div class="partner-hover-placeholder" style="background:linear-gradient(135deg,#4c1d95,#7c3aed);">
                    <i class="fa-solid fa-train"></i>
                    <span>코레일</span>
                  </div>
                  <div class="partner-hover-info">
                    <strong>코레일</strong>
                    <time>2025. 05</time>
                  </div>
                </div>
              </div>

              <!-- 카드 4: 공항철도 -->
              <div class="partner-card"
                   data-icon="fa-solid fa-plane-departure"
                   data-color="#0369a1">
                <div class="partner-card-inner">
                  <div class="partner-logo-area">
                    <div class="partner-icon-placeholder" style="background:#e0f2fe; color:#0369a1;">
                      <i class="fa-solid fa-plane-departure"></i>
                    </div>
                  </div>
                  <div class="partner-card-body">
                    <h4>공항철도</h4>
                    <time>2020. 09</time>
                  </div>
                </div>
                <div class="partner-card-hover-img">
                  <div class="partner-hover-placeholder" style="background:linear-gradient(135deg,#0c4a6e,#0369a1);">
                    <i class="fa-solid fa-plane-departure"></i>
                    <span>공항철도</span>
                  </div>
                  <div class="partner-hover-info">
                    <strong>공항철도</strong>
                    <time>2020. 09</time>
                  </div>
                </div>
              </div>

              <!-- 카드 5: 인천교통공사 -->
              <div class="partner-card"
                   data-icon="fa-solid fa-train-subway"
                   data-color="#b45309">
                <div class="partner-card-inner">
                  <div class="partner-logo-area">
                    <div class="partner-icon-placeholder" style="background:#fef3c7; color:#b45309;">
                      <i class="fa-solid fa-train-subway"></i>
                    </div>
                  </div>
                  <div class="partner-card-body">
                    <h4>인천교통공사</h4>
                    <time>2024. 11</time>
                  </div>
                </div>
                <div class="partner-card-hover-img">
                  <div class="partner-hover-placeholder" style="background:linear-gradient(135deg,#78350f,#d97706);">
                    <i class="fa-solid fa-train-subway"></i>
                    <span>인천교통공사</span>
                  </div>
                  <div class="partner-hover-info">
                    <strong>인천교통공사</strong>
                    <time>2024. 11</time>
                  </div>
                </div>
              </div>

              <!-- 카드 6: 인천국제공항 -->
              <div class="partner-card partner-card-wide"
                   data-icon="fa-solid fa-tower-control"
                   data-color="#0f172a">
                <div class="partner-card-inner">
                  <div class="partner-logo-area">
                    <div class="partner-icon-placeholder" style="background:#f1f5f9; color:#334155;">
                      <i class="fa-solid fa-tower-control"></i>
                    </div>
                  </div>
                  <div class="partner-card-body">
                    <h4>TO BE NEXT</h4>
                    <time>2026. 05</time>
                  </div>
                </div>
                <div class="partner-card-hover-img">
                  <div class="partner-hover-placeholder" style="background:linear-gradient(135deg,#0f172a,#1e293b);">
                    <i class="fa-solid fa-tower-control"></i>
                    <span>TO BE NEXT</span>
                  </div>
                  <div class="partner-hover-info">
                    <strong>TO BE NEXT</strong>
                    <time>2026. 05</time>
                  </div>
                </div>
              </div>

            </div><!-- /partner-track -->
          </div><!-- /partner-slider-wrap -->
        </div><!-- /partner-section -->
      </div>
      <div class="hero-scroll-indicator">
        <span></span>
      </div>
    </section>

    <!-- ===== ABOUT ===== -->
    <section id="about" class="about section">
      <div class="container">
        <div class="about-grid">
          <div class="about-visual">
            <div class="about-img-wrap">
              <div class="about-img-placeholder">
                <i class="fa-solid fa-building-columns"></i>
              </div>
              <div class="about-badge-float">
                <i class="fa-solid fa-award"></i>
                <div>
                  <strong>6년+</strong>
                  <small>유지보수 경험</small>
                </div>
              </div>
            </div>
          </div>
          <div class="about-text">
            <div class="section-label">회사 소개</div>
            <h2 class="section-title">비전을 현실로 만드는<br />파트너</h2>
            <p class="about-desc">
              쓰리알솔루션은 2026년 설립 이전부터 IT 솔루션 분야에서 다양한 공·사 기업과 함께해왔습니다.
            </p>
            <p class="about-desc">
              우리는 단순히 기술을 제공하는 것이 아니라, 고객의 비즈니스 목표에 맞는 전략적 파트너로서의 역할을 수행합니다.
            </p>
            <ul class="about-features">
              <li><i class="fa-solid fa-check-circle"></i> 글로벌 수준의 기술력과 국내 현장 경험</li>
              <li><i class="fa-solid fa-check-circle"></i> 고객 중심의 맞춤형 솔루션 제공</li>
              <li><i class="fa-solid fa-check-circle"></i> 지속 가능한 성장을 위한 장기적 파트너십</li>
              <li><i class="fa-solid fa-check-circle"></i> 24/365 전문 기술 지원 체계</li>
            </ul>
            <a href="#contact" class="btn btn-primary">더 알아보기 <i class="fa-solid fa-arrow-right"></i></a>
          </div>
        </div>
      </div>
    </section>

    <!-- ===== STATS ===== -->
    <section id="stats" class="stats-section">
      <div class="container">
        <div class="stats-grid">
          <div class="stat-card" data-count="5">
            <div class="stat-icon"><i class="fa-solid fa-handshake"></i></div>
            <div class="stat-number"><span class="count">0</span>+</div>
            <div class="stat-label">파트너 기업</div>
          </div>
          <div class="stat-card" data-count="1">
            <div class="stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
            <div class="stat-number"><span class="count">0</span>년+</div>
            <div class="stat-label">업계 경력</div>
          </div>
          <div class="stat-card" data-count="98">
            <div class="stat-icon"><i class="fa-solid fa-face-smile"></i></div>
            <div class="stat-number"><span class="count">0</span>%</div>
            <div class="stat-label">고객 만족도</div>
          </div>
          <div class="stat-card" data-count="10">
            <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
            <div class="stat-number"><span class="count">0</span>+</div>
            <div class="stat-label">완료 프로젝트</div>
          </div>
        </div>
      </div>
    </section>

    <!-- ===== SERVICES ===== -->
    <section id="services" class="services section">
      <div class="container">
        <div class="section-header">
          <div class="section-label">서비스</div>
          <h2 class="section-title">우리가 제공하는 핵심 서비스</h2>
          <p class="section-desc">비즈니스 성공을 위한 종합 솔루션을 제공합니다</p>
        </div>
        <div class="services-grid">
          <article class="service-card">
            <div class="service-icon" style="--icon-color: #4f46e5;">
              <i class="fa-solid fa-laptop-code"></i>
            </div>
            <h3>IT 솔루션 개발</h3>
            <p>최신 기술 스택을 활용한 웹·앱·시스템 개발로 비즈니스 디지털화를 지원합니다.</p>
            <a href="#" class="service-link">자세히 보기 <i class="fa-solid fa-arrow-right"></i></a>
          </article>
          <article class="service-card featured-card">
            <div class="service-badge">인기</div>
            <div class="service-icon" style="--icon-color: #7c3aed;">
              <i class="fa-solid fa-brain"></i>
            </div>
            <h3>AI·데이터 분석</h3>
            <p>데이터 기반 의사결정을 위한 AI·머신러닝 솔루션 및 비즈니스 인텔리전스를 제공합니다.</p>
            <a href="#" class="service-link">자세히 보기 <i class="fa-solid fa-arrow-right"></i></a>
          </article>
          <article class="service-card">
            <div class="service-icon" style="--icon-color: #d97706;">
              <i class="fa-solid fa-headset"></i>
            </div>
            <h3>IT 유지보수 지원</h3>
            <p>24시간 모니터링과 신속한 장애 대응으로 비즈니스 연속성을 보장합니다.</p>
            <a href="#" class="service-link">자세히 보기 <i class="fa-solid fa-arrow-right"></i></a>
          </article>
        </div>
      </div>
    </section>

    <!-- ===== PROCESS ===== -->
    <section class="process section">
      <div class="container">
        <div class="section-header">
          <div class="section-label">진행 과정</div>
          <h2 class="section-title">함께하는 프로세스</h2>
        </div>
        <div class="process-steps">
          <div class="process-step">
            <div class="step-num">01</div>
            <h4>상담 &amp; 분석</h4>
            <p>고객 니즈와 현황을 정밀 분석하여 최적의 솔루션 방향을 도출합니다.</p>
          </div>
          <div class="process-arrow"><i class="fa-solid fa-chevron-right"></i></div>
          <div class="process-step">
            <div class="step-num">02</div>
            <h4>전략 수립</h4>
            <p>데이터 기반의 맞춤 전략과 실행 로드맵을 설계합니다.</p>
          </div>
          <div class="process-arrow"><i class="fa-solid fa-chevron-right"></i></div>
          <div class="process-step">
            <div class="step-num">03</div>
            <h4>개발 &amp; 구현</h4>
            <p>검증된 기술과 방법론으로 솔루션을 개발하고 구현합니다.</p>
          </div>
          <div class="process-arrow"><i class="fa-solid fa-chevron-right"></i></div>
          <div class="process-step">
            <div class="step-num">04</div>
            <h4>운영 &amp; 지원</h4>
            <p>지속적인 모니터링과 유지보수로 최적의 성과를 유지합니다.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- ===== TEAM ===== -->

    <!-- ===== NEWS ===== -->
    <section id="news" class="news section">
      <div class="container">
        <div class="section-header">
          <div class="section-label">뉴스</div>
          <h2 class="section-title">최신 소식</h2>
          <a href="#" class="section-more">전체 보기 <i class="fa-solid fa-arrow-right"></i></a>
        </div>
        <div class="news-grid">
          <article class="news-card featured-news">
            <div class="news-img-wrap">
              <div class="news-img-placeholder">
                <i class="fa-solid fa-newspaper"></i>
              </div>
              <span class="news-tag">공지사항</span>
            </div>
            <div class="news-body">
              <time class="news-date">2026. 02.</time>
              <h3>회사 설립</h3>
              <p>설명란 향후 기재</p>
              <a href="#" class="news-more">자세히 보기 <i class="fa-solid fa-arrow-right"></i></a>
            </div>
          </article>
          <article class="news-card">
            <div class="news-img-wrap small">
              <div class="news-img-placeholder">
                <i class="fa-solid fa-handshake"></i>
              </div>
              <span class="news-tag">파트너십</span>
            </div>
            <div class="news-body">
              <time class="news-date">2026. 04.</time>
              <h3>파트너십 제목</h3>
              <p>설명란 향후 기재</p>
              <a href="#" class="news-more">자세히 보기 <i class="fa-solid fa-arrow-right"></i></a>
            </div>
          </article>
          <article class="news-card">
            <div class="news-img-wrap small">
              <div class="news-img-placeholder">
                <i class="fa-solid fa-microchip"></i>
              </div>
              <span class="news-tag">기술</span>
            </div>
            <div class="news-body">
              <time class="news-date">2026. 05.</time>
              <h3>업적제목</h3>
              <p>부연설명</p>
              <a href="#" class="news-more">자세히 보기 <i class="fa-solid fa-arrow-right"></i></a>
            </div>
          </article>
        </div>
      </div>
    </section>

    <!-- ===== CONTACT ===== -->
    <section id="contact" class="contact section">
      <div class="container">
        <div class="contact-grid">
          <div class="contact-info">
            <div class="section-label">문의하기</div>
            <h2 class="section-title">함께 시작해 볼까요?</h2>
            <p>비즈니스 문의, 파트너십 제안, 기술 상담 등 어떤 내용이든 편하게 연락해주세요.</p>
            <ul class="contact-details">
              <li>
                <div class="contact-icon"><i class="fa-solid fa-location-dot"></i></div>
                <div>
                  <strong>주소</strong>
                  <span>경기도 화성시 동탄대로 677-12, 효성ICT타워 604호</span>
                </div>
              </li>
              <li>
                <div class="contact-icon"><i class="fa-solid fa-phone"></i></div>
                <div>
                  <strong>전화</strong>
                  <span>070-5100-1580</span>
                </div>
              </li>
              <li>
                <div class="contact-icon"><i class="fa-solid fa-envelope"></i></div>
                <div>
                  <strong>E-MAIL</strong>
                  <span>3rs_vc1@3rsolution.co.kr</span>
                </div>
              </li>
              <li>
                <div class="contact-icon"><i class="fa-solid fa-clock"></i></div>
                <div>
                  <strong>운영시간</strong>
                  <span>평일 09:00 – 18:00 (주말·공휴일 휴무)</span>
                </div>
              </li>
            </ul>
          </div>
          <form class="contact-form" id="contact-form" novalidate>
            <div class="form-row">
              <div class="form-group">
                <label for="name">이름 <span>*</span></label>
                <input type="text" id="name" name="name" placeholder="홍길동" required />
              </div>
              <div class="form-group">
                <label for="company">회사명</label>
                <input type="text" id="company" name="company" placeholder="(주)쓰리알솔루션" />
              </div>
            </div>
            <div class="form-group">
              <label for="email">이메일 <span>*</span></label>
              <input type="email" id="email" name="email" placeholder="example@email.com" required />
            </div>
            <div class="form-group">
              <label for="subject">문의 유형</label>
              <select id="subject" name="subject">
                <option value="">선택해주세요</option>
                <option>IT 솔루션 개발</option>
                <option>AI·데이터 분석</option>
                <option>기타</option>
              </select>
            </div>
            <div class="form-group">
              <label for="message">문의 내용 <span>*</span></label>
              <textarea id="message" name="message" rows="5" placeholder="문의 내용을 자유롭게 작성해 주세요." required></textarea>
            </div>
            <button type="submit" class="btn btn-primary btn-full">
              문의 보내기 <i class="fa-solid fa-paper-plane"></i>
            </button>
            <p class="form-note">* 입력하신 정보는 문의 답변 목적으로만 사용됩니다.</p>
          </form>
        </div>
      </div>
    </section>

    <!-- ===== LOCATION (찾아오시는 길) ===== -->
    <section id="location" class="location section">
      <div class="container">
        <div class="section-header">
          <div class="section-label">찾아오시는 길</div>
          <h2 class="section-title">오시는 방법</h2>
          <p class="section-desc">경기도 화성시 동탄에 위치해 있습니다</p>
        </div>
        <div class="location-grid">
          <!-- 카카오맵 iframe -->
          <div id="mapWrap" class="map-wrap">
            <!-- <iframe
              src="https://map.kakao.com/link/map/효성ICT타워,37.2003073,127.0765632/location"
              width="100%"
              height="100%"
              style="border:0;"
              allowfullscreen=""
              loading="lazy"
              title="쓰리알솔루션 위치"
            ></iframe> -->
          </div>
          <!-- 오시는 방법 안내 -->
          <div class="location-info">
            <div class="location-address-card">
              <div class="loc-icon-wrap"><i class="fa-solid fa-building"></i></div>
              <div>
                <strong>효성 ICT 타워 604호</strong>
                <p>경기도 화성시 동탄대로 677-12</p>
              </div>
            </div>
            <ul class="location-transport">
              <li class="transport-item">
                <div class="transport-icon bus">
                  <i class="fa-solid fa-bus"></i>
                </div>
                <div class="transport-info">
                  <strong>버스 이용 시</strong>
                  <p>동탄역 환승센터 하차 후 도보 10분</p>
                  <p>동탄2신도시 방면 간선버스 이용</p>
                </div>
              </li>
              <li class="transport-item">
                <div class="transport-icon subway">
                  <i class="fa-solid fa-train-subway"></i>
                </div>
                <div class="transport-info">
                  <strong>지하철 이용 시</strong>
                  <p>SRT 동탄역 하차 후 버스 또는 택시 이용</p>
                  <p>동탄역 2번 출구 방면</p>
                </div>
              </li>
              <li class="transport-item">
                <div class="transport-icon car">
                  <i class="fa-solid fa-car"></i>
                </div>
                <div class="transport-info">
                  <strong>자가용 이용 시</strong>
                  <p>동탄IC 진출 후 동탄대로 방면 5분</p>
                  <p>건물 내 주차장 이용 가능</p>
                </div>
              </li>
            </ul>
            <a href="https://map.kakao.com/link/search/경기도 화성시 동탄대로 677-12 효성ICT타워"
               target="_blank"
               rel="noopener noreferrer"
               class="btn btn-primary kakao-map-btn">
              <i class="fa-solid fa-map-location-dot"></i> 카카오맵에서 보기
            </a>
          </div>
        </div>
      </div>
    </section>

  </main>

  <!-- ===== FOOTER ===== -->
  <footer class="footer">
    <div class="container">
      <div class="footer-top">
        <div class="footer-brand">
          <!-- 푸터 좌측 최상단: 아이콘 로고만 -->
          <a href="#" class="footer-logo-link">
            <img src="images/logo/logo-icon.png" alt="3R Solution 아이콘" class="logo-icon-img" />
            <span class="footer-logo-text">쓰리알솔루션</span>
          </a>
          <p>기술과 창의성으로<br />비즈니스의 경계를 넓힙니다.</p>
          <div class="footer-social">
            <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
            <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
            <a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
            <a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
          </div>
        </div>
        <div class="footer-links">
          <div class="footer-col">
            <h4>서비스</h4>
            <ul>
              <li><a href="#">IT 솔루션 개발</a></li>
              <li><a href="#">AI·데이터 분석</a></li>
              <li><a href="#">컨설팅</a></li>
            </ul>
          </div>
          <div class="footer-col">
            <h4>회사</h4>
            <ul>
              <li><a href="#">회사 소개</a></li>
              <li><a href="#">팀 소개</a></li>
              <li><a href="#">채용 정보</a></li>
              <li><a href="#">뉴스</a></li>
              <li><a href="#location">찾아오시는 길</a></li>
            </ul>
          </div>
          <div class="footer-col">
            <h4>고객지원</h4>
            <ul>
              <li><a href="#">FAQ</a></li>
              <li><a href="#">기술 지원</a></li>
              <li><a href="#">이용약관</a></li>
              <li><a href="#">개인정보처리방침</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>© 2026 Three-R Solution Inc. All rights reserved.</p>
        <p>사업자등록번호: 854-86-03728 | 대표: 여혜진</p>
      </div>
    </div>
  </footer>

  <!-- 상단 이동 버튼 -->
  <button class="scroll-top" id="scroll-top" aria-label="맨 위로">
    <i class="fa-solid fa-chevron-up"></i>
  </button>

  <!-- Toast 알림 -->
  <div class="toast" id="toast"></div>
  
  <script src="js/main.js"></script>
  <script src="js/map.js"></script>
  <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=6d0a337557c2852fc1b183c6f80a2ad0&libraries=services&autoload=false"></script>
  <script>
    window.addEventListener('load', function() {
      kakaoMapInit();
    });
  </script>

</body>
</html>
