package kr.co.TRSolution.trsIbp.worklog.mapper;
import java.util.*; import egovframework.rte.psl.dataaccess.mapper.Mapper; import kr.co.TRSolution.trsIbp.worklog.vo.WorklogVO;
@Mapper("worklogMapper") public interface WorklogMapper { List<WorklogVO> selectDailyList(WorklogVO vo); List<WorklogVO> selectWeeklyList(WorklogVO vo); List<Map<String,Object>> selectBizList(WorklogVO vo); int insertDaily(WorklogVO vo); int updateDaily(WorklogVO vo); int upsertDailyProgress(WorklogVO vo); int deleteDaily(WorklogVO vo); }
