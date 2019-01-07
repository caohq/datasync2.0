package cn.csdb.portal.repository;

import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.stereotype.Repository;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;


/**
 * @program: DataSync
 * @description: Resource Dao 资源操作类
 * @author: xiajl
 * @create: 2018-10-23 14:21
 **/
@Repository
public class ResourceDao {
    @Resource
    private MongoTemplate mongoTemplate;

    /**
     * Function Description: 保存资源
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date:   2018/10/23 14:34
     */
    public String save(cn.csdb.portal.model.Resource resource){
        mongoTemplate.save(resource);
        return resource.getId();
    }


    /**
     * Function Description: 删除记录
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date:   2018/10/23 14:44
     */
    public void delete(String id){
        DBObject query = QueryBuilder.start().and("_id").is(id).get();
        BasicQuery basicQuery = new BasicQuery(query);
        mongoTemplate.remove(basicQuery, cn.csdb.portal.model.Resource.class);
    }

    public void delete(cn.csdb.portal.model.Resource resource){
        mongoTemplate.remove(resource);
    }

    /**
     * Function Description: 分页查询获取资源List
     *
     * @param:  subjectCode:专题库代码, title:资源名称, status:状态, pageNo:页数, pageSize:第页记录条数
     * @return: 资源List列表
     * @auther: Administrator
     * @date:   2018/10/23 16:11
     */
    public List<cn.csdb.portal.model.Resource> getListByPage(String subjectCode, String title, String publicType, String resState, int pageNo, int pageSize){
        QueryBuilder queryBuilder = QueryBuilder.start();
        if(StringUtils.isNotEmpty(subjectCode)){
            queryBuilder = queryBuilder.and("subjectCode").is(subjectCode);
        }
        if (StringUtils.isNotEmpty(title)){
            queryBuilder = queryBuilder.and("title").regex(Pattern.compile("^.*"+title+".*$"));
        }
        if (StringUtils.isNotEmpty(publicType)){
            queryBuilder =queryBuilder.and("publicType").is(publicType);
        }
        if (StringUtils.isNotEmpty(resState)){
            queryBuilder =queryBuilder.and("status").is(resState);
        }

        DBObject dbObject = queryBuilder.get();
        BasicQuery basicQuery = new BasicQuery(dbObject);
        Sort.Order so = new Sort.Order(Sort.Direction.DESC, "creationDate");
        List<Sort.Order> sos = new ArrayList<>();
        sos.add(so);
        basicQuery.with(new Sort(sos));
        basicQuery.skip((pageNo-1)*pageSize );
        basicQuery.limit(pageSize);
        return mongoTemplate.find(basicQuery, cn.csdb.portal.model.Resource.class);
    }


    public long countByPage(String subjectCode, String title, String publicType, String resState){
        QueryBuilder queryBuilder = QueryBuilder.start();
        if(StringUtils.isNotEmpty(subjectCode)){
            queryBuilder = queryBuilder.and("subjectCode").is(subjectCode);
        }
        if (StringUtils.isNotEmpty(title)){
            queryBuilder = queryBuilder.and("title").regex(Pattern.compile("^.*"+title+".*$"));
        }
        if (StringUtils.isNotEmpty(publicType)){
            queryBuilder =queryBuilder.and("publicType").is(publicType);
        }
        if (StringUtils.isNotEmpty(resState)){
            queryBuilder =queryBuilder.and("status").is(resState);
        }

        DBObject dbObject = queryBuilder.get();
        BasicQuery basicQuery = new BasicQuery(dbObject);
        return mongoTemplate.count(basicQuery,cn.csdb.portal.model.Resource.class);
    }

    public cn.csdb.portal.model.Resource getById(String resourceId){
        return mongoTemplate.findById(resourceId, cn.csdb.portal.model.Resource.class);
    }

}
