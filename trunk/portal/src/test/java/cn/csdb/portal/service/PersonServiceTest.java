package cn.csdb.portal.service;

import cn.csdb.portal.model.Person;
import cn.csdb.portal.repository.PersonDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description: a test for person service class
 * @author: xiajl
 * @create: 2018-10-22 10:02
 **/

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:spring-mvc.xml"})

public class PersonServiceTest {
    @Resource
    private PersonDao personDao;

    private Logger logger = LoggerFactory.getLogger(PersonServiceTest.class);


    @Test
    public void test(){
        Person person = new Person();
        person.setName("aaa");
        person.setAge(20);
        person.setAddress("北京");
        personDao.save(person);
    }

    @Test
    public void findAll(){
        List<Person> lists =  personDao.findAll();
        logger.info("\n===================================\n");
        System.out.println("总记录条数: " +lists.size() + "\n");
        logger.debug("总记录条数: " +lists.size() + "\n");
        for (Person person : lists){
            logger.info( person.getId() + ":" + person.getName() + ":" + person.getAge() + ": " +person.getAddress());
            System.out.println( person.getId() + ":" + person.getName() + ":" + person.getAge() + ": " +person.getAddress());
        }
    }
}
