package kr.co.TRSolution.trsHome.comm.util;

import java.util.*;
import java.util.regex.Pattern;

import org.springframework.web.multipart.MultipartFile;

public final class UploadPolicy {

    // 업무상 허용 확장자만 남기세요.
    private static final Set<String> ALLOWED_EXT = new HashSet<>(Arrays.asList(
        "pdf","hwp","hwpx","doc","docx","xls","xlsx","ppt","pptx","txt",
        "jpg","jpeg","png","gif","zip"
    ));

    // 원본 파일명에 경로/이상문자 섞이는 것 방지(Windows/Unix 공통)
    private static final Pattern BAD_CHARS = Pattern.compile("[\\\\/\\r\\n\\t\\u0000]");

    private UploadPolicy() {}

    public static String extractSafeExt(String originalFilename) {
        if (originalFilename == null) return "";
        String onlyName = originalFilename;
        // IE/옛 브라우저가 "C:\fakepath\..." 형태로 보낼 수 있어 마지막만 취함
        int slash = Math.max(onlyName.lastIndexOf('/'), onlyName.lastIndexOf('\\'));
        if (slash >= 0) onlyName = onlyName.substring(slash + 1);

        onlyName = BAD_CHARS.matcher(onlyName).replaceAll("");
        int dot = onlyName.lastIndexOf('.');
        if (dot < 0) return "";
        return onlyName.substring(dot + 1).toLowerCase(Locale.ROOT);
    }

    public static void validate(MultipartFile f) {

        String ext = extractSafeExt(f.getOriginalFilename());
        if (!ALLOWED_EXT.contains(ext)) {
            throw new IllegalArgumentException("허용되지 않는 파일 확장자입니다. (" + ext + ")");
        }

        // 필요 시 용량 제한(중복 방지 차원)
        long max = 10_000_000L; // 10MB (현재 설정과 동일)
        if (f.getSize() > max) {
            throw new IllegalArgumentException("파일 용량이 허용치를 초과했습니다.");
        }
    }
}