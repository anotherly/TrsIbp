<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사업 상세</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        :root{
            --bg:#07111f;
            --bg2:#0b1730;
            --card:#0d1b31;
            --card2:#101f39;
            --line:rgba(120,150,255,.18);
            --line2:rgba(255,255,255,.08);
            --txt:#f8fbff;
            --sub:#9fb0cf;
            --muted:#7f8ba4;
            --blue:#31b6ff;
            --blue2:#4f7cff;
            --green:#1ed3a6;
            --orange:#ff9b4a;
            --red:#ff6363;
        }

        *{box-sizing:border-box;}
        body{
            margin:0;
            background:
                linear-gradient(rgba(255,255,255,.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,.03) 1px, transparent 1px),
                radial-gradient(circle at top, #122544 0%, #07111f 48%, #050c17 100%);
            background-size:40px 40px, 40px 40px, auto;
            color:var(--txt);
            font-family:"Malgun Gothic","Apple SD Gothic Neo",sans-serif;
        }

        .detail-wrap{
            max-width:1520px;
            margin:0 auto;
            padding:32px 28px 40px;
        }

        .top-row{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:16px;
            margin-bottom:18px;
        }

        .btn-back{
            display:inline-flex;
            align-items:center;
            gap:8px;
            height:42px;
            padding:0 16px;
            border-radius:12px;
            background:rgba(255,255,255,.03);
            border:1px solid var(--line);
            color:#fff;
            text-decoration:none;
            font-weight:700;
        }

        .hero-card{
            background:linear-gradient(180deg, rgba(16,30,54,.96), rgba(11,21,39,.97));
            border:1px solid var(--line);
            border-radius:26px;
            box-shadow:0 14px 30px rgba(0,0,0,.24);
            padding:28px;
            margin-bottom:20px;
        }

        .hero-top{
            display:flex;
            justify-content:space-between;
            align-items:flex-start;
            gap:20px;
            flex-wrap:wrap;
        }

        .hero-title{
            font-size:34px;
            font-weight:800;
            margin:0 0 10px;
            letter-spacing:-1px;
        }

        .hero-sub{
            color:var(--sub);
            font-size:14px;
            margin-bottom:12px;
        }

        .meta-row{
            display:flex;
            flex-wrap:wrap;
            gap:10px;
            margin-bottom:14px;
        }

        .badge{
            display:inline-flex;
            align-items:center;
            border-radius:999px;
            padding:6px 11px;
            font-size:12px;
            font-weight:700;
        }

        .badge-step{
            background:rgba(49,182,255,.12);
            border:1px solid rgba(49,182,255,.25);
            color:#7fd7ff;
        }
        .badge-status{
            background:rgba(30,211,166,.12);
            border:1px solid rgba(30,211,166,.25);
            color:#59e7c0;
        }

        .desc-box{
            color:var(--muted);
            font-size:13px;
            line-height:1.7;
        }

        .summary-inline{
            display:grid;
            grid-template-columns:repeat(4,minmax(0,1fr));
            gap:14px;
            margin-top:22px;
        }

        .mini-card{
            background:rgba(255,255,255,.03);
            border:1px solid var(--line2);
            border-radius:18px;
            padding:18px;
        }

        .mini-card .label{
            color:var(--sub);
            font-size:12px;
            margin-bottom:8px;
            font-weight:700;
        }

        .mini-card .value{
            font-size:28px;
            font-weight:800;
        }

        .mini-card .hint{
            margin-top:6px;
            font-size:12px;
            color:var(--muted);
        }

        .section-card{
            background:linear-gradient(180deg, rgba(14,27,49,.96), rgba(10,20,38,.96));
            border:1px solid var(--line);
            border-radius:24px;
            box-shadow:0 12px 30px rgba(0,0,0,.22);
            padding:22px;
            margin-bottom:18px;
        }

        .section-head{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:14px;
            margin-bottom:14px;
        }

        .section-title{
            margin:0;
            font-size:22px;
            font-weight:800;
        }

        .section-desc{
            color:var(--sub);
            font-size:13px;
            margin-top:4px;
        }

        .chain-row{
            display:flex;
            flex-wrap:wrap;
            align-items:center;
            gap:10px;
        }

        .chain-item{
            min-width:160px;
            padding:14px 16px;
            border-radius:16px;
            border:1px solid var(--line2);
            background:#0a1730;
        }

        .chain-role{
            color:var(--blue);
            font-size:11px;
            font-weight:800;
            margin-bottom:4px;
        }

        .chain-name{
            font-size:15px;
            font-weight:800;
            color:#fff;
        }

        .chain-arrow{
            color:var(--muted);
            font-size:20px;
            font-weight:700;
        }

        .tab-nav{
            display:flex;
            flex-wrap:wrap;
            gap:10px;
            margin-bottom:18px;
        }

        .tab-btn{
            border:none;
            border-radius:14px;
            padding:12px 18px;
            background:rgba(255,255,255,.04);
            color:#dce7ff;
            border:1px solid var(--line2);
            font-weight:800;
            cursor:pointer;
        }

        .tab-btn.active{
            background:linear-gradient(90deg, var(--blue2), var(--blue));
            color:#fff;
            box-shadow:0 0 20px rgba(79,124,255,.24);
        }

        .tab-panel{display:none;}
        .tab-panel.active{display:block;}

        .info-grid{
            display:grid;
            grid-template-columns:repeat(3,minmax(0,1fr));
            gap:16px;
        }

        .info-item{
            border-radius:16px;
            border:1px solid var(--line2);
            background:rgba(255,255,255,.03);
            padding:16px 18px;
        }

        .info-label{
            color:var(--sub);
            font-size:12px;
            font-weight:700;
            margin-bottom:8px;
        }

        .info-value{
            color:#fff;
            font-size:15px;
            font-weight:700;
            line-height:1.5;
            word-break:break-word;
        }

        .tbl{
            width:100%;
            border-collapse:separate;
            border-spacing:0 8px;
        }

        .tbl thead th{
            background:#0c1932;
            color:#dce9ff;
            border-top:1px solid var(--line);
            border-bottom:1px solid var(--line);
            padding:13px 12px;
            font-size:13px;
            font-weight:800;
        }

        .tbl thead th:first-child{
            border-top-left-radius:14px;
            border-bottom-left-radius:14px;
        }
        .tbl thead th:last-child{
            border-top-right-radius:14px;
            border-bottom-right-radius:14px;
        }

        .tbl tbody tr{
            background:rgba(12,25,50,.78);
        }

        .tbl tbody td{
            padding:15px 12px;
            font-size:13px;
            border:none;
            color:#eef5ff;
        }

        .tbl tbody tr td:first-child{
            border-top-left-radius:14px;
            border-bottom-left-radius:14px;
        }
        .tbl tbody tr td:last-child{
            border-top-right-radius:14px;
            border-bottom-right-radius:14px;
        }

        .right{text-align:right;}
        .center{text-align:center;}

        .profit-grid{
            display:grid;
            grid-template-columns:repeat(4,minmax(0,1fr));
            gap:16px;
        }

        .profit-card{
            background:rgba(255,255,255,.03);
            border:1px solid var(--line2);
            border-radius:18px;
            padding:18px;
        }

        .profit-card .label{
            color:var(--sub);
            font-size:12px;
            font-weight:700;
            margin-bottom:10px;
        }

        .profit-card .value{
            font-size:26px;
            font-weight:800;
        }

        .empty-box{
            text-align:center;
            color:var(--muted);
            padding:30px 0 14px;
            font-size:14px;
        }

        @media (max-width:1280px){
            .summary-inline,
            .profit-grid,
            .info-grid{
                grid-template-columns:repeat(2,minmax(0,1fr));
            }
        }

        @media (max-width:768px){
            .detail-wrap{padding:20px 16px 30px;}
            .summary-inline,
            .profit-grid,
            .info-grid{
                grid-template-columns:1fr;
            }
        }
    </style>
</head>
<body>
<div class="detail-wrap">

    <div class="top-row">
        <a href="${pageContext.request.contextPath}/biz/bizList.do" class="btn-back">← 목록으로</a>
    </div>

    <div class="hero-card">
        <div class="hero-top">
            <div>
                <h1 class="hero-title"><c:out value="${bizInfo.bizNm}"/></h1>
                <div class="hero-sub"><c:out value="${bizInfo.dtlBizNm}"/></div>

                <div class="meta-row">
                    <span class="badge badge-step">
                        <c:choose>
                            <c:when test="${bizInfo.bizPrgrsStepCd eq 'PRE'}">사전작업</c:when>
                            <c:when test="${bizInfo.bizPrgrsStepCd eq 'ORDER'}">수주</c:when>
                            <c:when test="${bizInfo.bizPrgrsStepCd eq 'END'}">종료</c:when>
                            <c:when test="${bizInfo.bizPrgrsStepCd eq 'FREE_MAINT'}">무상유지보수</c:when>
                            <c:when test="${bizInfo.bizPrgrsStepCd eq 'PAID_MAINT'}">유상유지보수</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </span>
                    <span class="badge badge-status">
                        <c:choose>
                            <c:when test="${bizInfo.bizSttsCd eq 'READY'}">준비</c:when>
                            <c:when test="${bizInfo.bizSttsCd eq 'PROGRESS'}">진행</c:when>
                            <c:when test="${bizInfo.bizSttsCd eq 'DONE'}">완료</c:when>
                            <c:when test="${bizInfo.bizSttsCd eq 'HOLD'}">보류</c:when>
                            <c:when test="${bizInfo.bizSttsCd eq 'CANCEL'}">취소</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="desc-box">
                    사업기간 : <c:out value="${bizInfo.bizBgngYmd}"/> ~ <c:out value="${bizInfo.bizEndYmd}"/><br/>
                    계약일 : <c:out value="${bizInfo.ctrtYmd}"/><br/>
                    비고 : <c:out value="${empty bizInfo.rmrkCn ? '-' : bizInfo.rmrkCn}"/>
                </div>
            </div>
        </div>

        <div class="summary-inline">
            <div class="mini-card">
                <div class="label">계약금액</div>
                <div class="value"><fmt:formatNumber value="${bizInfo.ctrtAmt}" pattern="#,##0"/></div>
                <div class="hint">VAT 포함 여부 : <c:out value="${bizInfo.vatInclYn eq 'Y' ? '포함' : '미포함'}"/></div>
            </div>
            <div class="mini-card">
                <div class="label">직접비</div>
                <div class="value"><fmt:formatNumber value="${profitSummary.directCostAmt != null ? profitSummary.directCostAmt : 0}" pattern="#,##0"/></div>
                <div class="hint">등록된 사업 직접비 합계</div>
            </div>
            <div class="mini-card">
                <div class="label">인건비</div>
                <div class="value"><fmt:formatNumber value="${profitSummary.laborCostAmt != null ? profitSummary.laborCostAmt : 0}" pattern="#,##0"/></div>
                <div class="hint">투입인력 MM × 단가 기준</div>
            </div>
            <div class="mini-card">
                <div class="label">예상손익</div>
                <div class="value"><fmt:formatNumber value="${profitSummary.profitAmt != null ? profitSummary.profitAmt : 0}" pattern="#,##0"/></div>
                <div class="hint">계약금액 - 직접비 - 인건비</div>
            </div>
        </div>
    </div>

    <div class="section-card">
        <div class="section-head">
            <div>
                <h2 class="section-title">계약 체인 미리보기</h2>
                <div class="section-desc">최종 발주처부터 우리 회사까지의 계약 관계 흐름입니다.</div>
            </div>
        </div>

        <div class="chain-row">
            <c:choose>
                <c:when test="${not empty custRelList}">
                    <c:forEach var="rel" items="${custRelList}" varStatus="st">
                        <div class="chain-item">
                            <div class="chain-role">
                                <c:choose>
                                    <c:when test="${rel.relSeCd eq 'END_USER'}">최종 발주처</c:when>
                                    <c:when test="${rel.relSeCd eq 'PRIME_CTRTR'}">1차 계약자</c:when>
                                    <c:when test="${rel.relSeCd eq 'SUB_CTRTR'}">하도급 ${rel.relLvl - 1}차</c:when>
                                    <c:when test="${rel.relSeCd eq 'OUR_CO'}">우리 회사</c:when>
                                    <c:otherwise>기타 관계사</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="chain-name"><c:out value="${rel.custCoNm}"/></div>
                        </div>
                        <c:if test="${not st.last}">
                            <div class="chain-arrow">→</div>
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-box">등록된 계약관계가 없습니다.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="tab-nav">
        <button type="button" class="tab-btn active" data-target="tab-basic">기본정보</button>
        <button type="button" class="tab-btn" data-target="tab-contract">계약관계</button>
        <button type="button" class="tab-btn" data-target="tab-mnpw">투입인력</button>
        <button type="button" class="tab-btn" data-target="tab-cost">비용</button>
        <button type="button" class="tab-btn" data-target="tab-schdl">일정</button>
        <button type="button" class="tab-btn" data-target="tab-profit">손익요약</button>
    </div>

    <!-- 기본정보 -->
    <div id="tab-basic" class="tab-panel active">
        <div class="section-card">
            <div class="section-head">
                <div>
                    <h2 class="section-title">기본정보</h2>
                    <div class="section-desc">사업의 기본 메타 정보입니다.</div>
                </div>
            </div>

            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">사업명</div>
                    <div class="info-value"><c:out value="${bizInfo.bizNm}"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">약식/상세 사업명</div>
                    <div class="info-value"><c:out value="${bizInfo.dtlBizNm}"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">계약일</div>
                    <div class="info-value"><c:out value="${bizInfo.ctrtYmd}"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">사업 시작일</div>
                    <div class="info-value"><c:out value="${bizInfo.bizBgngYmd}"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">사업 종료일</div>
                    <div class="info-value"><c:out value="${bizInfo.bizEndYmd}"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">계약금액</div>
                    <div class="info-value"><fmt:formatNumber value="${bizInfo.ctrtAmt}" pattern="#,##0"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">사업 진행단계</div>
                    <div class="info-value"><c:out value="${bizInfo.bizPrgrsStepCd}"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">사업 상태</div>
                    <div class="info-value"><c:out value="${bizInfo.bizSttsCd}"/></div>
                </div>
                <div class="info-item">
                    <div class="info-label">비고</div>
                    <div class="info-value"><c:out value="${empty bizInfo.rmrkCn ? '-' : bizInfo.rmrkCn}"/></div>
                </div>
            </div>
        </div>
    </div>

    <!-- 계약관계 -->
    <div id="tab-contract" class="tab-panel">
        <div class="section-card">
            <div class="section-head">
                <div>
                    <h2 class="section-title">계약관계</h2>
                    <div class="section-desc">최종 발주처, 원도급사, 하도급사, 우리 회사까지의 관계 목록입니다.</div>
                </div>
            </div>

            <table class="tbl">
                <thead>
                <tr>
                    <th>순서</th>
                    <th>회사명</th>
                    <th>관계구분</th>
                    <th>단계</th>
                    <th>직접계약 여부</th>
                    <th>우리회사 여부</th>
                    <th>비고</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty custRelList}">
                        <c:forEach var="row" items="${custRelList}" varStatus="st">
                            <tr>
                                <td class="center">${st.count}</td>
                                <td><c:out value="${row.custCoNm}"/></td>
                                <td><c:out value="${row.relSeCd}"/></td>
                                <td class="center"><c:out value="${row.relLvl}"/></td>
                                <td class="center"><c:out value="${row.directCtrtYn}"/></td>
                                <td class="center"><c:out value="${row.ourCoYn}"/></td>
                                <td><c:out value="${empty row.rmrkCn ? '-' : row.rmrkCn}"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="7"><div class="empty-box">등록된 계약관계 데이터가 없습니다.</div></td></tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 투입인력 -->
    <div id="tab-mnpw" class="tab-panel">
        <div class="section-card">
            <div class="section-head">
                <div>
                    <h2 class="section-title">투입인력</h2>
                    <div class="section-desc">사업에 투입된 인력, 역할, MM, 단가를 관리합니다.</div>
                </div>
            </div>

            <table class="tbl">
                <thead>
                <tr>
                    <th>인력명</th>
                    <th>단계</th>
                    <th>역할</th>
                    <th>투입기간</th>
                    <th>MM</th>
                    <th>단가</th>
                    <th>인건비</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty mnpwList}">
                        <c:forEach var="row" items="${mnpwList}">
                            <tr>
                                <td><c:out value="${row.inputMnpwNm}"/></td>
                                <td><c:out value="${row.bizPrgrsStepCd}"/></td>
                                <td><c:out value="${row.roleNm}"/></td>
                                <td><c:out value="${row.inputBgngYmd}"/> ~ <c:out value="${row.inputEndYmd}"/></td>
                                <td class="right"><fmt:formatNumber value="${row.inputMcnt}" pattern="#,##0.##"/></td>
                                <td class="right"><fmt:formatNumber value="${row.untprc}" pattern="#,##0"/></td>
                                <td class="right"><fmt:formatNumber value="${row.mnpwAmt}" pattern="#,##0"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="7"><div class="empty-box">등록된 투입인력 데이터가 없습니다.</div></td></tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 비용 -->
    <div id="tab-cost" class="tab-panel">
        <div class="section-card">
            <div class="section-head">
                <div>
                    <h2 class="section-title">비용</h2>
                    <div class="section-desc">직접비, 출장비, 숙박비, 식대 등 사업 관련 비용 내역입니다.</div>
                </div>
            </div>

            <table class="tbl">
                <thead>
                <tr>
                    <th>비용구분</th>
                    <th>비용명</th>
                    <th>발생일자</th>
                    <th>금액</th>
                    <th>비고</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty cstList}">
                        <c:forEach var="row" items="${cstList}">
                            <tr>
                                <td><c:out value="${row.cstSeCd}"/></td>
                                <td><c:out value="${row.cstNm}"/></td>
                                <td><c:out value="${row.ocrnYmd}"/></td>
                                <td class="right"><fmt:formatNumber value="${row.ocrnCst}" pattern="#,##0"/></td>
                                <td><c:out value="${empty row.rmrkCn ? '-' : row.rmrkCn}"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="5"><div class="empty-box">등록된 비용 데이터가 없습니다.</div></td></tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 일정 -->
    <div id="tab-schdl" class="tab-panel">
        <div class="section-card">
            <div class="section-head">
                <div>
                    <h2 class="section-title">일정</h2>
                    <div class="section-desc">사전작업, 지원, 정기유지보수, 장애대응 등의 사업 일정입니다.</div>
                </div>
            </div>

            <table class="tbl">
                <thead>
                <tr>
                    <th>일정명</th>
                    <th>일정구분</th>
                    <th>기간</th>
                    <th>담당자</th>
                    <th>비고</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty schdlList}">
                        <c:forEach var="row" items="${schdlList}">
                            <tr>
                                <td><c:out value="${row.schdlNm}"/></td>
                                <td><c:out value="${row.schdlSeCd}"/></td>
                                <td><c:out value="${row.schdlBgngYmd}"/> ~ <c:out value="${row.schdlEndYmd}"/></td>
                                <td><c:out value="${row.picId}"/></td>
                                <td><c:out value="${empty row.rmrkCn ? '-' : row.rmrkCn}"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="5"><div class="empty-box">등록된 일정 데이터가 없습니다.</div></td></tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 손익 -->
    <div id="tab-profit" class="tab-panel">
        <div class="section-card">
            <div class="section-head">
                <div>
                    <h2 class="section-title">손익요약</h2>
                    <div class="section-desc">사업의 계약금액, 직접비, 인건비, 예상손익을 요약합니다.</div>
                </div>
            </div>

            <div class="profit-grid">
                <div class="profit-card">
                    <div class="label">계약금액</div>
                    <div class="value"><fmt:formatNumber value="${bizInfo.ctrtAmt}" pattern="#,##0"/></div>
                </div>
                <div class="profit-card">
                    <div class="label">직접비 합계</div>
                    <div class="value"><fmt:formatNumber value="${profitSummary.directCostAmt != null ? profitSummary.directCostAmt : 0}" pattern="#,##0"/></div>
                </div>
                <div class="profit-card">
                    <div class="label">인건비 합계</div>
                    <div class="value"><fmt:formatNumber value="${profitSummary.laborCostAmt != null ? profitSummary.laborCostAmt : 0}" pattern="#,##0"/></div>
                </div>
                <div class="profit-card">
                    <div class="label">예상손익</div>
                    <div class="value"><fmt:formatNumber value="${profitSummary.profitAmt != null ? profitSummary.profitAmt : 0}" pattern="#,##0"/></div>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="${pageContext.request.contextPath}/js/biz/biz.js"></script>
<script>
    $(function(){
        initBizDetailTabs();
    });
</script>
</body>
</html>