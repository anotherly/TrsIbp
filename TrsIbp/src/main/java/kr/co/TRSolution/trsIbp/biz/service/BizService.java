
package kr.co.TRSolution.trsIbp.biz.service;

import java.util.List;

import kr.co.TRSolution.trsIbp.biz.vo.BizVO;

public interface BizService {

    List<BizVO> selectBizList(BizVO vo) throws Exception;
    int selectBizListCnt(BizVO vo) throws Exception;
    BizVO selectBizDetail(BizVO vo) throws Exception;
    int insertBiz(BizVO vo) throws Exception;
    int updateBiz(BizVO vo) throws Exception;
    int deleteBiz(BizVO vo) throws Exception;

    List<BizVO> selectCustList(BizVO vo) throws Exception;
    BizVO selectCustDetail(BizVO vo) throws Exception;
    int insertCust(BizVO vo) throws Exception;
    int updateCust(BizVO vo) throws Exception;
    int deleteCust(BizVO vo) throws Exception;

    List<BizVO> selectBizCustRelList(BizVO vo) throws Exception;
    int insertBizCustRel(BizVO vo) throws Exception;
    int updateBizCustRel(BizVO vo) throws Exception;
    int deleteBizCustRel(BizVO vo) throws Exception;

    List<BizVO> selectBizMnpwList(BizVO vo) throws Exception;
    int insertBizMnpw(BizVO vo) throws Exception;
    int updateBizMnpw(BizVO vo) throws Exception;
    int deleteBizMnpw(BizVO vo) throws Exception;

    List<BizVO> selectBizCstList(BizVO vo) throws Exception;
    int insertBizCst(BizVO vo) throws Exception;
    int updateBizCst(BizVO vo) throws Exception;
    int deleteBizCst(BizVO vo) throws Exception;

    List<BizVO> selectBizSchdlList(BizVO vo) throws Exception;
    int insertBizSchdl(BizVO vo) throws Exception;
    int updateBizSchdl(BizVO vo) throws Exception;
    int deleteBizSchdl(BizVO vo) throws Exception;

    BizVO selectBizProfitSummary(BizVO vo) throws Exception;
}
