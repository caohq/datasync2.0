package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.TableInfo;
import cn.csdb.drsr.model.TableInfoR;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSON;
import com.google.common.collect.Maps;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.concurrent.*;

/**
 * @program: DataSync
 * @description: import and export data into or from files
 * @author: Mr.huang
 * @create: 2018-09-27 14:25
 **/
public class DataFileService {

    private Logger logger = LoggerFactory.getLogger(DataFileService.class);

    private static final ExecutorService executor = Executors.newFixedThreadPool(4);

    /*public void createDataFile(final int resourceId, final CountDownLatch dbFlag) {
        executor.submit(new Callable<String>() {
            @Override
            public String call() {
                try {
                    TimeUnit.MILLISECONDS.sleep(2000);// sleeping for 4 minutes
                } catch (InterruptedException e) {
                }
                List<DataResourceStatic> dataResourceStaticList = dataResourceStaticDao.findDataResourceStaticByResourceId(resourceId);
                for (DataResourceStatic dataResourceStatic : dataResourceStaticList) {
                    try {
                        String fieldComs = dataResourceStatic.getFieldComs();
                        if (StringUtils.equals("file", dataResourceStatic.getPublicType())) {
                            continue;
                        }
                        String publicContent = dataResourceStatic.getPublicContent();
                        if (StringUtils.isBlank(publicContent)) {
                            continue;
                        }
                        String tableDataFile = dataResourceStatic.getFileName();
                        if (StringUtils.isBlank(tableDataFile)) {
                            tableDataFile = RandomStringUtils.randomNumeric(24) + ".xlsx";
                        }
                        DataSrc dataSrc = null;
                        try {
                            DataResource dataResource = dataResourceDao.findByResourceId(resourceId);
                            dataSrc = dataSrcDao.findById(dataResource.getDataSourceId());
                        } catch (Exception ex) {
                            logger.error("", ex);
                            continue;
                        }
                        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
                        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(),
                                dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
                        if (connection == null) {
                            continue;
                        }
                        String sql = publicContent;
                        if (StringUtils.equals("table", dataResourceStatic.getPublicType())) {
                            sql = "select * from " + publicContent;
                        }
                        PreparedStatement preparedStatement = dataSource.getBySql(connection, sql, null);
                        try {
                            SXSSFWorkbook wb = createSxssfWorkbook(fieldComs, preparedStatement);
                            wb.write(FileUtils.openOutputStream(
                                    new File(System.getProperty("drsr.framework.root") + tableDataFilePath +
                                            File.separator + tableDataFile)));
                            dataResourceStaticDao.updateFileName(dataResourceStatic.getStatId(), tableDataFile);
                        } catch (Exception e) {
                            logger.error("", e);
                            e.printStackTrace();
                        } finally {
                            try {
                                connection.close();
                            } catch (SQLException e) {
                            }
                        }
                    } catch (Exception ex) {
                        logger.error(this.toString(), ex);
                    }
                }
                dbFlag.countDown();
                return "ok";
            }
        });
    }*/

    public SXSSFWorkbook createSxssfWorkbook(String fieldComs, PreparedStatement preparedStatement) throws SQLException {
        List<TableInfoR> tableInfoRList = JSON.parseArray(fieldComs, TableInfoR.class);
        HashMap<String, List<TableInfo>> listHashMap = Maps.newHashMap();
        for (TableInfoR tableInfoR : tableInfoRList) {
            listHashMap.put(tableInfoR.getTableName(), tableInfoR.getTableInfos());
        }
        SXSSFWorkbook wb = new SXSSFWorkbook(100);
        CellStyle bodyStyle = wb.createCellStyle();
        bodyStyle.setWrapText(true);
        Sheet sheet = wb.createSheet();
        Row row = sheet.createRow(0);
        int columnIndexTitle = 0;
        for (String key : listHashMap.keySet()) {
            List<TableInfo> tableInfos = listHashMap.get(key);
            for (TableInfo tableInfo : tableInfos) {
                Cell cell = row.createCell(columnIndexTitle++);
                StringBuilder cellValue = new StringBuilder()
                        .append(StringUtils.isBlank(tableInfo.getColumnNameLabel())
                                ? tableInfo.getColumnName() : tableInfo.getColumnNameLabel());
                if (StringUtils.isNoneBlank(tableInfo.getColumnComment())) {
                    cellValue.append("\n").append("(")
                            .append(tableInfo.getColumnComment())
                            .append(")");
                    cell.setCellStyle(bodyStyle);
                    cell.setCellValue(new HSSFRichTextString(cellValue.toString()));
                } else {
                    cell.setCellValue(cellValue.toString());
                }
            }
        }
        int rowCount = 1;
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            int columnIndex = 0;
            Set<String> keySet = listHashMap.keySet();
            row = sheet.createRow(rowCount++);
            for (String key : keySet) {
                List<TableInfo> tableInfos = listHashMap.get(key);
                for (TableInfo tableInfo : tableInfos) {
                    Cell cell = row.createCell(columnIndex++);
                    Object object = resultSet.getObject(StringUtils.isBlank(tableInfo.getColumnNameLabel())
                            ? tableInfo.getColumnName() : tableInfo.getColumnNameLabel());
                    cell.setCellValue(object == null ? "" : object.toString());
                }
            }
        }
        return wb;
    }
}
