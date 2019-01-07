package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.utils.SqlUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 * Created by xiajl on 2018/10/02.
 */
@Service
@Transactional
public class DataSrcService {

    @Autowired
    private DataSrcDao dataSrcDao;

    public List<DataSrc> findAll() {
        return dataSrcDao.findAll();
    }

    public boolean validation(int id) {
        DataSrc dataSrc = findById(id);
        String host = dataSrc.getHost();
        String port = dataSrc.getPort();
        String userName = dataSrc.getUserName();
        String password = dataSrc.getPassword();
        String databaseName = dataSrc.getDatabaseName();
        if ("xml".equals(dataSrc.getDatabaseType())) {
            String filePath = dataSrc.getFilePath();
            return new File(filePath).exists();
        }
        boolean isValid = DataSourceFactory.getDataSource(dataSrc.getDatabaseType()).validateConnection(host, port, userName, password, databaseName);
        return isValid;
    }

    public boolean unsavedValidation(DataSrc dataSrc) {
        if ("xml".equals(dataSrc.getDatabaseType())) {
            String filePath = dataSrc.getFilePath();
            return new File(filePath).exists();
        }
        boolean isValid = DataSourceFactory.getDataSource(dataSrc.getDatabaseType()).validateConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        return isValid;
    }

    public DataSrc findById(int i) {
        return dataSrcDao.findById(i);
    }

    public boolean insert(DataSrc dataSrc) {
        return dataSrcDao.insert(dataSrc);
    }

    public boolean update(DataSrc dataSrc) {
        return dataSrcDao.update(dataSrc);
    }

    public boolean delete(int i) {
        return dataSrcDao.delete(i);
    }

    public JSONObject pagination(int currentPage, String dataSourceType) {
        return dataSrcDao.pagination(currentPage, 10, dataSourceType);
    }

    public JSONObject pagination(int currentPage, String dataSourceType, boolean hasXml) {
        if (hasXml)
            return pagination(currentPage, dataSourceType);
        else {
            String[] databaseTypes = new String[]{"mysql", "oracle"};
            return dataSrcDao.pagination(currentPage, 10, dataSourceType, databaseTypes);
        }
    }

    public List<String> relationalDatabaseTableList(DataSrc dataSrc) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null)
            return null;
        return dataSource.getTableList(connection);
    }

    public List<JSONObject> fileSourceFileList(String filePath) {
        return dataSrcDao.fileSourceFileList(filePath);
    }

    public Map<String, Map<String, String>> getTableCols(int dataSourceId, String tableName) {
        DataSrc dataSrc = dataSrcDao.findById(dataSourceId);
        if (dataSrc == null)
            return null;
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null)
            return null;
        return dataSource.getTableColumns(connection, dataSrc.getDatabaseName(), tableName);
    }

    public boolean validateSql(String sql, int dataSourceId) {
        if (!SqlUtils.validateSelectSql(sql)) {
            return false;
        }
        DataSrc dataSrc = dataSrcDao.findById(dataSourceId);
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null)
            return false;
        return dataSource.validateSql(connection, sql);
    }

    public String validateFtp(DataSrc dataSrc) {
        FTPClient ftpClient = new FTPClient();
        ftpClient.setControlEncoding("utf-8");
        try {
            ftpClient.connect(dataSrc.getHost(), Integer.parseInt(dataSrc.getPort())); //连接ftp服务器
            ftpClient.login(dataSrc.getUserName(), dataSrc.getPassword()); //登录ftp服务器
            int replyCode = ftpClient.getReplyCode(); //是否成功登录服务器
            if (!FTPReply.isPositiveCompletion(replyCode)) {
                return "Connection failed";
            }
            boolean b = ftpClient.changeWorkingDirectory(dataSrc.getFilePath());//目录是否存在
            if (b == false) {
                return "dictionaru non-existent";
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return "success";
    }
}
