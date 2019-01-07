package cn.csdb.drsr.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Repository
public class PersonDao {
    @Resource
    private JdbcTemplate jdbcTemplate;

    public List<Map<String,Object>> findAll(){
        String sql = "select * from person";
        return jdbcTemplate.queryForList(sql);
    }

    public boolean add(String name, int age, String address){
        boolean result = false;
        String sql = "Insert into person(name,age,address) values(?,?,?)";
        if ( jdbcTemplate.update(sql,new Object[]{name,age,address}) > 0 )
            result = true;
        return result;
    }
}
