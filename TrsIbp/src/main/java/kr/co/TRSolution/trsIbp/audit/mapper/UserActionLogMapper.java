package kr.co.TRSolution.trsIbp.audit.mapper;

import java.util.List;
import java.util.Map;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.TRSolution.trsIbp.audit.vo.UserActionLogVO;

@Mapper("userActionLogMapper")
public interface UserActionLogMapper {
    int insertUserActionLog(UserActionLogVO vo);
    Map<String,Object> selectExpenseSnapshot(Map<String,Object> param);
    Map<String,Object> selectWorklogSnapshot(Map<String,Object> param);
    List<Long> selectAuthorityGrantedMenuSnList(Map<String,Object> param);
    List<Map<String,Object>> selectAuthorityMenuCatalog();
}
