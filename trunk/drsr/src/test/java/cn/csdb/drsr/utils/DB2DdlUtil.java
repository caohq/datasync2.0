package cn.csdb.drsr.utils;

import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

/**
 * 根据java数据源生成建表ddl 工具类
 * admin
 */
public class DB2DdlUtil {

    /**
     * 生成文件
     * @param path ：文件保存路径
     * @param FileName： 文件名
     * @param body:文件内容
     * @return
     */
    public static boolean generateFile(String path, String FileName, String body) {
        try {
            File f = new File(path);
            if (!f.exists()) {
                f.mkdirs();
            }
            path = path +File.separator + FileName;
            f = new File(path);
            if (!f.exists()){
                f.createNewFile();
            }
            PrintWriter out;
            out = new PrintWriter(new FileWriter(f));
            out.print(body +"\n");
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    public Connection getConnection(String className, String jdbcUrl, String user, String password ){
        try {
            Class.forName(className);
            return DriverManager.getConnection(jdbcUrl,user,password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 根据Java数据源信息生成 DDL
     * @param className 驱动类名
     * @param jdbcUrl jdbc地址
     * @param user  用户名
     * @param password 密码
     * @param tableName  表名
     */
    public void db2ddl(String className, String jdbcUrl, String user, String password, String tableName){
        Connection conn = null;
        try {
            //DB2 com.ibm.db2.jcc.DB2Driver"jdbc:db2://localhost:50000/abc","db2admin","123456"
            //MYSQL com.mysql.jdbc.Driver"jdbc:mysql://localhost:3306/manager","root","root"
            //MSSQLSERVER net.sourceforge.jtds.jdbc.Driver"jdbc:jtds:sqlserver://localhost:1433/abc","sa","123456"
            conn = getConnection(className,jdbcUrl,user,password);
            DatabaseMetaData odmd = conn.getMetaData();
            //String[] types = {"TABLE"};// 数组变量types
            ResultSet rs = odmd.getTables(null, null, null, null);
            //odmd.getMaxTableNameLength()
            StringBuffer sql = new StringBuffer();
            int counti=1;
            while (rs.next()) {
                // 取表名
                String Tablename = rs.getString(3);
                if (StringUtils.equalsIgnoreCase(rs.getString(3),tableName) )
                {
                    System.out.println(counti+"-"+Tablename);
                    String commnt ="";
                    String indexu ="";
                    ResultSet pkRSet = odmd.getPrimaryKeys(null, null,Tablename);
                    ResultSet rscol = odmd.getColumns(null, null,Tablename, null);
                    ResultSet inset = odmd.getIndexInfo(null, null, Tablename, false ,true );
                    String colstr ="";
                    while (rscol.next()) {
                        String ColumnName = rscol.getString(4);
                        String ColumnTypeName = rscol.getString(6);
                        String REMARKS = rscol.getString(12);
                        if(StringUtils.isNotBlank(REMARKS)){
                            commnt = commnt+"COMMENT ON"+Tablename+"("+ColumnName+"IS '"+REMARKS+"' ); n";
                        }
                        while(inset.next()){
                            if(inset.getInt(7)==DatabaseMetaData.tableIndexOther){
                                indexu = indexu+"CREATE UNIQUE INDEX"+inset.getString(6)+"ON"+inset.getString(5)+"("+inset.getString(9)+");n";
                            }
                            System.out.println();
                        }
                        int displaySize = rscol.getInt(7);
                        int scale = rscol.getInt(9);
                        // int Precision = displaySize-scale;
                        if(StringUtils.isNotBlank(colstr)){
                            colstr = colstr+", ";
                        }
                        colstr =colstr+" "+ ColumnName +" ";
                        if (StringUtils.indexOf(ColumnTypeName,"identity")>=0){
                            colstr =colstr+ColumnTypeName +"(1,1)";
                        }else if (StringUtils.equalsIgnoreCase(ColumnTypeName,"timestamp")
                                ||StringUtils.equalsIgnoreCase(ColumnTypeName,"int")
                                ||StringUtils.equalsIgnoreCase(ColumnTypeName,"datetime")
                                ||StringUtils.equalsIgnoreCase(ColumnTypeName,"long")
                                ||StringUtils.equalsIgnoreCase(ColumnTypeName,"date")
                                ||StringUtils.equalsIgnoreCase(ColumnTypeName,"text")
                                ||StringUtils.equalsIgnoreCase(ColumnTypeName,"image")
                                ||StringUtils.equalsIgnoreCase(ColumnTypeName,"bit")
                                ||StringUtils.equalsIgnoreCase(ColumnTypeName,"ntext")
                                ) {
                            colstr =colstr+ColumnTypeName +"";
                        } else if (StringUtils.equalsIgnoreCase(ColumnTypeName,"decimal")
                                || StringUtils.equalsIgnoreCase(ColumnTypeName,"number")
                                || StringUtils.equalsIgnoreCase(ColumnTypeName,"double")) {
                            if (scale == 0)
                                colstr =colstr+ColumnTypeName +"("+ displaySize+")";
                            else
                                colstr =colstr+ColumnTypeName +"("+ displaySize+","+ scale +")";
                        } else {
                            colstr =colstr+ColumnTypeName +"("+ displaySize +")";
                        }
                        String defaultstr = rscol.getString(13);
                        if(defaultstr!=null)
                            colstr =colstr+"t default"+defaultstr;
                        if (rscol.getInt(11) == DatabaseMetaData.columnNoNulls) {
                            colstr =colstr+"  not null";
                        } else if (rscol.getInt(11) == DatabaseMetaData.columnNullable) {
                            // sql.append("tnull");
                        }
                    }
                    String pkcolstr ="";
                    while (pkRSet.next()) {
                        if(StringUtils.isNotBlank(pkcolstr)){
                            pkcolstr = pkcolstr+",  ";
                        }else{
                            if(StringUtils.isNotBlank(colstr)){
                                colstr = colstr+",  ";
                            }
                        }
                        pkcolstr = pkcolstr+"  constraint "+ pkRSet.getObject(6)+"primary key ("+ pkRSet.getObject(4)+")";
                    }
                    sql.append("create table"+ Tablename +" ("+colstr+pkcolstr+" ) ");
                    System.out.println("create table"+ Tablename +" ("+colstr+pkcolstr+" ); "+commnt+""+indexu+" ");
                }
                counti++;
            }
            generateFile("c:/","abc.sql", sql.toString());
            rs.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(conn!=null) conn.close();
            } catch (SQLException e) {
            }
        }
    }

    public static void main(String[] args) {
        /*DB2DdlUtil db2DdlUtil = new DB2DdlUtil();
        String className="com.mysql.jdbc.Driver";
        String jdbcUrl = "jdbc:mysql://localhost:3306/test";
        String user ="root";
        String password="123456";
        String tableName="course";
        db2DdlUtil.db2ddl(className,jdbcUrl,user,password,tableName);
*/
        String s = "Insert into aaa values ('a','b') ";
        generateFile("d:\\","a.sql",s);
    }
}
