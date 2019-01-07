package cn.csdb.drsr.controller;

import cn.csdb.drsr.utils.SqlUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by xiajl on 2018/9/19.
 */
@Controller
public class IndexController {

    private Logger logger= LoggerFactory.getLogger(IndexController.class);

    @RequestMapping("/index")
    public ModelAndView index(@RequestParam(name = "userName", required = false) String userName) {
        logger.debug("进入客户端首页");
        logger.info("userName = " + userName);
        ModelAndView modelAndView = new ModelAndView("index");
        if (userName != null) {
            modelAndView.addObject("userName", userName);
        }

        return modelAndView;
    }

    @RequestMapping("/")
    public ModelAndView login(HttpServletRequest request)
    {
        logger.info("登录认证页面!");
        ModelAndView mv = new ModelAndView("login");
        return  mv;
    }

    @RequestMapping("/testsql")
    public String testsql() {
        SqlUtil sqlUtil = new SqlUtil();
        try {
            sqlUtil.importSql();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("123");
        return "123";

    }
}
