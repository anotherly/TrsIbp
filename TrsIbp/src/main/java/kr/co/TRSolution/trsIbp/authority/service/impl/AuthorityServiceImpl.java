package kr.co.TRSolution.trsIbp.authority.service.impl;

import java.util.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.TRSolution.trsIbp.authority.mapper.AuthorityMapper;
import kr.co.TRSolution.trsIbp.authority.service.AuthorityService;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Service("authorityService")
public class AuthorityServiceImpl implements AuthorityService {
    @Resource(name="authorityMapper") private AuthorityMapper mapper;

    public List<Map<String,Object>> selectAuthorityList(String coId) {
        return mapper.selectAuthorityList(param(coId, null));
    }
    public List<Map<String,Object>> selectMenuAuthorityList(String coId, String authrtId) {
        return mapper.selectMenuAuthorityList(param(coId, authrtId));
    }
    @Transactional(rollbackFor=Exception.class)
    public void saveAuthorityMenu(String coId, String authrtId, List<Long> menuSnList, String loginUserId) {
        requireAuthority(coId, authrtId);
        if ("ADMIN".equals(authrtId)) throw new IllegalArgumentException("최고관리자 권한은 전체 기능 사용으로 고정됩니다.");
        Map<String,Object> p=param(coId,authrtId); mapper.deleteAuthorityMenu(p);
        if(menuSnList==null) return;
        for(Long sn:new LinkedHashSet<Long>(menuSnList)) {
            if(sn==null) continue;
            p=new HashMap<String,Object>(); p.put("coId",coId); p.put("authrtId",authrtId); p.put("menuSn",sn); p.put("loginUserId",loginUserId);
            mapper.insertAuthorityMenu(p);
        }
    }
    public void insertAuthority(String coId,String authrtId,String authrtNm,String authrtExpln) {
        validate(authrtId,authrtNm); Map<String,Object> p=param(coId,authrtId);
        if(mapper.selectAuthorityCount(p)>0) throw new IllegalArgumentException("현재 회사에서 이미 사용 중인 권한ID입니다.");
        p.put("authrtNm",authrtNm.trim()); p.put("authrtExpln",trim(authrtExpln)); p.put("dataScopeCd","SELF"); mapper.insertAuthority(p);
    }
    public void updateAuthority(String coId,String authrtId,String authrtNm,String authrtExpln) {
        requireAuthority(coId,authrtId); validate(authrtId,authrtNm); Map<String,Object> p=param(coId,authrtId);
        p.put("authrtNm",authrtNm.trim()); p.put("authrtExpln",trim(authrtExpln)); mapper.updateAuthority(p);
    }
    @Transactional(rollbackFor=Exception.class)
    public void deleteAuthority(String coId,String authrtId) {
        requireAuthority(coId,authrtId);
        if(Arrays.asList("ADMIN","MANAGER","USER").contains(authrtId)) throw new IllegalArgumentException("기본 권한은 삭제할 수 없습니다.");
        Map<String,Object> p=param(coId,authrtId);
        if(mapper.selectAuthorityUserCount(p)>0) throw new IllegalArgumentException("사용 중인 권한은 삭제할 수 없습니다.");
        mapper.deleteAuthorityMenu(p); mapper.deleteAuthority(p);
    }
    public boolean isRequestGranted(UserVO u,String url,String type) {
        if(u==null) return false;
        if("SYS_ADMIN".equals(u.getAuthrtId())||"ADMIN".equals(u.getAuthrtId())) return true;
        Map<String,Object> p=param(u.getCoId(),u.getAuthrtId()); p.put("requestUrl",url); p.put("menuTypeNm",type);
        int registered=mapper.selectRegisteredMenuCount(p);
        return registered==0 || mapper.selectGrantedMenuCount(p)>0;
    }
    public Set<String> refreshSessionAuthority(HttpSession session,UserVO u) {
        String auth=(u==null||u.getAuthrtId()==null)?"USER":u.getAuthrtId(); String co=u==null?null:u.getCoId();
        Set<String> ws=new LinkedHashSet<String>(); Set<String> codes=new HashSet<String>(); Set<String> urls=new HashSet<String>(); String dflt="WORK";
        try {
            Map<String,Object> p=param(co,auth); ws.addAll(mapper.selectAllowedWorkspaceList(p)); codes.addAll(mapper.selectGrantedMenuCodeList(p)); urls.addAll(mapper.selectGrantedMenuUrlList(p));
            /* 대시보드는 권한과 무관하므로 4개 업무공간 진입 자체는 허용한다. */
            ws.addAll(Arrays.asList("WORK","PROJECT","ORG","MANAGEMENT"));
            String stored=u==null?null:mapper.selectDefaultWorkspace(u.getUserId()); if(stored!=null&&ws.contains(stored)) dflt=stored;
        } catch(DataAccessException ex) { applyLegacyFallback(auth,ws,codes); }
        if(ws.isEmpty()) ws.add("WORK");
        session.setAttribute("allowedWorkspaces",ws); session.setAttribute("grantedMenuCodes",codes); session.setAttribute("grantedMenuUrls",urls); session.setAttribute("defaultWorkspaceId",dflt);
        return ws;
    }
    @SuppressWarnings("unchecked") public boolean isWorkspaceAllowed(HttpSession s,String id){Object o=s.getAttribute("allowedWorkspaces");return o instanceof Set&&((Set<String>)o).contains(id);}
    public boolean isCompanyDataScope(UserVO u){
        if(u==null) return false; if("SYS_ADMIN".equals(u.getAuthrtId())||"ADMIN".equals(u.getAuthrtId())||"MANAGER".equals(u.getAuthrtId())) return true;
        try { String v=mapper.selectDataScopeCd(param(u.getCoId(),u.getAuthrtId())); return "COMPANY".equals(v); } catch(DataAccessException e){ return false; }
    }
    public boolean isBizAccessAllowed(UserVO u,String bizId){
        if(bizId==null||bizId.trim().isEmpty()||u==null) return true; if(isCompanyDataScope(u)) return true;
        Map<String,Object> p=param(u.getCoId(),u.getAuthrtId()); p.put("userId",u.getUserId()); p.put("bizId",bizId); return mapper.selectBizAccessCount(p)>0;
    }
    public boolean isScheduleAccessAllowed(UserVO u,String sn,boolean write){
        if(sn==null||sn.trim().isEmpty()||u==null) return true; if("ADMIN".equals(u.getAuthrtId())||"SYS_ADMIN".equals(u.getAuthrtId())) return true;
        Map<String,Object> p=param(u.getCoId(),u.getAuthrtId());p.put("userId",u.getUserId());p.put("schdlSn",sn);p.put("writeYn",write?"Y":"N");return mapper.selectScheduleAccessCount(p)>0;
    }
    @Transactional(rollbackFor=Exception.class) public void saveDefaultWorkspace(UserVO u,String id){if(u==null)throw new IllegalArgumentException("로그인 정보가 없습니다.");mapper.clearDefaultWorkspace(u.getUserId());Map<String,Object>p=new HashMap<String,Object>();p.put("userId",u.getUserId());p.put("workspaceId",id);mapper.upsertDefaultWorkspace(p);}
    private void requireAuthority(String co,String auth){if(mapper.selectAuthorityCount(param(co,auth))==0)throw new IllegalArgumentException("존재하지 않는 회사 권한입니다.");}
    private void validate(String id,String nm){if(id==null||!id.matches("^[A-Z][A-Z0-9_]{1,19}$"))throw new IllegalArgumentException("권한ID는 영문 대문자로 시작하는 대문자·숫자·밑줄 2~20자로 입력해 주세요.");if(nm==null||nm.trim().isEmpty()||nm.trim().length()>50)throw new IllegalArgumentException("권한명은 1~50자로 입력해 주세요.");}
    private Map<String,Object> param(String co,String auth){Map<String,Object>p=new HashMap<String,Object>();p.put("coId",co);p.put("authrtId",auth);return p;}
    private String trim(String s){return s==null?"":s.trim();}
    private void applyLegacyFallback(String auth,Set<String>ws,Set<String>codes){ws.add("WORK");codes.add("WORK_DASHBOARD_SCREEN");codes.add("WORK_SCHEDULE_LIST_SCREEN");if("ADMIN".equals(auth)||"MANAGER".equals(auth)){ws.addAll(Arrays.asList("PROJECT","ORG","MANAGEMENT"));codes.addAll(Arrays.asList("PROJECT_DASHBOARD_SCREEN","PROJECT_BIZ_LIST_SCREEN","PROJECT_CONTRACT_SCREEN","PROJECT_ACCOUNT_SCREEN","PROJECT_MNPW_SCREEN","PROJECT_PROCESS_SCREEN","ORG_DASHBOARD_SCREEN","MANAGEMENT_DASHBOARD_SCREEN"));}if("ADMIN".equals(auth))codes.addAll(Arrays.asList("MANAGEMENT_ORG_SCREEN","MANAGEMENT_USER_SCREEN","MANAGEMENT_AUTHRT_SCREEN"));}
}
