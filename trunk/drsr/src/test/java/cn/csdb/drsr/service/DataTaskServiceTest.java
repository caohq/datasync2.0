package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataTask;
import com.alibaba.fastjson.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:spring-mvc.xml"})
public class DataTaskServiceTest {
    @Resource
    private DataTaskService dataTaskService;

    private Logger logger = LoggerFactory.getLogger(DataTaskServiceTest.class);

    @Test
    public void test(){
        DataTask task = dataTaskService.get("1");
        JSONObject jsonObject = new JSONObject();
        jsonObject = dataTaskService.executeTask(task);
        logger.info("\n\njsonObject= " +jsonObject +  "\n");
    }

    @Test
    public void testGetAll(){
        List<DataTask> list = dataTaskService.getAllData();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data",list);
        logger.info("\n\n" +jsonObject.toJSONString() +"\n");
    }
}
