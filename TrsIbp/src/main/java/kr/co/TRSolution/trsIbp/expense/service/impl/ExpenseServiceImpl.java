package kr.co.TRSolution.trsIbp.expense.service.impl;
import java.util.*; import javax.annotation.Resource; import org.springframework.stereotype.Service; import org.springframework.transaction.annotation.Transactional; import org.springframework.web.multipart.MultipartFile;
import kr.co.TRSolution.trsIbp.comm.file.mapper.CommonFileMapper; import kr.co.TRSolution.trsIbp.comm.file.service.CommonFileService; import kr.co.TRSolution.trsIbp.comm.file.vo.CommonFileVO;
import kr.co.TRSolution.trsIbp.expense.mapper.ExpenseMapper; import kr.co.TRSolution.trsIbp.expense.service.ExpenseService; import kr.co.TRSolution.trsIbp.expense.vo.ExpenseVO;
@Service("expenseService")
public class ExpenseServiceImpl implements ExpenseService {
 @Resource(name="expenseMapper") private ExpenseMapper mapper; @Resource(name="commonFileService") private CommonFileService fileService; @Resource(name="commonFileMapper") private CommonFileMapper fileMapper;
 public List<ExpenseVO> selectExpenseList(ExpenseVO vo){return mapper.selectExpenseList(vo);} public List<Map<String,Object>> selectAvailableBizList(ExpenseVO vo){return mapper.selectAvailableBizList(vo);} public ExpenseVO selectExpense(ExpenseVO vo){return mapper.selectExpense(vo);}
 @Transactional(rollbackFor=Exception.class) public void saveExpense(ExpenseVO vo, MultipartFile[] files)throws Exception{
   if(vo.getBizId()==null||vo.getBizId().trim().isEmpty()) throw new IllegalArgumentException("프로젝트를 선택해 주세요.");
   if(vo.getClaimAmt()==null||vo.getClaimAmt().signum()<=0) throw new IllegalArgumentException("청구금액은 0원보다 커야 합니다.");
   boolean card = "PERSONAL_CARD".equals(vo.getPmtMthdCd()) || "CORP_CARD".equals(vo.getPmtMthdCd());
   if(card){
     String last4=vo.getCardLast4()==null?"":vo.getCardLast4().trim();
     if(!last4.matches("\\d{4}")) throw new IllegalArgumentException("카드 뒷번호 4자리를 숫자로 입력해 주세요.");
     vo.setCardLast4(last4);
   } else { vo.setCardLast4(null); }
   boolean insert=vo.getClaimSn()==null||vo.getClaimSn()==0;
   if(insert){ mapper.insertBizCost(vo); mapper.insertExpense(vo); } else { ExpenseVO old=mapper.selectExpense(vo); if(old==null) throw new IllegalArgumentException("수정할 비용청구 건이 없습니다."); vo.setBizCstSn(old.getBizCstSn()); mapper.updateBizCost(vo); mapper.updateExpense(vo); }
   if(files!=null){int sort=1;for(MultipartFile f:files){if(f==null||f.isEmpty())continue;CommonFileVO fv=fileService.storeFileOnly(f,"expense/receipt","RECEIPT");fv.setCoId(vo.getCoId());fv.setRefSeCd("EXPENSE_CLAIM");fv.setRefId(String.valueOf(vo.getClaimSn()));fv.setSortSeq(sort++);fv.setRgtrId(vo.getRgtrId());fileMapper.insertFile(fv);}}
 }
 @Transactional(rollbackFor=Exception.class) public void deleteExpense(ExpenseVO vo)throws Exception{ExpenseVO old=mapper.selectExpense(vo);if(old==null)throw new IllegalArgumentException("삭제할 비용청구 건이 없습니다.");vo.setBizCstSn(old.getBizCstSn());mapper.deleteExpense(vo);mapper.deleteBizCost(vo);}
}
