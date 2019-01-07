package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.TableInfo;
import cn.csdb.drsr.model.TableInfoR;
import cn.csdb.drsr.service.LoginService;
import cn.csdb.drsr.service.RelationShipService;
import cn.csdb.drsr.utils.ConfigUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import cn.csdb.drsr.model.DataSrc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.management.relation.RelationService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by shiba on 2018/10/8.
 */
@Controller
@RequestMapping("/relationship")
public class RelationSourceController {
    private Logger logger = LoggerFactory.getLogger(RelationSourceController.class);
    @Resource
    private RelationShipService relationShipService;

    @RequestMapping("/deleteData")
    public
    @ResponseBody
    String delete(String dataId) {
        logger.debug("进入删除功能");
        String tag = relationShipService.deleteRelation(Integer.valueOf(dataId));
        return tag;
    }

    @RequestMapping("/add")
    public
    @ResponseBody
    String add(String dataSourceName, String dataSourceType, String dataBaseName, String dataBaseType, String host,
               String port, String userName, String password) {
        logger.debug("新增功能开始");
        Date current_date = new Date();
        //设置日期格式化样式为：yyyy-MM-dd
        SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //格式化当前日期
        String currentTime = SimpleDateFormat.format(current_date.getTime());
        DataSrc datasrc = new DataSrc();
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        datasrc.setSubjectCode(ConfigUtil.getConfigItem(configFilePath, "SubjectCode"));
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setDatabaseName(dataBaseName);
        datasrc.setDatabaseType(dataBaseType);
        datasrc.setHost(host);
        datasrc.setPort(port);
        datasrc.setUserName(userName);
        datasrc.setPassword(password);
        datasrc.setCreateTime(currentTime);
        logger.info("测试新增或编辑的数据能否连通数据库");
        String flag = relationShipService.testCon(host, port, userName, password, dataBaseName);
        if (flag == "success") {
            return relationShipService.addData(datasrc);
        } else {
            return "2";
        }
    }

    @RequestMapping("/edit")
    public
    @ResponseBody
    String edit(String dataSourceName, String dataSourceType, String dataBaseName, String dataBaseType, String host,
                String port, String userName, String password, String dataSourceId) {
        logger.debug("编辑功能开始,开始插入");
        Date current_date = new Date();
        //设置日期格式化样式为：yyyy-MM-dd
        SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //格式化当前日期
        String currentTime = SimpleDateFormat.format(current_date.getTime());
        DataSrc datasrc = new DataSrc();
        int dataSourceId1 = Integer.valueOf(dataSourceId);
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setDatabaseName(dataBaseName);
        datasrc.setDatabaseType(dataBaseType);
        datasrc.setHost(host);
        datasrc.setPort(port);
        datasrc.setUserName(userName);
        datasrc.setPassword(password);
        datasrc.setCreateTime(currentTime);
        datasrc.setDataSourceId(dataSourceId1);
        logger.info("测试新增或编辑的数据能否连通数据库");

        String flag = relationShipService.testCon(host, port, userName, password, dataBaseName);

        if (flag == "success") {
            return relationShipService.editData(datasrc);
        } else {
            return "2";
        }

    }

    @RequestMapping("/queryData")
    public
    @ResponseBody
    List<DataSrc> queryData(String dataId) {
        logger.debug("编辑功能开始,开始查询");
        List<DataSrc> editData = relationShipService.editQueryData(Integer.valueOf(dataId));/*Integer.valueOf(dataId)*/
        return editData;
    }

    @RequestMapping(value = "/index")
    public ModelAndView index(HttpServletRequest request, Integer currentPage) {
        logger.info("进入关系数据源模块列表页");
        ModelAndView mv = new ModelAndView("relationalResource");
        return mv;

    }

