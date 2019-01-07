package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.Subject;
import cn.csdb.drsr.service.SubjectInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
public class SubjectInfoController {
    private Logger logger = LoggerFactory.getLogger(SubjectInfoController.class);
    @Resource
    private SubjectInfoService subjectInfoService;


    @RequestMapping("/subjectInfo")
    public ModelAndView getSubjectInfo() {
        Subject subject = subjectInfoService.getSubjectInfo();
        ModelAndView mv = new ModelAndView("subjectInfo");
        mv.addObject("subject", subject);
        return mv;
    }
}
