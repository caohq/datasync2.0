package cn.csdb.portal.utils;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.select.PlainSelect;
import net.sf.jsqlparser.statement.select.Select;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.jdbc.ScriptRunner;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-15 14:42
 **/
public class SqlUtil {
    public void importSqlByShell(String username, String password, String importDatabaseName, String structImportPath, String dataImportPath) throws IOException {
        Runtime runtime = Runtime.getRuntime();
        StringBuffer command = new StringBuffer().append("mysql -u").append(username);
        if (password != null && !password.equals("")) {
            command.append(" -p").append(password);
        }
        command.append(" " + importDatabaseName);
        command.append(" < " + structImportPath);
        Process process = runtime.exec(new String[]{"bash", "-c", command.toString()});
        try {
            process.waitFor();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        StringBuffer command2 = new StringBuffer().append("mysql -u").append(username);
        if (password != null && !password.equals("")) {
            command2.append(" -p").append(password);
        }
        command2.append(" " + importDatabaseName);
        command2.append(" < " + dataImportPath);
        process = runtime.exec(new String[]{"bash", "-c", command2.toString()});
    }


    public void importSql(String host, String username, String password, String importDatabaseName, String structImportPath, String dataImportPath) throws Exception {
        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://" + host + "/" + importDatabaseName;

        Exception error = null;
        Connection conn = null;
//        FileWriter fw = null;
//        PrintWriter pw = null;
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);

            /*File dir = new File(System.getProperty("portal.framework.root") + "RunScriptLog");
            if (!dir.exists()) {
                dir.mkdir();
            }
            File file = new File(System.getProperty("portal.framework.root") + "RunScriptLog/"+importDatabaseName + ".txt");
            if (!file.exists()) {
                file.createNewFile();
            }
            fw = new FileWriter(file.getName());*/

            /*if (org.apache.log4j.Logger.getRootLogger().getAppender("LogFile") instanceof DailyRollingFileAppender) {
                DailyRollingFileAppender apen = (DailyRollingFileAppender) org.apache.log4j.Logger
                        .getRootLogger().getAppender("LogFile");
                try {
                    fw = new FileWriter(apen.getFile(), true);//apen.getFile()取得文件路径，封装成FileWriter是为了日志信息不被覆盖，而是追加写入
            */
//            pw = new PrintWriter(fw);


            ScriptRunner runner = new ScriptRunner(conn);
            //下面配置不要随意更改，否则会出现各种问题
            runner.setAutoCommit(true);//自动提交
            runner.setFullLineDelimiter(false);
            runner.setDelimiter(";");////每条命令间的分隔符
            runner.setSendFullScript(false);
            runner.setStopOnError(false);
            System.out.println("begin run-----------");
//            runner.setErrorLogWriter(pw);//设置是否输出日志
//            runner.setLogWriter(pw);//设置是否输出日志
            //如果又多个sql文件，可以写多个runner.runScript(xxx),
            runner.runScript(new InputStreamReader(new FileInputStream(structImportPath), "utf-8"));
            runner.runScript(new InputStreamReader(new FileInputStream(dataImportPath), "utf-8"));
            close(conn);
            System.out.println("end run-----------");
        } catch (Exception e) {
            error = e;
            e.printStackTrace();
        } finally {
            close(conn);
            /*if (pw != null) {
                pw.close();
            }
*/
        }
        if (error != null) {
            throw error;
        }
    }

    private static void close(Connection conn) {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            if (conn != null) {
                conn = null;
            }
        }
    }

    public static boolean validateSelectSql(String sql) {

        return getSelectFromSelectSql(sql) == null ? false : true;

    }

    private static Select getSelectFromSelectSql(String sql) {
        if (StringUtils.isBlank(sql)) {
            return null;
        }
        Select select;
        try {
            select = (Select) CCJSqlParserUtil.parse(sql);
        } catch (JSQLParserException e) {
            return null;
        }

        if (!(select.getSelectBody() instanceof PlainSelect)) {
            return null;
        }
        return select;
    }

}
