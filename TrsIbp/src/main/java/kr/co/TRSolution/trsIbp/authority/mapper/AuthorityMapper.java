package kr.co.TRSolution.trsIbp.authority.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("authorityMapper")
public interface AuthorityMapper {
    List<Map<String,Object>> selectAuthorityList(Map<String,Object> param);
    List<Map<String,Object>> selectMenuAuthorityList(Map<String,Object> param);
    List<String> selectGrantedMenuCodeList(Map<String,Object> param);
    List<String> selectGrantedMenuUrlList(Map<String,Object> param);
    List<String> selectAllowedWorkspaceList(Map<String,Object> param);
    String selectDefaultWorkspace(String userId);
    int selectRegisteredMenuCount(Map<String,Object> param);
    int selectGrantedMenuCount(Map<String,Object> param);
    int selectAuthorityCount(Map<String,Object> param);
    int selectAuthorityUserCount(Map<String,Object> param);
    String selectCompanyCode(String coId);
    Integer selectMaxCustomAuthoritySeq(Map<String,Object> param);
    String selectDataScopeCd(Map<String,Object> param);
    int selectBizAccessCount(Map<String,Object> param);
    int selectScheduleAccessCount(Map<String,Object> param);
    int insertAuthority(Map<String,Object> param);
    int updateAuthority(Map<String,Object> param);
    int deleteAuthorityMenu(Map<String,Object> param);
    int deleteAuthority(Map<String,Object> param);
    int insertAuthorityMenu(Map<String,Object> param);
    int clearDefaultWorkspace(String userId);
    int upsertDefaultWorkspace(Map<String,Object> param);
}
