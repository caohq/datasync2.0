package cn.csdb.drsr;

import cn.csdb.drsr.repository.PersonDao;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;
import java.util.Map;

public class SqlLiteDemo {
    private Logger logger = LoggerFactory.getLogger(SqlLiteDemo.class);

    public static void main(String[] args){
        ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
        PersonDao personDao = (PersonDao) ctx.getBean("personDao");
        List<Map<String,Object>> list = personDao.findAll();
        for(Map<String,Object> map : list){
            System.out.println(map.get("name"));
        }
    }

    //测试向SQLite数据库表中 插入一条记录
    @Test
    public void insert(){
        ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
        PersonDao personDao = (PersonDao) ctx.getBean("personDao");
        logger.info("\n数据记录总条数: " +personDao.findAll().size());
        personDao.add("bbbbb",20,"北京海淀");
        logger.info("\n数据记录总条数: " +personDao.findAll().size());
    }

}
