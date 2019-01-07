package cn.csdb.drsr.repository;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.mapper.DataTaskMapper;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.*;
import java.util.List;

/**
 * @program: DataSync
 * @description: dataTask dao
 * @author: xiajl
 * @create: 2018-09-30 16:18
 **/

@Repository
public class DataTaskDao {
    @Resource
    private JdbcTemplate jdbcTemplate;

    public DataTask get(String id) {
        String sql = "select * from t_datatask where dataTaskId = ?";
        List<DataTask> list = jdbcTemplate.query(sql, new Object[]{id}, new DataTaskMapper());
        return list.size() > 0 ? list.get(0) : null;
    }

    //更新
    public boolean update(DataTask dataTask) {
        boolean result = false;
        String sql = "update T_dataTask set " +
                "DataSourceId=?,DataTaskName=?,DataTaskType=?," +
                "TableName=?,SqlString=?,SqlTableNameEn=?," +
                "SqlFilePath=?,FilePath=?,Creator=?," +
                "Status=?,SubjectCode=?,LogPath=?,CreateTime=?" +
                "where DataTaskId=? ";
        int i = jdbcTemplate.update(sql, new Object[]{
                dataTask.getDataSourceId(), dataTask.getDataTaskName(), dataTask.getDataTaskType(),
                dataTask.getTableName(), dataTask.getSqlString(), dataTask.getSqlTableNameEn(),
                dataTask.getSqlFilePath(), dataTask.getFilePath(), dataTask.getCreator(),
                dataTask.getStatus(), dataTask.getSubjectCode(),dataTask.getLogPath(),dataTask.getCreateTime(),
                dataTask.getDataTaskId()});
        if (i >= 0) {
            result = true;
        }
        return result;
    }

    //获取所有的任务信息
    public List<DataTask> getAll() {
        String sql = "Select * from T_dataTask";
        return jdbcTemplate.query(sql, new DataTaskMapper());
    }

    /**
     * Function Description: 数据任务展示、查找列表
     *
     * @param: [start, pageSize, datataskType, status]
     * @return: java.util.List<cn.csdb.drsr.model.DataTask>
     * @auther: hw
     * @date: 2018/10/23 15:46
     */
    public List<DataTask> getDatataskByPage(int start, int pageSize, String datataskType, String status,String subjectCode) {
        StringBuilder sb = new StringBuilder();
        sb.append("select * from t_datatask ");
        if (StringUtils.isNoneBlank(datataskType) || StringUtils.isNoneBlank(status) || StringUtils.isNoneBlank(subjectCode)) {
            sb.append("where ");
        }
        List<Object> params = getSql(datataskType, status, subjectCode,sb);
        sb.append(" order by CreateTime desc limit ?,? ");
        params.add(start);
        params.add(pageSize);
        return jdbcTemplate.query(sb.toString(), params.toArray(), new DataTaskMapper());
    }

    public int getCount(String datataskType,String status,String subjectCode){
        StringBuilder sb = new StringBuilder();
        sb.append("select count(*) from t_datatask ");
        if (StringUtils.isNoneBlank(datataskType) || StringUtils.isNoneBlank(status) || StringUtils.isNoneBlank(subjectCode)) {
            sb.append("where ");
        }
        List<Object> params = getSql(datataskType, status, subjectCode,sb);
        return jdbcTemplate.queryForObject(sb.toString(),params.toArray(),Integer.class);
    }

    /**
     * Function Description: sql语句组织
     *
     * @param: [datataskType, status, sb]
     * @return: java.util.List<java.lang.Object>
     * @auther: hw
     * @date: 2018/10/23 15:46
     */
    List<Object> getSql(String datataskType, String status, String subjectCode, StringBuilder sb) {
        List<Object> params = Lists.newArrayList();
        if (StringUtils.isNoneBlank(datataskType)) {
            sb.append("datataskType=? ");
            params.add(datataskType);
        }
        if (StringUtils.isNoneBlank(status)) {
            if (StringUtils.isNoneBlank(datataskType)) {
                sb.append("and ");
            }
            sb.append("status=? ");
            params.add(status);
        }
        if (StringUtils.isNoneBlank(subjectCode)) {
            if (StringUtils.isNoneBlank(datataskType)||StringUtils.isNoneBlank(status)) {
                sb.append("and ");
            }
            sb.append("subjectCode=? ");
            params.add(subjectCode);
        }
        return params;
    }

    public int deleteDatataskById(String datataskId) {
        String sql = "delete from t_datatask where datataskId=?";
        return jdbcTemplate.update(sql, datataskId);
    }

    public int insertDatatask(final DataTask datatask) {
        boolean flag = false;
        final String sql = "insert into t_datatask(" +
                "dataSourceId,dataTaskName,dataTaskType," +
                "tableName,sqlString,sqlTableNameEn," +
                "sqlFilePath,filePath,createTime," +
                "creator,status,datataskId,subjectCode) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
//        int i = jdbcTemplate.update(sql, new Object[]{datatask.getDataSourceId(),datatask.getDataTaskName(),
//                datatask.getDataTaskType(), datatask.getTableName(), datatask.getSqlString(),
//                datatask.getSqlTableNameEn(), datatask.getSqlFilePath(), datatask.getFilePath(),
//                datatask.getCreateTime(), datatask.getCreator(), datatask.getStatus()});
//        if (i > 0) {
//            flag = true;
//        }

        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1,datatask.getDataSourceId());
                ps.setString(2,datatask.getDataTaskName());
                ps.setString(3,datatask.getDataTaskType());
                ps.setString(4,datatask.getTableName());
                ps.setString(5,datatask.getSqlString());
                ps.setString(6,datatask.getSqlTableNameEn());
                ps.setString(7,datatask.getSqlFilePath());
                ps.setString(8,datatask.getFilePath());
                ps.setTimestamp(9,new Timestamp(datatask.getCreateTime().getTime()));
                ps.setString(10,datatask.getCreator());
                ps.setString(11,datatask.getStatus());
                ps.setString(12,datatask.getDataTaskId());
                ps.setString(13,datatask.getSubjectCode());
                return ps;

            }
        },keyHolder);

        int generatedId = keyHolder.getKey().intValue();

        return generatedId;
    }

    public boolean hasDatataskName(String datataskName,String datataskId){
        StringBuffer sql = new StringBuffer("select * from t_datatask where dataTaskName=?");
        List<Object> params = Lists.newArrayList();
        params.add(datataskName);
        if(StringUtils.isNotBlank(datataskId)){
            sql.append(" and dataTaskId!=?");
            params.add(datataskId);
        }
        List<DataTask> list = jdbcTemplate.query(sql.toString(), params.toArray(), new DataTaskMapper());
        if(list == null||list.size() == 0){
            return false;
        }else{
            return true;
        }
    }

    public int insertLogPath(String dataTaskId,String path){
        String updateSql = "UPDATE t_datatask SET LogPath = ? WHERE DataTaskId = ?";
        Object[] arg = new Object[] {path,dataTaskId};
        int flag = jdbcTemplate.update(updateSql,arg);
        return flag;
    }


}
