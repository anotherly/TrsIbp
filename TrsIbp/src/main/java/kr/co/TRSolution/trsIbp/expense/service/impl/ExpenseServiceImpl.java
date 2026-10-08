package kr.co.TRSolution.trsIbp.expense.service.impl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import kr.co.TRSolution.trsIbp.comm.file.mapper.CommonFileMapper;
import kr.co.TRSolution.trsIbp.comm.file.service.CommonFileService;
import kr.co.TRSolution.trsIbp.comm.file.vo.CommonFileVO;
import kr.co.TRSolution.trsIbp.expense.mapper.ExpenseMapper;
import kr.co.TRSolution.trsIbp.expense.service.ExpenseService;
import kr.co.TRSolution.trsIbp.expense.vo.ExpenseVO;

@Service("expenseService")
public class ExpenseServiceImpl implements ExpenseService {
    @Resource(name="expenseMapper") private ExpenseMapper mapper;
    @Resource(name="commonFileService") private CommonFileService fileService;
    @Resource(name="commonFileMapper") private CommonFileMapper fileMapper;

    public List<ExpenseVO> selectExpenseList(ExpenseVO vo) { return mapper.selectExpenseList(vo); }
    public List<Map<String,Object>> selectAvailableBizList(ExpenseVO vo) { return mapper.selectAvailableBizList(vo); }
    public ExpenseVO selectExpense(ExpenseVO vo) { return mapper.selectExpense(vo); }
    public ExpenseVO selectExpenseForAccounting(ExpenseVO vo) { return mapper.selectExpenseForAccounting(vo); }

    @Transactional(rollbackFor=Exception.class)
    public void saveExpense(ExpenseVO vo, MultipartFile[] files) throws Exception {
        if (vo.getBizId()==null || vo.getBizId().trim().isEmpty())
            throw new IllegalArgumentException("프로젝트를 선택해 주세요.");
        if (mapper.selectAvailableBizCount(vo) < 1)
            throw new IllegalArgumentException("프로젝트 조회 범위에 포함되지 않는 사업입니다.");
        if (vo.getClaimAmt()==null || vo.getClaimAmt().signum()<=0)
            throw new IllegalArgumentException("비용은 0원보다 커야 합니다.");
        if (vo.getExpnsNm()==null || vo.getExpnsNm().trim().isEmpty())
            throw new IllegalArgumentException("비용명을 입력해 주세요.");
        if (vo.getUseYmd()==null || vo.getUseYmd().trim().isEmpty())
            throw new IllegalArgumentException("사용일을 입력해 주세요.");
        boolean card = "PERSONAL_CARD".equals(vo.getPmtMthdCd()) || "CORP_CARD".equals(vo.getPmtMthdCd());
        if (card) {
            String last4 = vo.getCardLast4()==null ? "" : vo.getCardLast4().trim();
            if (!last4.matches("\\d{4}"))
                throw new IllegalArgumentException("카드 뒷번호 4자리를 숫자로 입력해 주세요.");
            vo.setCardLast4(last4);
        } else { vo.setCardLast4(null); }

        boolean insert = vo.getClaimSn()==null || vo.getClaimSn().longValue()==0L;
        if (insert) {
            if (mapper.insertExpense(vo)!=1 || vo.getClaimSn()==null)
                throw new IllegalStateException("비용 저장에 실패했습니다.");
        } else {
            ExpenseVO old = mapper.selectExpense(vo);
            if (old==null) throw new IllegalArgumentException("수정할 비용이 없거나 접근 권한이 없습니다.");
            // Changing projects requires permission on both the old and the newly selected project.
            if (mapper.updateExpense(vo)!=1) throw new IllegalStateException("비용 수정에 실패했습니다.");
        }
        // The attachment REF_ID is now the biz_cst primary key (identical to the API claimSn alias).
        if (files!=null) {
            int sort=1;
            for (MultipartFile f:files) {
                if (f==null || f.isEmpty()) continue;
                CommonFileVO fv = fileService.storeFileOnly(f,"expense/receipt","RECEIPT");
                fv.setCoId(vo.getCoId()); fv.setRefSeCd("BIZ_COST");
                fv.setRefId(String.valueOf(vo.getClaimSn())); fv.setSortSeq(sort++);
                fv.setRgtrId(vo.getRgtrId()); fileMapper.insertFile(fv);
            }
        }
    }

    @Transactional(rollbackFor=Exception.class)
    public void deleteExpense(ExpenseVO vo) throws Exception {
        if (mapper.selectExpense(vo)==null)
            throw new IllegalArgumentException("삭제할 비용이 없거나 접근 권한이 없습니다.");
        if (mapper.deleteExpense(vo)!=1)
            throw new IllegalStateException("비용 삭제에 실패했습니다.");
    }
}