    @RequestMapping(value = "/indexPages")
    public
    @ResponseBody
    JSONObject indexPages(Integer num) {
        if (num == null) {
            num = 1;
        }
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String SubjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        Map map = relationShipService.queryTotalPage(SubjectCode);
        List<DataSrc> relationDataOfThisPage = relationShipService.queryPage(num,SubjectCode);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("relationDataOfThisPage", relationDataOfThisPage);
        jsonObject.put("totalPage", map.get("totalPages"));
        jsonObject.put("currentPage", num);
        jsonObject.put("totalNum", map.get("totalRows"));
        return jsonObject;
    }


    /**
     * Function Description:
     *
     * @param: []
     * @return: java.util.List<cn.csdb.drsr.model.DataSrc>
     * @auther: hw
     * @date: 2018/10/22 17:59
     */
    @RequestMapping(value = "findAllDBSrc")
    public @ResponseBody
    List<DataSrc> findAllDBSrc() {
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        return relationShipService.findAllBySubjectCode(subjectCode);
    }

    /**
     * Function Description:
     *
     * @param: [dataSourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/22 17:59
     */
    @ResponseBody
    @RequestMapping(value = "relationalDatabaseTableList")
    public JSONObject relationalDatabaseTableList(int dataSourceId) {
        JSONObject jsonObject = new JSONObject();
        DataSrc dataSrc = relationShipService.findById(dataSourceId);
        List<String> list = relationShipService.relationalDatabaseTableList(dataSrc);
        jsonObject.put("list", list);
        jsonObject.put("dataSourceName", dataSrc.getDataSourceName());
        return jsonObject;
    }

    /**
     * Function Description: preview RelationalDatabase By TableName
     *
     * @param: [dataSourceId, tableInfosListStr, pageSize]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/23 10:29
     */
    @ResponseBody
    @RequestMapping(value = "/previewRelationalDatabaseByTableName")
    public JSONObject previewRelationalDatabaseByTableName(
            @RequestParam(required = false) String dataSourceId,
            @RequestParam(required = false, name = "tableInfosList") String tableInfosListStr,
            @RequestParam(required = false, defaultValue = "10") int pageSize) {
        logger.info("预览表数据");
        JSONObject jsonObject = new JSONObject();
        List<TableInfoR> tableInfosList = JSON.parseArray(tableInfosListStr, TableInfoR.class);
        HashMap<String, List<TableInfo>> maps = Maps.newHashMap();
        String tableName = null;
        if (tableInfosList != null && tableInfosList.size() == 1) {
            tableName = tableInfosList.get(0).getTableName();
            maps.put(tableName, tableInfosList.get(0).getTableInfos());
        } else {
            return jsonObject;
        }
        List<List<Object>> datas = relationShipService.getDataByTable(tableName, maps, Integer.valueOf(dataSourceId), 0, pageSize);
        jsonObject.put("datas", datas);
        return jsonObject;
    }

    /**
     * Function Description: preview RelationalDatabase By SQL
     *
     * @param: [dataSourceId, sqlStr, tableInfosListStr, pageSize]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/23 10:29
     */
    @ResponseBody
    @RequestMapping(value = "/previewRelationalDatabaseBySQL")
    public JSONObject previewRelationalDatabaseBySQL(
            @RequestParam(required = false) String dataSourceId,
            @RequestParam() String sqlStr,
//            @RequestParam(required = false, name = "tableInfosList") String tableInfosListStr,
            @RequestParam(required = false, defaultValue = "10") int pageSize) {
        logger.info("预览表数据");
        JSONObject jsonObject = new JSONObject();
        Map<String, List<TableInfo>> maps = relationShipService.getDefaultFieldComsBySql(Integer.parseInt(dataSourceId), sqlStr);
        List<List<Object>> datas = relationShipService.getDataBySql(sqlStr, maps, Integer.valueOf(dataSourceId), 0, pageSize);
        jsonObject.put("datas", datas);
        jsonObject.put("maps", maps);
        return jsonObject;
    }

}