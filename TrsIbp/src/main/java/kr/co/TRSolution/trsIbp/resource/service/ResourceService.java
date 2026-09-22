package kr.co.TRSolution.trsIbp.resource.service;
import java.util.List; import kr.co.TRSolution.trsIbp.resource.vo.ResourceVO;
public interface ResourceService { List<ResourceVO> selectResourceList(ResourceVO vo); ResourceVO selectResource(ResourceVO vo); void saveResource(ResourceVO vo); void deleteResource(ResourceVO vo); List<ResourceVO> selectReservationList(ResourceVO vo); List<ResourceVO> selectAvailableBizList(ResourceVO vo); void saveReservation(ResourceVO vo); void deleteReservation(ResourceVO vo); }
