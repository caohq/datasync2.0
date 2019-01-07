package cn.csdb.drsr.repository;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.repository.mapper.DataSrcMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.*;


/**
 * @program: DataSync
 * @description: relation dao
 * @author: shibaoping
 * @create: 2018-10-09 15:31
 **/


@Repository
public class RelationDao{
    @Resource
    private JdbcTemplate jdbcTemplate;

    public int addRelationData(DataSrc DataSrc) {
        String insertSql = "insert into t_datasource(DataSourceName, DataSourceType, DatabaseName, DatabaseType ,Host, Port, UserName, Password, createTime, stat, SubjectCode)" +
                "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Object[] arg = new Object[] {DataSrc.getDataSourceName(), DataSrc.getDataSourceType(), DataSrc.getDatabaseName(),
                DataSrc.getDatabaseType(), DataSrc.getHost(), DataSrc.getPort(), DataSrc.getUserName(), DataSrc.getPassword(),DataSrc.getCreateTime() , "1", DataSrc.getSubjectCode()};

        int addedRowCnt = jdbcTemplate.update(insertSql,arg);

        return addedRowCnt;
    }

    public List<DataSrc> queryRelationData(){
        String querySql = "select * from t_datasource WHERE DataSourceType = 'db'";
        List<DataSrc>queryData = jdbcTemplate.query(querySql,new DataSrcMapper());
        return queryData;
    }

    public int editRelationData(DataSrc dataSrc){
        String updateSql = "UPDATE t_datasource set DataSourceName = ?," +
                "DataSourceType = ?," +
                "DatabaseName = ?," +
                "DatabaseType = ?," +
                "Host = ?," +
                "Port = ?," +
                "UserName = ?," +
                "Password = ?," +
                "createTime = ?" +
                "WHERE DataSourceId = ?";
        Object[] arg = new Object[] {dataSrc.getDataSourceName(), dataSrc.getDataSourceType(), dataSrc.getDatabaseName(),
                dataSrc.getDatabaseType(), dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getCreateTime(), dataSrc.getDataSourceId()};
        int addedRowCnt = jdbcTemplate.update(updateSql,arg);
        return addedRowCnt;
    }

    public int deleteRelationData(int id)
    {
        String deleteSql = "delete from t_datasource where DataSourceId = ?";
        Object[] args = new Object[]{id};

        int deletedRowCnt = jdbcTemplate.update(deleteSql, args);

        return deletedRowCnt;
    }


    public List<DataSrc> editQueryData(int id)
    {
        String querySql = "select * from t_datasource where DataSourceId = ?";
        Object[] args = new Object[]{id};
        List<DataSrc>queryData = jdbcTemplate.query(querySql,args,new DataSrcMapper());
        return queryData;
    }

    public Map queryTotalPage(String SubjectCode){
        int rowsPerPage = 10;
        String rowSql="select count(*) from t_datasource WHERE DataSourceType = 'db' and SubjectCode = ?";
        Object[] args = new Object[]{SubjectCode};
        int totalRows=(Integer)jdbcTemplate.queryForObject(rowSql,args,Integer.class);
        int totalPages = 0;
        totalPages = totalRows / rowsPerPage + (totalRows % rowsPerPage == 0 ? 0 : 1);
        Map map = new HashMap();
        map.put("totalPages",totalPages);
        map.put("totalRows",totalRows);
        return map;
    }

    public List<DataSrc> queryPage(int pageNumber,String SubjectCode)
    {
        if (pageNumber < 1)
        {
            return null;
        }

        int rowsPerPage = 10;
        String rowSql="select count(*) from t_datasource WHERE DataSourceType = 'db' and SubjectCode = ?";
        Object[] args = new Object[]{SubjectCode};
        int totalRows=(Integer)jdbcTemplate.queryForObject(rowSql,args,Integer.class);
        int totalPages = 0;
        totalPages = totalRows / rowsPerPage + (totalRows % rowsPerPage == 0 ? 0 : 1);

        if (pageNumber > totalPages)
        {
            return null;
        }

        int startRowNum = 0;
        startRowNum = (pageNumber - 1) * rowsPerPage;

        final List<DataSrc> relationDataOfThisPage = new ArrayList<DataSrc>();
        String querySql = "select * from t_datasource WHERE  DataSourceType = 'db' and SubjectCode = ? order by createTime Desc limit " +
                startRowNum + ", " + rowsPerPage;
        jdbcTemplate.query(querySql, args, new RowCallbackHandler() {
            @Override
            public void processRow(ResultSet rs) throws SQLException {
                do
                {
                    DataSrc dataSrc = new DataSrc();
                    dataSrc.setDataSourceId(rs.getInt("DataSourceId"));
                    dataSrc.setDataSourceName(rs.getString("DataSourceName"));
                    dataSrc.setDataSourceType(rs.getString("DataSourceType"));
                    dataSrc.setDatabaseName(rs.getString("DatabaseName"));
                    dataSrc.setDatabaseType(rs.getString("DatabaseType"));
                    dataSrc.setFilePath(rs.getString("FilePath"));
                    dataSrc.setFileType(rs.getString("FileType"));
                    dataSrc.setHost(rs.getString("Host"));
                    dataSrc.setPort(rs.getString("Port"));
                    dataSrc.setIsValid(rs.getString("IsValid"));
                    dataSrc.setUserName(rs.getString("UserName"));
                    dataSrc.setPassword(rs.getString("Password"));
                    dataSrc.setCreateTime(rs.getString("createTime"));
                    dataSrc.setStat(rs.getInt("stat"));
                    dataSrc.setSubjectCode(rs.getString("SubjectCode"));
                    relationDataOfThisPage.add(dataSrc);
                }while(rs.next());
            }
        });

        return relationDataOfThisPage;
    }

    public List<DataSrc> findAllBySubjectCode(String subjectCode) {
        List<DataSrc> dataSrcs = new ArrayList<DataSrc>();
        String sql = "select * from t_datasource where DataSourceType='db' and SubjectCode=?";
        List<DataSrc> list = jdbcTemplate.query(sql,new Object[]{subjectCode},new DataSrcMapper());
        return list;
    }

    public DataSrc findById(int id) {
        String sql = "select * from t_datasource where DataSourceId=?";
        DataSrc dataSrc = jdbcTemplate.queryForObject(sql, new Object[]{id}, new int[]{Types.INTEGER}, new DataSrcMapper());
        return dataSrc;
    }

    public DataSrc findByIdAndSubjectCode(int id,String subjectCode) {
        String sql = "select * from t_datasource where DataSourceId=? and SubjectCode=?";
        DataSrc dataSrc = jdbcTemplate.queryForObject(sql, new Object[]{id,subjectCode}, new int[]{Types.INTEGER}, new DataSrcMapper());
        return dataSrc;
    }

}

