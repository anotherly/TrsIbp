package kr.co.TRSolution.trsIbp.resource.mapper;
import java.util.List;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.TRSolution.trsIbp.resource.vo.ResourceVO;
@Mapper("resourceMapper") public interface ResourceMapper {
 List<ResourceVO> selectResourceList(ResourceVO vo); ResourceVO selectResource(ResourceVO vo); int insertResource(ResourceVO vo); int updateResource(ResourceVO vo); int deleteResourceAttrs(Long resourceSn); int insertResourceAttr(ResourceVO vo); int deleteResource(ResourceVO vo);
 List<ResourceVO> selectReservationList(ResourceVO vo); int selectOverlapCount(ResourceVO vo); int insertReservation(ResourceVO vo); int updateReservation(ResourceVO vo); ResourceVO selectReservation(ResourceVO vo); int deleteReservation(ResourceVO vo);
 int insertSchedule(ResourceVO vo); int updateSchedule(ResourceVO vo); int deleteSchedule(ResourceVO vo); int insertScheduleUser(ResourceVO vo);
 List<ResourceVO> selectAvailableBizList(ResourceVO vo);
}
