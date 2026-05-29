<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevSync - 서비스 도입 문의 및 신청</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body class="bg-[#0b0f19] text-[#f3f4f6] min-h-screen flex items-center justify-center p-4">

    <div class="bg-[#111827] border border-[#1f2937] rounded-2xl w-full max-w-lg p-8 shadow-2xl relative">
        <div class="text-center mb-6">
            <h3 class="text-xl font-bold text-white mb-2">
                <i class="fa-solid fa-building-circle-check text-blue-500 mr-2"></i>DevSync 도입 신청하기
            </h3>
            <p class="text-xs text-gray-400">정보를 입력해주시면 시스템 관리자 검토 후 최고관리자 계정을 발급해 드립니다.</p>
        </div>
        
        <!-- 파일 업로드를 위한 multipart/form-data 필수 지정 -->
        <form id="requestForm" method="POST" enctype="multipart/form-data" class="space-y-4">
            
            <!-- 회사명 -->
            <div>
                <label class="block text-xs font-bold text-gray-400 mb-1.5">회사명 <span class="text-red-500">*</span></label>
                <input type="text" name="companyName" required class="w-full bg-slate-900 border border-[#1f2937] text-sm rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-blue-500 transition" placeholder="예: (주)티알솔루션">
            </div>

            <!-- 사업자등록번호 -->
            <div>
                <label class="block text-xs font-bold text-gray-400 mb-1.5">사업자등록번호 <span class="text-red-500">*</span></label>
                <input type="text" name="bizNo" required class="w-full bg-slate-900 border border-[#1f2937] text-sm rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-blue-500 transition" placeholder="하이픈(-)을 제외하고 입력">
            </div>

            <!-- 대표자명 / 신청자명 -->
            <div>
                <label class="block text-xs font-bold text-gray-400 mb-1.5">신청자명 <span class="text-red-500">*</span></label>
                <input type="text" name="contactName" required class="w-full bg-slate-900 border border-[#1f2937] text-sm rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-blue-500 transition" placeholder="홍길동">
            </div>
            <div>
                <label class="block text-xs font-bold text-gray-400 mb-1.5">대표성함 <span class="text-red-500">*</span></label>
                <input type="text" name="representativeName" required class="w-full bg-slate-900 border border-[#1f2937] text-sm rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-blue-500 transition" placeholder="홍길동">
            </div>

            <!-- 담당자 연락처 -->
            <div>
                <label class="block text-xs font-bold text-gray-400 mb-1.5">신청자 연락처 <span class="text-red-500">*</span></label>
                <input type="tel" name="contactTel" required class="w-full bg-slate-900 border border-[#1f2937] text-sm rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-blue-500 transition" placeholder="예: 01012345678">
            </div>

            <!-- 담당자 이메일 -->
            <div>
                <label class="block text-xs font-bold text-gray-400 mb-1.5">담당자 이메일 <span class="text-red-500">*</span></label>
                <input type="email" name="contactEmail" required class="w-full bg-slate-900 border border border-[#1f2937] text-sm rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-blue-500 transition" placeholder="name@company.com">
            </div>

            <!-- 사업자등록증 파일 첨부 -->
            <div>
                <label class="block text-xs font-bold text-gray-400 mb-1.5">사업자등록증 첨부 <span class="text-red-500">*</span></label>
                <input type="file" name="bizFile" id="bizFile" required class="w-full bg-slate-900 border border-[#1f2937] text-xs rounded-lg p-2 text-gray-400 file:mr-4 file:py-1 file:px-3 file:rounded-md file:border-0 file:text-xs file:font-semibold file:bg-blue-500 file:text-white hover:file:bg-blue-600 transition">
                <p class="text-[10px] text-gray-500 mt-1">* pdf, png, jpg, jpeg 파일만 허용 (최대 10MB)</p>
            </div>

            <!-- 제출 버튼 -->
            <button type="button" onclick="submitRequest()" class="w-full mt-2 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-xl text-sm font-bold shadow-lg shadow-blue-500/20 transition flex items-center justify-center gap-2">
                <i class="fa-solid fa-paper-plane"></i> 도입 신청서 제출하기
            </button>
        </form>
    </div>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        var ctxPath = '<%=request.getContextPath()%>';

        function submitRequest() {
            // 간단한 유효성 검증
            var form = $('#requestForm')[0];
            if (!form.checkValidity()) {
                form.reportValidity();
                return;
            }

            // 파일 확장자 및 용량 자바스크립트 1차 보안 체크
            var fileInput = $('#bizFile')[0];
            if (fileInput.files.length > 0) {
                var file = fileInput.files[0];
                var ext = file.name.split('.').pop().toLowerCase();
                var allowExt = ['pdf', 'png', 'jpg', 'jpeg'];
                
                if ($.inArray(ext, allowExt) == -1) {
                    alert('허용되지 않는 파일 확장자입니다. (pdf, png, jpg, jpeg만 가능)');
                    return;
                }
                if (file.size > 10 * 1024 * 1024) { // 10MB 제한
                    alert('첨부파일 용량은 10MB를 초과할 수 없습니다.');
                    return;
                }
            }

            // Multipart 데이터 전송을 위한 FormData 객체 생성
            var formData = new FormData(form);

            $.ajax({
                url: ctxPath + '/company/request/requestInsert.ajax',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                dataType: 'json',
                success: function(data) {
                    if (data.result === 'OK') {
                        alert('도입 신청이 정상적으로 접수되었습니다. 관리자 검토 후 이메일로 회신해 드립니다.');
                        window.location.href = ctxPath + '/user/login.do';
                    } else {
                        alert(data.msg || '신청 중 오류가 발생했습니다.');
                    }
                },
                error: function() {
                    alert('서버 통신 중 오류가 발생했습니다.');
                }
            });
        }
    </script>
</body>
</html>