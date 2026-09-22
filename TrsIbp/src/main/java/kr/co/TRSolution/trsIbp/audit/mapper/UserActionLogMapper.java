package kr.co.TRSolution.trsIbp.audit.mapper;
import egovframework.rte.psl.dataaccess.mapper.Mapper; import kr.co.TRSolution.trsIbp.audit.vo.UserActionLogVO;
@Mapper("userActionLogMapper") public interface UserActionLogMapper { int insertUserActionLog(UserActionLogVO vo); }
