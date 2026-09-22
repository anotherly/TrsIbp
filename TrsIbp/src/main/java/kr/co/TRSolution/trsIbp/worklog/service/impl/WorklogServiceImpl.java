package kr.co.TRSolution.trsIbp.worklog.service.impl;
import java.time.LocalDate; import java.util.*; import javax.annotation.Resource; import org.springframework.stereotype.Service; import org.springframework.transaction.annotation.Transactional; import kr.co.TRSolution.trsIbp.worklog.mapper.WorklogMapper; import kr.co.TRSolution.trsIbp.worklog.service.WorklogService; import kr.co.TRSolution.trsIbp.worklog.vo.WorklogVO;
@Service("worklogService") public class WorklogServiceImpl implements WorklogService {
 @Resource(name="worklogMapper") private WorklogMapper m; public List<WorklogVO> selectDailyList(WorklogVO v){return m.selectDailyList(v);} public List<WorklogVO> selectWeeklyList(WorklogVO v){return m.selectWeeklyList(v);} public List<Map<String,Object>> selectBizList(WorklogVO v){return m.selectBizList(v);}
 @Transactional(rollbackFor=Exception.class) public int saveDaily(WorklogVO v){
   if(v.getWorkCn()==null||v.getWorkCn().trim().isEmpty()) throw new IllegalArgumentException("업무내용을 입력해 주세요.");
   if(v.getWorkYmd()==null||v.getWorkYmd().trim().isEmpty()) throw new IllegalArgumentException("업무일자를 선택해 주세요.");
   if(v.getPriorityNo()==null) v.setPriorityNo(3); if(v.getPriorityNo()<1||v.getPriorityNo()>5) throw new IllegalArgumentException("우선순위는 1~5 사이로 선택해 주세요.");
   if(v.getExptEndYmd()==null||v.getExptEndYmd().trim().isEmpty()) v.setExptEndYmd(v.getWorkYmd());
   String start=(v.getTaskBgngYmd()==null||v.getTaskBgngYmd().trim().isEmpty())?v.getWorkYmd():v.getTaskBgngYmd();
   if(LocalDate.parse(v.getExptEndYmd()).isBefore(LocalDate.parse(start))) throw new IllegalArgumentException("예상완료일은 업무 시작일보다 빠를 수 없습니다.");
   if("DONE".equals(v.getPrgrsSttsCd())) v.setDoneYmd(v.getWorkYmd()); else v.setDoneYmd(null);
   int n; if(v.getWorkItemSn()==null){v.setTaskBgngYmd(v.getWorkYmd()); n=m.insertDaily(v);} else n=m.updateDaily(v);
   if(n>0) m.upsertDailyProgress(v); return n;
 }
 public int deleteDaily(WorklogVO v){return m.deleteDaily(v);}
}
