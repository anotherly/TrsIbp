<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp">
        <jsp:param name="dsTitle" value="DevSync - 사업 상세"/>
    </jsp:include>
</head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>

<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="dsPageTitle" value="사업 상세"/>
    </jsp:include>

    <main class="ds-page">
        <div class="ds-breadcrumb">프로젝트/사업 &gt; 전사 사업 현황판 &gt; 사업 상세</div>
        <div class="ds-page-head">
            <div>
                <h1 class="ds-page-title">사업 상세</h1>
                <p class="ds-page-desc">등록된 사업 기본정보와 사업 단계 업무를 조회합니다.</p>
            </div>
            <div class="ds-actions">
                <a href="${pageContext.request.contextPath}/biz/bizList.do" class="ds-btn ds-btn-outline">목록으로</a>
                <a href="${pageContext.request.contextPath}/biz/bizUpdate.do?bizId=${param.bizId}" class="ds-btn ds-btn-primary">수정</a>
                <button type="button" class="ds-btn ds-btn-danger" onclick="deleteBiz();">삭제</button>
            </div>
        </div>

        <section class="ds-card ds-card-inner ds-mb-20">
            <div class="ds-section-head">
                <div>
                    <h2 class="ds-section-title">사업 기본정보</h2>
                    <p class="ds-section-desc">사업ID 기준 상세 정보입니다.</p>
                </div>
            </div>
            <jsp:include page="/WEB-INF/jsp/biz/bizForm.jsp">
                <jsp:param name="mode" value="detail"/>
                <jsp:param name="bizId" value="${param.bizId}"/>
            </jsp:include>
        </section>

        <section id="taskSection" class="ds-card ds-card-inner">
            <div class="ds-section-head">
                <div>
                    <h2 class="ds-section-title">사업 단계 업무</h2>
                    <p class="ds-section-desc">biz_stp_task에 등록된 업무를 조회합니다.</p>
                </div>
            </div>
            <div class="ds-table-wrap">
                <table class="ds-table">
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>단계코드</th>
                        <th>업무명</th>
                        <th>담당자ID</th>
                        <th>산출물</th>
                    </tr>
                    </thead>
                    <tbody id="bizTaskBody">
                    <tr>
                        <td colspan="5" class="ds-empty">등록된 단계 업무가 없습니다.</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<script>
    var ctxPath = '${pageContext.request.contextPath}';
    var currentBizId = '${param.bizId}';
    var bizPageMode = 'detail';
</script>
<script src="${pageContext.request.contextPath}/js/biz/biz.js"></script>
<script>
    $(function() {
        initBizDetailPage();
    });
</script>
</body>
</html>
