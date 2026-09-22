package kr.co.TRSolution.trsIbp.comm;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.TRSolution.trsIbp.audit.mapper.UserActionLogMapper;
import kr.co.TRSolution.trsIbp.audit.vo.UserActionLogVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

/**
 * 일반 사용자 사이트의 등록/수정/삭제 작업만 기록한다.
 * 조회 요청은 기록하지 않는다.
 * 수정 작업은 요청 전체가 아니라 실제 변경된 항목만 "기존값 → 변경값" 형식으로 남긴다.
 */
public class UserActionLogInterceptor extends HandlerInterceptorAdapter {

    private static final String ATTR_BEFORE = UserActionLogInterceptor.class.getName() + ".BEFORE";
    private static final String ATTR_AUTH_OLD = UserActionLogInterceptor.class.getName() + ".AUTH_OLD";
    private static final String ATTR_AUTH_CATALOG = UserActionLogInterceptor.class.getName() + ".AUTH_CATALOG";

    @Resource(name="userActionLogMapper")
    private UserActionLogMapper mapper;

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
        HttpSession session = req.getSession(false);
        if (session == null) return true;
        UserVO u = (UserVO) session.getAttribute("login");
        if (u == null) return true;

        String uri = uri(req);
        String action = action(uri, req);
        if (!"MDFCN".equals(action) && !"DEL".equals(action)) return true;

