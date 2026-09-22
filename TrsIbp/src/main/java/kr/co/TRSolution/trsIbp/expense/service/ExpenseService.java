package kr.co.TRSolution.trsIbp.expense.service;
import java.util.List; import java.util.Map; import org.springframework.web.multipart.MultipartFile; import kr.co.TRSolution.trsIbp.expense.vo.ExpenseVO;
public interface ExpenseService { List<ExpenseVO> selectExpenseList(ExpenseVO vo); List<Map<String,Object>> selectAvailableBizList(ExpenseVO vo); ExpenseVO selectExpense(ExpenseVO vo); void saveExpense(ExpenseVO vo, MultipartFile[] files) throws Exception; void deleteExpense(ExpenseVO vo) throws Exception; }
