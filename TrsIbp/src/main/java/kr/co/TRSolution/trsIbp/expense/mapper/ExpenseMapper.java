package kr.co.TRSolution.trsIbp.expense.mapper;
import java.util.List; import java.util.Map;
import egovframework.rte.psl.dataaccess.mapper.Mapper; import kr.co.TRSolution.trsIbp.expense.vo.ExpenseVO;
@Mapper("expenseMapper")
public interface ExpenseMapper {
 List<ExpenseVO> selectExpenseList(ExpenseVO vo); List<Map<String,Object>> selectAvailableBizList(ExpenseVO vo); ExpenseVO selectExpense(ExpenseVO vo);
 int insertBizCost(ExpenseVO vo); int insertExpense(ExpenseVO vo); int updateBizCost(ExpenseVO vo); int updateExpense(ExpenseVO vo); int deleteBizCost(ExpenseVO vo); int deleteExpense(ExpenseVO vo);
}
