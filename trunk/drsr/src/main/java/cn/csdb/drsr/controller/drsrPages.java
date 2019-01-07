package cn.csdb.drsr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class drsrPages {
    @RequestMapping("/dataUpload")
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView("datatask");
        return modelAndView;
    }
    @RequestMapping("/dataSource")
    public ModelAndView index2() {
        ModelAndView modelAndView = new ModelAndView("dataSource");
        return modelAndView;
    }
    @RequestMapping("/createTask")
    public ModelAndView index3() {
        ModelAndView modelAndView = new ModelAndView("createTask");
        return modelAndView;
    }



}