        try {
            if (uri.endsWith("/expense/expenseSave.ajax") || uri.endsWith("/expense/expenseDelete.ajax")) {
                String claimSn = req.getParameter("claimSn");
                if (!isBlank(claimSn) && !"0".equals(claimSn)) {
                    Map<String,Object> p = new HashMap<String,Object>();
                    p.put("coId", u.getCoId());
                    p.put("claimSn", claimSn);
                    req.setAttribute(ATTR_BEFORE, mapper.selectExpenseSnapshot(p));
                }
            } else if (uri.endsWith("/worklog/dailySave.ajax") || uri.endsWith("/worklog/dailyDelete.ajax")) {
                String workItemSn = req.getParameter("workItemSn");
                if (!isBlank(workItemSn) && !"0".equals(workItemSn)) {
                    Map<String,Object> p = new HashMap<String,Object>();
                    p.put("coId", u.getCoId());
                    p.put("userId", u.getUserId());
                    p.put("workItemSn", workItemSn);
                    p.put("workYmd", req.getParameter("workYmd"));
                    req.setAttribute(ATTR_BEFORE, mapper.selectWorklogSnapshot(p));
                }
            } else if (uri.endsWith("/authority/authoritySave.ajax")) {
                Map<String,Object> p = new HashMap<String,Object>();
                p.put("coId", u.getCoId());
                p.put("authrtId", req.getParameter("authrtId"));
                req.setAttribute(ATTR_AUTH_OLD, mapper.selectAuthorityGrantedMenuSnList(p));
                req.setAttribute(ATTR_AUTH_CATALOG, mapper.selectAuthorityMenuCatalog());
            }
        } catch (Exception ignore) {
            // 스냅샷 조회 실패가 실제 업무 요청을 막지 않도록 한다.
        }
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, Exception ex) throws Exception {
        if (ex != null || res.getStatus() >= 400) return;

        HttpSession session = req.getSession(false);
        if (session == null) return;
        UserVO u = (UserVO) session.getAttribute("login");
        if (u == null) return;

        String uri = uri(req);
        String action = action(uri, req);
        if (action == null) return;

        try {
            UserActionLogVO v = new UserActionLogVO();
            v.setCoId(u.getCoId());
            v.setUserId(u.getUserId());
            v.setActionSeCd(action);
            v.setMenuNm(menu(uri));
            v.setTargetId(target(uri, req));
            v.setRequestUri(uri); // DB 추적용으로만 유지. 관리자 목록에는 표시하지 않는다.
            v.setClientIpAddr(ip(req));
            v.setActionCn(actionContent(uri, req, action));
            mapper.insertUserActionLog(v);
        } catch (Exception ignore) {
            // 작업이력 저장 실패가 실제 업무 요청을 실패시키지 않도록 한다.
        }
    }

    private String uri(HttpServletRequest req) {
        return req.getRequestURI().substring(req.getContextPath().length());
    }

    private String action(String uri, HttpServletRequest r) {
        String l = uri.toLowerCase();
        if (l.endsWith("/authority/authoritysave.ajax")) return "MDFCN";
        if (l.contains("delete")) return "DEL";
        if (l.contains("insert")) return "REG";
        if (l.contains("update")) return "MDFCN";
        if (l.contains("save")) {
            String mode = r.getParameter("saveMode");
            if ("insert".equalsIgnoreCase(mode)) return "REG";
            if ("update".equalsIgnoreCase(mode)) return "MDFCN";
            String id = saveIdentifier(uri, r);
            return isBlank(id) || "0".equals(id.trim()) ? "REG" : "MDFCN";
        }
        return null;
    }

    private String saveIdentifier(String uri, HttpServletRequest r) {
        if (uri.endsWith("/expense/expenseSave.ajax")) return r.getParameter("claimSn");
        if (uri.endsWith("/worklog/dailySave.ajax")) return r.getParameter("workItemSn");
        if (uri.endsWith("/resource/resourceSave.ajax")) return r.getParameter("resourceSn");
        if (uri.endsWith("/resource/reservationSave.ajax")) return r.getParameter("reservationSn");
        if (uri.endsWith("/notice/noticeSave.ajax")) return r.getParameter("noticeSn");
        if (uri.endsWith("/board/boardSave.ajax")) return r.getParameter("boardSn");
        if (uri.endsWith("/schedule/scheduleSave.ajax")) return r.getParameter("schdlSn");
        if (uri.endsWith("/biz/cstSave.ajax")) return r.getParameter("bizCstSn");
        if (uri.endsWith("/biz/mnpwSave.ajax")) return r.getParameter("bizMnpwSn");
        if (uri.endsWith("/biz/schdlSave.ajax")) return r.getParameter("bizSchdlSn");
        if (uri.endsWith("/biz/bizSave.ajax")) return r.getParameter("bizId");
        if (uri.endsWith("/user/empSave.ajax")) return r.getParameter("userId");
        if (uri.endsWith("/authority/authoritySave.ajax")) return r.getParameter("authrtId");
        return null;
    }

    private String target(String uri, HttpServletRequest r) {
        Map<String,Object> before = before(r);
        if (uri.startsWith("/expense/"))
            return label("비용청구", id(r, "claimSn"), firstNonBlank(r.getParameter("expnsNm"), mapText(before, "expnsNm"), r.getParameter("merchantNm")));
        if (uri.endsWith("/resource/reservationSave.ajax") || uri.endsWith("/resource/reservationDelete.ajax"))
            return label("자원예약", id(r, "reservationSn"), r.getParameter("rsvTitle"));
        if (uri.startsWith("/resource/"))
            return label("사무실자원", id(r, "resourceSn"), r.getParameter("resourceNm"));
        if (uri.startsWith("/schedule/"))
            return label("일정", id(r, "schdlSn"), r.getParameter("schdlNm"));
        if (uri.startsWith("/worklog/"))
            return label("일일계획", id(r, "workItemSn"), firstNonBlank(r.getParameter("workCn"), mapText(before, "workCn")));
        if (uri.startsWith("/notice/"))
            return label("공지사항", id(r, "noticeSn"), r.getParameter("noticeTitle"));
        if (uri.startsWith("/board/"))
            return label("게시글", id(r, "boardSn"), r.getParameter("boardTitle"));
        if (uri.startsWith("/user/"))
            return label("사용자", r.getParameter("userId"), r.getParameter("userNm"));
        if (uri.startsWith("/dept/"))
            return label("조직", r.getParameter("deptId"), first(r, "deptNm", "deptName"));
        if (uri.startsWith("/authority/"))
            return label("권한", r.getParameter("authrtId"), first(r, "authrtNm", "authorityNm"));
        if (uri.endsWith("/biz/cstSave.ajax") || uri.endsWith("/biz/cstDelete.ajax"))
            return label("회계비용", id(r, "bizCstSn"), first(r, "cstNm", "expenseNm"));
        if (uri.endsWith("/biz/mnpwSave.ajax") || uri.endsWith("/biz/mnpwDelete.ajax"))
            return label("투입인력", id(r, "bizMnpwSn"), first(r, "userNm", "userId"));
        if (uri.endsWith("/biz/schdlSave.ajax") || uri.endsWith("/biz/schdlDelete.ajax"))
            return label("프로젝트일정", id(r, "bizSchdlSn"), first(r, "schdlNm", "scheduleNm"));
        if (uri.startsWith("/biz/"))
            return label("프로젝트", r.getParameter("bizId"), first(r, "bizNm", "bizAbrvNm"));

        String[] names = {"claimSn", "reservationSn", "resourceSn", "schdlSn", "workItemSn", "noticeSn", "boardSn", "userId", "deptId", "bizCstSn", "bizMnpwSn", "bizSchdlSn", "custSn", "bizId"};
        for (String name : names) {
            String value = r.getParameter(name);
            if (!isBlank(value)) return name + "=" + shortText(value, 80);
        }
        return "-";
    }

    private String actionContent(String uri, HttpServletRequest r, String action) {
        if ("MDFCN".equals(action)) {
            if (uri.endsWith("/authority/authoritySave.ajax")) return authorityDiff(r);
            if (uri.endsWith("/expense/expenseSave.ajax")) return expenseDiff(r);
            if (uri.endsWith("/worklog/dailySave.ajax")) return worklogDiff(r);
        }

        if ("REG".equals(action)) {
            if (uri.endsWith("/worklog/dailySave.ajax")) {
                return brief("등록", r.getParameter("workCn"), "예상완료일", r.getParameter("exptEndYmd"));
            }
            if (uri.endsWith("/expense/expenseSave.ajax")) {
                String title = firstNonBlank(r.getParameter("expnsNm"), r.getParameter("merchantNm"));
                return brief("등록", title, "금액", money(r.getParameter("claimAmt")));
            }
            if (uri.endsWith("/board/boardSave.ajax")) return brief("등록", r.getParameter("boardTitle"), null, null);
            if (uri.endsWith("/notice/noticeSave.ajax")) return brief("등록", r.getParameter("noticeTitle"), null, null);
        }

        String prefix = actionName(action);
        StringBuilder sb = new StringBuilder(prefix);
        if (uri.startsWith("/expense/")) {
            add(sb, "비용명", r.getParameter("expnsNm"));
            add(sb, "금액", money(r.getParameter("claimAmt")));
        } else if (uri.endsWith("/resource/reservationSave.ajax") || uri.endsWith("/resource/reservationDelete.ajax")) {
            add(sb, "예약명", r.getParameter("rsvTitle"));
            add(sb, "시작", r.getParameter("bgngDt"));
            add(sb, "종료", r.getParameter("endDt"));
        } else if (uri.startsWith("/resource/")) {
            add(sb, "자원명", r.getParameter("resourceNm"));
            add(sb, "유형", r.getParameter("resourceTypeCd"));
        } else if (uri.startsWith("/schedule/")) {
            add(sb, "일정명", r.getParameter("schdlNm"));
            add(sb, "기간", joinRange(r.getParameter("bgngDt"), r.getParameter("endDt")));
        } else if (uri.startsWith("/worklog/")) {
            add(sb, "업무", r.getParameter("workCn"));
            add(sb, "예상완료일", r.getParameter("exptEndYmd"));
        } else if (uri.startsWith("/notice/")) {
            add(sb, "제목", r.getParameter("noticeTitle"));
        } else if (uri.startsWith("/board/")) {
            add(sb, "제목", r.getParameter("boardTitle"));
        } else if (uri.startsWith("/user/")) {
            add(sb, "사용자", first(r, "userNm", "userId"));
        } else if (uri.startsWith("/authority/")) {
            add(sb, "권한ID", r.getParameter("authrtId"));
            add(sb, "권한명", r.getParameter("authrtNm"));
        } else if (uri.startsWith("/dept/")) {
            add(sb, "조직명", first(r, "deptNm", "deptName"));
        } else if (uri.startsWith("/biz/")) {
            add(sb, "프로젝트", first(r, "bizNm", "bizId"));
        }
        return shortText(sb.toString(), 950);
    }

    @SuppressWarnings("unchecked")
    private String authorityDiff(HttpServletRequest r) {
        List<Long> oldList = (List<Long>) r.getAttribute(ATTR_AUTH_OLD);
        List<Map<String,Object>> catalog = (List<Map<String,Object>>) r.getAttribute(ATTR_AUTH_CATALOG);
        Set<Long> oldSet = oldList == null ? Collections.<Long>emptySet() : new LinkedHashSet<Long>(oldList);
        Set<Long> newSet = new LinkedHashSet<Long>();
        String[] values = r.getParameterValues("menuSn");
        if (values != null) {
            for (String v : values) try { newSet.add(Long.valueOf(v)); } catch (Exception ignore) {}
        }
        Map<Long,String> labels = new HashMap<Long,String>();
        if (catalog != null) for (Map<String,Object> row : catalog) {
            Long sn = toLong(mapValue(row, "menuSn"));
            if (sn != null) labels.put(sn, text(mapValue(row, "menuLabel")));
        }

        List<String> changes = new ArrayList<String>();
        for (Long sn : newSet) if (!oldSet.contains(sn)) changes.add(menuLabel(labels, sn) + ": 미허용 → 허용");
        for (Long sn : oldSet) if (!newSet.contains(sn)) changes.add(menuLabel(labels, sn) + ": 허용 → 미허용");
        return diffText(changes);
    }

    private String expenseDiff(HttpServletRequest r) {
        Map<String,Object> old = before(r);
        if (old == null || old.isEmpty()) return "수정 · 변경항목 확인 불가";
        List<String> c = new ArrayList<String>();
        changed(c, "프로젝트", mapText(old,"bizId"), r.getParameter("bizId"));
        changed(c, "비용구분", expenseType(mapText(old,"expnsSeCd")), expenseType(r.getParameter("expnsSeCd")));
        changed(c, "결제수단", paymentType(mapText(old,"pmtMthdCd")), paymentType(r.getParameter("pmtMthdCd")));
        changed(c, "카드 끝 4자리", mask4(mapText(old,"cardLast4")), mask4(r.getParameter("cardLast4")));
        changed(c, "사용일", mapText(old,"useYmd"), r.getParameter("useYmd"));
        changed(c, "사용처", mapText(old,"merchantNm"), r.getParameter("merchantNm"));
        changed(c, "비용명", mapText(old,"expnsNm"), r.getParameter("expnsNm"));
        changedNumber(c, "금액", mapText(old,"claimAmt"), r.getParameter("claimAmt"), true);
        changed(c, "비고", mapText(old,"rmrkCn"), r.getParameter("rmrkCn"));
        return diffText(c);
    }

    private String worklogDiff(HttpServletRequest r) {
        Map<String,Object> old = before(r);
        if (old == null || old.isEmpty()) return "수정 · 변경항목 확인 불가";
        List<String> c = new ArrayList<String>();
        changed(c, "프로젝트", mapText(old,"bizId"), r.getParameter("bizId"));
        changedNumber(c, "우선순위", mapText(old,"priorityNo"), r.getParameter("priorityNo"), false);
        changed(c, "예상완료일", mapText(old,"exptEndYmd"), r.getParameter("exptEndYmd"));
        changed(c, "업무구분", mapText(old,"workSeCd"), r.getParameter("workSeCd"));
        changed(c, "업무내용", mapText(old,"workCn"), r.getParameter("workCn"));
        changed(c, "진행상태", workStatus(mapText(old,"prgrsSttsCd")), workStatus(r.getParameter("prgrsSttsCd")));
        changedNumber(c, "진행률", mapText(old,"prgrsRt"), r.getParameter("prgrsRt"), false, "%");
        changed(c, "이슈·특이사항", mapText(old,"issueCn"), r.getParameter("issueCn"));
        changed(c, "익일/차주계획", mapText(old,"nextPlanCn"), r.getParameter("nextPlanCn"));
        return diffText(c);
    }

    private String diffText(List<String> changes) {
        if (changes == null || changes.isEmpty()) return "수정 · 실질 변경사항 없음";
        StringBuilder sb = new StringBuilder("수정 · ");
        int limit = Math.min(changes.size(), 6);
        for (int i=0;i<limit;i++) {
            if (i>0) sb.append(" · ");
            sb.append(changes.get(i));
        }
        if (changes.size() > limit) sb.append(" · 외 ").append(changes.size()-limit).append("개 항목");
        return shortText(sb.toString(), 950);
    }

    private void changed(List<String> out, String label, String oldVal, String newVal) {
        String a = normalizeText(oldVal), b = normalizeText(newVal);
        if (a.equals(b)) return;
        out.add(label + ": " + display(oldVal) + " → " + display(newVal));
    }

    private void changedNumber(List<String> out, String label, String oldVal, String newVal, boolean money) {
        changedNumber(out, label, oldVal, newVal, money, "");
    }

    private void changedNumber(List<String> out, String label, String oldVal, String newVal, boolean money, String suffix) {
        BigDecimal a = decimal(oldVal), b = decimal(newVal);
        if (a != null && b != null && a.compareTo(b) == 0) return;
        if (a == null && b == null) return;
        String av = money ? money(oldVal) : numberDisplay(oldVal, suffix);
        String bv = money ? money(newVal) : numberDisplay(newVal, suffix);
        out.add(label + ": " + display(av) + " → " + display(bv));
    }

    private String brief(String action, String title, String label, String value) {
        StringBuilder sb = new StringBuilder(action);
        if (!isBlank(title)) sb.append(" · ").append(shortText(title, 70));
        if (!isBlank(label) && !isBlank(value)) sb.append(" · ").append(label).append(": ").append(shortText(value, 50));
        return sb.toString();
    }

    private String menuLabel(Map<Long,String> labels, Long sn) {
        String s = labels.get(sn);
        return isBlank(s) ? "메뉴 #" + sn : s;
    }

    @SuppressWarnings("unchecked")
    private Map<String,Object> before(HttpServletRequest r) {
        Object o = r.getAttribute(ATTR_BEFORE);
        return o instanceof Map ? (Map<String,Object>) o : null;
    }

    private Object mapValue(Map<String,Object> map, String key) {
        if (map == null) return null;
        if (map.containsKey(key)) return map.get(key);
        for (Map.Entry<String,Object> e : map.entrySet()) if (key.equalsIgnoreCase(e.getKey())) return e.getValue();
        return null;
    }

    private String mapText(Map<String,Object> map, String key) { return text(mapValue(map,key)); }
    private String text(Object o) { return o == null ? null : String.valueOf(o); }
    private Long toLong(Object o) { try { return o == null ? null : Long.valueOf(String.valueOf(o)); } catch(Exception e){ return null; } }

    private String expenseType(String v) {
        if (isBlank(v)) return v;
        if ("LODGING".equals(v)) return "숙박";
        if ("SUPPLY".equals(v) || "GOODS".equals(v)) return "물품";
        if ("MEAL".equals(v)) return "식비";
        if ("TRANSPORT".equals(v)) return "교통";
        if ("FUEL".equals(v)) return "유류";
        if ("ETC".equals(v)) return "기타";
        return v;
    }

    private String paymentType(String v) {
        if (isBlank(v)) return v;
        if ("PERSONAL_CARD".equals(v)) return "개인카드";
        if ("CORP_CARD".equals(v)) return "법인카드";
        if ("CASH".equals(v)) return "현금";
        if ("ETC".equals(v)) return "기타";
        return v;
    }

    private String workStatus(String v) {
        if (isBlank(v)) return v;
        if ("DONE".equals(v)) return "완료";
        if ("PROGRESS".equals(v)) return "진행";
        if ("CARRY".equals(v)) return "이월";
        if ("WAIT".equals(v)) return "대기";
        return v;
    }

    private String mask4(String v) { return isBlank(v) ? v : "****" + v.trim(); }

    private String numberDisplay(String v, String suffix) {
        if (isBlank(v)) return v;
        BigDecimal d = decimal(v);
        if (d == null) return v + suffix;
        return d.stripTrailingZeros().toPlainString() + suffix;
    }

    private BigDecimal decimal(String v) {
        if (isBlank(v)) return null;
        try { return new BigDecimal(v.replace(",", "").trim()); } catch(Exception e){ return null; }
    }

    private String normalizeText(String v) { return v == null ? "" : v.replace("\r\n","\n").replace('\r','\n').trim(); }
    private String display(String v) { return isBlank(v) ? "(없음)" : shortText(v, 90); }
    private String joinRange(String a, String b) { if (isBlank(a)) return b; if (isBlank(b)) return a; return a + " ~ " + b; }

    private String menu(String uri) {
        if (uri.startsWith("/biz/")) return "프로젝트/사업";
        if (uri.startsWith("/expense/")) return "비용청구";
        if (uri.startsWith("/worklog/")) return "개인업무";
        if (uri.startsWith("/notice/")) return "공지사항";
        if (uri.startsWith("/board/")) return "게시판";
        if (uri.startsWith("/resource/reservation")) return "자원예약";
        if (uri.startsWith("/resource/")) return "사무실 자원관리";
        if (uri.startsWith("/schedule/")) return "일정관리";
        if (uri.startsWith("/user/")) return "사용자관리";
        if (uri.startsWith("/dept/")) return "조직관리";
        if (uri.startsWith("/authority/")) return "권한관리";
        return uri;
    }

    private String label(String type, String id, String name) {
        StringBuilder sb = new StringBuilder(type);
        if (!isBlank(id)) sb.append(" #").append(shortText(id, 45));
        if (!isBlank(name)) sb.append(" · ").append(shortText(name, 70));
        return shortText(sb.toString(), 100);
    }

    private String id(HttpServletRequest r, String name) {
        String v = r.getParameter(name);
        return isBlank(v) || "0".equals(v.trim()) ? null : v.trim();
    }

    private String first(HttpServletRequest r, String... names) {
        for (String name : names) {
            String v = r.getParameter(name);
            if (!isBlank(v)) return v;
        }
        return null;
    }

    private String firstNonBlank(String... values) {
        for (String v : values) if (!isBlank(v)) return v;
        return null;
    }

    private void add(StringBuilder sb, String label, String value) {
        if (isBlank(value)) return;
        sb.append(sb.length() == 0 ? "" : " · ").append(label).append(": ").append(shortText(value, 120));
    }

    private String money(String value) {
        if (isBlank(value)) return null;
        try {
            BigDecimal d = new BigDecimal(value.replace(",", "").trim());
            return new DecimalFormat("#,##0").format(d) + "원";
        } catch (Exception e) {
            return value;
        }
    }

    private String actionName(String action) {
        if ("REG".equals(action)) return "등록";
        if ("MDFCN".equals(action)) return "수정";
        if ("DEL".equals(action)) return "삭제";
        return action;
    }

    private String shortText(String value, int max) {
        if (value == null) return null;
        String s = value.replace('\r', ' ').replace('\n', ' ').trim();
        return s.length() <= max ? s : s.substring(0, max - 1) + "…";
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String ip(HttpServletRequest r) {
        String x = r.getHeader("X-Forwarded-For");
        if (!isBlank(x)) return x.split(",")[0].trim();
        x = r.getHeader("X-Real-IP");
        return !isBlank(x) ? x : r.getRemoteAddr();
    }
}
