<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사업 현황</title>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/jquery.dataTables.min.css"/>
    <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>

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

        .biz-wrap{
            max-width: 1520px;
            margin: 0 auto;
            padding: 32px 28px 40px;
        }

        .breadcrumb{
            color: var(--muted);
            font-size: 13px;
            margin-bottom: 10px;
        }

        .page-head{
            display:flex;
            justify-content:space-between;
            align-items:flex-end;
            gap:16px;
            margin-bottom:24px;
        }

        .page-title{
            font-size: 38px;
            font-weight: 800;
            margin:0 0 8px;
            letter-spacing:-1px;
        }

        .page-desc{
            color:var(--sub);
            font-size:14px;
            margin:0;
        }

        .head-actions{
            display:flex;
            gap:10px;
            flex-wrap:wrap;
        }

        .btn{
            border:none;
            border-radius:14px;
            padding:12px 18px;
            font-size:14px;
            font-weight:700;
            cursor:pointer;
            transition:.2s ease;
        }
        .btn-primary{
            background:linear-gradient(90deg, var(--blue2), var(--blue));
            color:#fff;
            box-shadow:0 0 20px rgba(79,124,255,.25);
        }
        .btn-primary:hover{filter:brightness(1.08);}
        .btn-outline{
            background:rgba(255,255,255,.03);
            color:#d9e8ff;
            border:1px solid var(--line);
        }
        .btn-outline:hover{
            background:rgba(255,255,255,.06);
        }

        .summary-grid{
            display:grid;
            grid-template-columns:repeat(4,minmax(0,1fr));
            gap:16px;
            margin-bottom:20px;
        }

        .summary-card{
            background:linear-gradient(180deg, rgba(18,34,62,.94), rgba(11,21,39,.95));
            border:1px solid var(--line);
            border-radius:22px;
            padding:22px 22px 18px;
            box-shadow:0 12px 28px rgba(0,0,0,.22);
        }

        .summary-card .label{
            color:var(--sub);
            font-size:13px;
            margin-bottom:12px;
            font-weight:600;
        }

        .summary-card .value{
            font-size:34px;
            font-weight:800;
            margin-bottom:8px;
        }

        .summary-card .subtext{
            color:var(--muted);
            font-size:13px;
        }

        .card{
            background:linear-gradient(180deg, rgba(14,27,49,.96), rgba(10,20,38,.96));
            border:1px solid var(--line);
            border-radius:24px;
            box-shadow:0 12px 30px rgba(0,0,0,.22);
        }

        .filter-card{
            padding:22px;
            margin-bottom:20px;
        }

        .card-title-row{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:16px;
            margin-bottom:18px;
        }

        .card-title{
            font-size:21px;
            font-weight:800;
            margin:0;
        }

        .card-desc{
            color:var(--sub);
            font-size:13px;
            margin-top:4px;
        }

        .filter-grid{
            display:grid;
            grid-template-columns: 180px 180px 1fr 160px 160px auto auto;
            gap:12px;
            align-items:end;
        }

        .field label{
            display:block;
            font-size:12px;
            font-weight:700;
            color:var(--sub);
            margin-bottom:7px;
        }

        .field input,
        .field select{
            width:100%;
            height:44px;
            border-radius:12px;
            border:1px solid var(--line2);
            background:#0a1730;
            color:#fff;
            padding:0 14px;
            outline:none;
        }

        .table-card{
            padding:18px 18px 20px;
        }

        .table-head{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:12px;
            margin-bottom:14px;
        }

        .table-title{
            font-size:20px;
            font-weight:800;
            margin:0;
        }

        .table-meta{
            color:var(--muted);
            font-size:13px;
        }

        .badge{
            display:inline-flex;
            align-items:center;
            border-radius:999px;
            padding:5px 10px;
            font-size:12px;
            font-weight:700;
            white-space:nowrap;
        }
        .badge-step{
            background:rgba(49,182,255,.12);
            border:1px solid rgba(49,182,255,.25);
            color:#7fd7ff;
        }
        .badge-status-progress{
            background:rgba(30,211,166,.12);
            border:1px solid rgba(30,211,166,.25);
            color:#59e7c0;
        }
        .badge-status-ready{
            background:rgba(255,155,74,.12);
            border:1px solid rgba(255,155,74,.25);
            color:#ffc089;
        }
        .badge-status-done{
            background:rgba(79,124,255,.12);
            border:1px solid rgba(79,124,255,.25);
            color:#a9c2ff;
        }
        .badge-status-hold{
            background:rgba(255,208,0,.12);
            border:1px solid rgba(255,208,0,.25);
            color:#ffe075;
        }
        .badge-status-cancel{
            background:rgba(255,99,99,.12);
            border:1px solid rgba(255,99,99,.25);
            color:#ff9a9a;
        }

        table.dataTable{
            width:100% !important;
            border-collapse:separate !important;
            border-spacing:0 8px !important;
            background:transparent !important;
            color:#fff;
            margin-top:0 !important;
        }

        table.dataTable thead th{
            background:#0c1932 !important;
            color:#dce9ff !important;
            border:none !important;
            padding:14px 12px !important;
            font-size:13px !important;
            font-weight:800 !important;
            border-top:1px solid var(--line) !important;
            border-bottom:1px solid var(--line) !important;
        }
        table.dataTable thead th:first-child{
            border-top-left-radius:14px;
            border-bottom-left-radius:14px;
        }
        table.dataTable thead th:last-child{
            border-top-right-radius:14px;
            border-bottom-right-radius:14px;
        }

        table.dataTable tbody tr{
            background:rgba(12,25,50,.78) !important;
            box-shadow:0 8px 18px rgba(0,0,0,.16);
        }

        table.dataTable tbody td{
            border:none !important;
            padding:16px 12px !important;
            vertical-align:middle;
            font-size:13px;
            color:#eef5ff;
        }

        table.dataTable tbody tr td:first-child{
            border-top-left-radius:14px;
            border-bottom-left-radius:14px;
        }
        table.dataTable tbody tr td:last-child{
            border-top-right-radius:14px;
            border-bottom-right-radius:14px;
        }

        .biz-name{
            font-size:15px;
            font-weight:800;
            color:#fff;
            margin-bottom:4px;
        }

        .biz-sub{
            color:var(--muted);
            font-size:12px;
        }

        .money{
            font-weight:800;
            text-align:right;
            white-space:nowrap;
        }

        .profit-plus{ color:#63e0b7; }
        .profit-minus{ color:#ff8e8e; }

        .tbl-btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            height:36px;
            padding:0 14px;
            border-radius:10px;
            border:1px solid var(--line);
            color:#fff;
            background:rgba(255,255,255,.04);
            text-decoration:none;
            font-size:12px;
            font-weight:700;
        }

        .tbl-btn:hover{
            background:rgba(255,255,255,.07);
        }

        .dataTables_wrapper .dataTables_info,
        .dataTables_wrapper .dataTables_length,
        .dataTables_wrapper .dataTables_filter{
            color:var(--sub) !important;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button{
            color:#cfe1ff !important;
            border:none !important;
            background:transparent !important;
            border-radius:10px !important;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button.current{
            background:linear-gradient(90deg, var(--blue2), var(--blue)) !important;
            color:#fff !important;
        }

        .empty-box{
            text-align:center;
            color:var(--muted);
            padding:40px 0 20px;
            font-size:14px;
        }

        @media (max-width: 1280px){
            .summary-grid{grid-template-columns:repeat(2,minmax(0,1fr));}
            .filter-grid{grid-template-columns:repeat(2,minmax(0,1fr));}
        }

        @media (max-width: 768px){
            .biz-wrap{padding:20px 16px 30px;}
            .page-head{flex-direction:column; align-items:flex-start;}
            .summary-grid{grid-template-columns:1fr;}
            .filter-grid{grid-template-columns:1fr;}
        }
    </style>
</head>
<body>
<div class="biz-wrap">

    <div class="breadcrumb">프로젝트/사업 &gt; 전사 사업 현황판 &gt; 사업 현황</div>

    <div class="page-head">
        <div>
            <h1 class="page-title">사업 현황</h1>
            <p class="page-desc">전체 사업의 진행단계, 상태, 손익 개요를 한눈에 확인하고 상세 화면으로 이동할 수 있습니다.</p>
        </div>
        <div class="head-actions">
            <button type="button" class="btn btn-outline" onclick="location.href='<%=request.getContextPath()%>/'">메인 페이지로</button>
            <button type="button" class="btn btn-outline" onclick="resetSearchForm();">검색 초기화</button>
            <button type="button" class="btn btn-primary" onclick="goBizRegist();">+ 사업 등록</button>
        </div>
    </div>

    <div class="summary-grid">
        <div class="summary-card">
            <div class="label">전체 사업 수</div>
            <div class="value"><c:out value="${summary.totalCnt != null ? summary.totalCnt : 0}"/></div>
            <div class="subtext">등록된 전체 사업 건수</div>
        </div>
        <div class="summary-card">
            <div class="label">진행 중 사업</div>
            <div class="value"><c:out value="${summary.progressCnt != null ? summary.progressCnt : 0}"/></div>
            <div class="subtext">현재 수행 중인 사업</div>
        </div>
        <div class="summary-card">
            <div class="label">유지보수 단계 사업</div>
            <div class="value"><c:out value="${summary.maintCnt != null ? summary.maintCnt : 0}"/></div>
            <div class="subtext">무상/유상 유지보수 단계 합계</div>
        </div>
        <div class="summary-card">
            <div class="label">예상 손익 합계</div>
            <div class="value">
                <fmt:formatNumber value="${summary.totalProfitAmt != null ? summary.totalProfitAmt : 0}" pattern="#,##0"/>
            </div>
            <div class="subtext">전체 사업 기준 예상 손익</div>
        </div>
    </div>

    <div class="card filter-card">
        <div class="card-title-row">
            <div>
                <h2 class="card-title">검색 / 필터</h2>
                <div class="card-desc">사업 진행단계, 상태, 기간, 사업명 키워드로 빠르게 조회하십시오.</div>
            </div>
        </div>

        <form id="searchForm" method="get" action="${pageContext.request.contextPath}/biz/bizList.do">
            <div class="filter-grid">
                <div class="field">
                    <label for="searchBizPrgrsStepCd">진행단계</label>
                    <select id="searchBizPrgrsStepCd" name="searchBizPrgrsStepCd">
                        <option value="">전체</option>
                        <option value="PRE" ${bizVO.searchBizPrgrsStepCd eq 'PRE' ? 'selected' : ''}>사전작업</option>
                        <option value="ORDER" ${bizVO.searchBizPrgrsStepCd eq 'ORDER' ? 'selected' : ''}>수주</option>
                        <option value="END" ${bizVO.searchBizPrgrsStepCd eq 'END' ? 'selected' : ''}>종료</option>
                        <option value="FREE_MAINT" ${bizVO.searchBizPrgrsStepCd eq 'FREE_MAINT' ? 'selected' : ''}>무상유지보수</option>
                        <option value="PAID_MAINT" ${bizVO.searchBizPrgrsStepCd eq 'PAID_MAINT' ? 'selected' : ''}>유상유지보수</option>
                    </select>
                </div>

                <div class="field">
                    <label for="searchBizSttsCd">상태</label>
                    <select id="searchBizSttsCd" name="searchBizSttsCd">
                        <option value="">전체</option>
                        <option value="READY" ${bizVO.searchBizSttsCd eq 'READY' ? 'selected' : ''}>준비</option>
                        <option value="PROGRESS" ${bizVO.searchBizSttsCd eq 'PROGRESS' ? 'selected' : ''}>진행</option>
                        <option value="DONE" ${bizVO.searchBizSttsCd eq 'DONE' ? 'selected' : ''}>완료</option>
                        <option value="HOLD" ${bizVO.searchBizSttsCd eq 'HOLD' ? 'selected' : ''}>보류</option>
                        <option value="CANCEL" ${bizVO.searchBizSttsCd eq 'CANCEL' ? 'selected' : ''}>취소</option>
                    </select>
                </div>

                <div class="field">
                    <label for="searchKeyword">사업명 / 고객사 / 약식사업명</label>
                    <input type="text" id="searchKeyword" name="searchKeyword" value="${bizVO.searchKeyword}" placeholder="예: 서울교통공사 유지보수, 통합관제, 코레일"/>
                </div>

                <div class="field">
                    <label for="startYmd">시작일</label>
                    <input type="date" id="startYmd" name="startYmd" value="${bizVO.startYmd}"/>
                </div>

                <div class="field">
                    <label for="endYmd">종료일</label>
                    <input type="date" id="endYmd" name="endYmd" value="${bizVO.endYmd}"/>
                </div>

                <div>
                    <button type="submit" class="btn btn-primary" style="width:100%;">검색</button>
                </div>

                <div>
                    <button type="button" class="btn btn-outline" style="width:100%;" onclick="resetSearchForm();">초기화</button>
                </div>
            </div>
        </form>
    </div>

    <div class="card table-card">
        <div class="table-head">
            <div>
                <h2 class="table-title">사업 목록</h2>
                <div class="table-meta">사업명 클릭 또는 상세 버튼으로 상세 화면에 진입할 수 있습니다.</div>
            </div>
        </div>

        <table id="bizTable" class="display">
            <thead>
            <tr>
                <th>번호</th>
                <th>사업명</th>
                <th>진행단계</th>
                <th>상태</th>
                <th>사업기간</th>
                <th>계약금액</th>
                <th>직접비</th>
                <th>인건비</th>
                <th>예상손익</th>
                <th>상세</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty bizList}">
                    <c:forEach var="row" items="${bizList}" varStatus="st">
                        <tr>
                            <td>${st.count}</td>
                            <td>
                                <div class="biz-name">
                                    <a href="${pageContext.request.contextPath}/biz/bizDetail.do?bizSn=${row.bizSn}" style="color:#fff;text-decoration:none;">
                                        <c:out value="${row.bizNm}"/>
                                    </a>
                                </div>
                                <div class="biz-sub">
                                    <c:out value="${row.dtlBizNm}"/>
                                </div>
                            </td>
                            <td>
                                <span class="badge badge-step">
                                    <c:choose>
                                        <c:when test="${row.bizPrgrsStepCd eq 'PRE'}">사전작업</c:when>
                                        <c:when test="${row.bizPrgrsStepCd eq 'ORDER'}">수주</c:when>
                                        <c:when test="${row.bizPrgrsStepCd eq 'END'}">종료</c:when>
                                        <c:when test="${row.bizPrgrsStepCd eq 'FREE_MAINT'}">무상유지보수</c:when>
                                        <c:when test="${row.bizPrgrsStepCd eq 'PAID_MAINT'}">유상유지보수</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td>
                                <span class="badge
                                    <c:choose>
                                        <c:when test='${row.bizSttsCd eq "READY"}'>badge-status-ready</c:when>
                                        <c:when test='${row.bizSttsCd eq "PROGRESS"}'>badge-status-progress</c:when>
                                        <c:when test='${row.bizSttsCd eq "DONE"}'>badge-status-done</c:when>
                                        <c:when test='${row.bizSttsCd eq "HOLD"}'>badge-status-hold</c:when>
                                        <c:when test='${row.bizSttsCd eq "CANCEL"}'>badge-status-cancel</c:when>
                                        <c:otherwise>badge-status-ready</c:otherwise>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${row.bizSttsCd eq 'READY'}">준비</c:when>
                                        <c:when test="${row.bizSttsCd eq 'PROGRESS'}">진행</c:when>
                                        <c:when test="${row.bizSttsCd eq 'DONE'}">완료</c:when>
                                        <c:when test="${row.bizSttsCd eq 'HOLD'}">보류</c:when>
                                        <c:when test="${row.bizSttsCd eq 'CANCEL'}">취소</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td>
                                <c:out value="${row.bizBgngYmd}"/> ~ <c:out value="${row.bizEndYmd}"/>
                            </td>
                            <td class="money">
                                <fmt:formatNumber value="${row.ctrtAmt}" pattern="#,##0"/>
                            </td>
                            <td class="money">
                                <fmt:formatNumber value="${row.directCostAmt != null ? row.directCostAmt : 0}" pattern="#,##0"/>
                            </td>
                            <td class="money">
                                <fmt:formatNumber value="${row.laborCostAmt != null ? row.laborCostAmt : 0}" pattern="#,##0"/>
                            </td>
                            <td class="money ${row.profitAmt ge 0 ? 'profit-plus' : 'profit-minus'}">
                                <fmt:formatNumber value="${row.profitAmt != null ? row.profitAmt : 0}" pattern="#,##0"/>
                            </td>
                            <td>
                                <a class="tbl-btn" href="${pageContext.request.contextPath}/biz/bizDetail.do?bizSn=${row.bizSn}">상세보기</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="10">
                            <div class="empty-box">조회된 사업 데이터가 없습니다.</div>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
        
        <div class="head-actions">
            <button type="button" class="btn btn-primary" style="width:100%;"  onclick="location.href='<%=request.getContextPath()%>/biz/bizDetail.do'" >사업 상세 화면으로</button>
            <%-- <a href="<%=request.getContextPath()%>/biz/bizDetail.do" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">사업 상세 화면으로</a> --%>
        </div>
        
    </div>

</div>

<script src="${pageContext.request.contextPath}/js/biz/biz.js"></script>
<script>
    $(function(){
        initBizListTable();
    });

    function goBizRegist(){
        location.href = '${pageContext.request.contextPath}/biz/bizRegist.do';
    }

    function resetSearchForm(){
        $('#searchBizPrgrsStepCd').val('');
        $('#searchBizSttsCd').val('');
        $('#searchKeyword').val('');
        $('#startYmd').val('');
        $('#endYmd').val('');
    }
</script>
</body>
</html>