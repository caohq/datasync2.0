package cn.csdb.portal.controller;

import cn.csdb.portal.model.User;
import cn.csdb.portal.service.CheckUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by shiba on 2018/11/6.
 */
@Controller
public class CheckUserController {
    @Resource
    private CheckUserService checkUserService;

    @RequestMapping("/login")
        public String login(User user, HttpServletRequest request) {

            //获取当前用户
            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginId(), user.getPassword());
            try {
                if(user.getUserName()==null&&user.getPassword()==null){
                    return "loginNew";
                }else {
                    //为当前用户进行认证，授权
                    subject.login(token);
                    User u = checkUserService.getByUserName(user.getLoginId());
                    boolean flag = false;
                    if(u.getRole()==""||u.getRole()==null){
                        request.setAttribute("errorMsg", "请为该账号赋予可用角色！");
                        return "loginNew";
                    }
                    Set<String> roles = new HashSet<>();
                        roles.add(u.getRole());
                        if (u.getRole().equals("系统管理员")) {
                            flag = true;
                        } else if (u.getRole().equals("数据节点管理员")) {
                            flag = true;
                        } else {

                        }
                    if(!flag){
                        request.setAttribute("errorMsg", "请为该账号赋予可用角色！");
                        return "loginNew";
                    }
                    if (u.getSubjectCode() != null) {
                        cn.csdb.portal.model.Subject sub = checkUserService.getSubjectByCode(u.getSubjectCode());
                        if(sub==null){
                            request.getSession().setAttribute("userName", u.getUserName());
                            request.getSession().setAttribute("LoginId", u.getLoginId());
                            request.getSession().setAttribute("roles", roles);
                        }else {
                            request.getSession().setAttribute("DbName", sub.getDbName());
                            request.getSession().setAttribute("SubjectName", sub.getSubjectName());
                            request.getSession().setAttribute("SubjectCode", sub.getSubjectCode());
                            request.getSession().setAttribute("FtpFilePath", sub.getFtpFilePath());
                            request.getSession().setAttribute("userName", u.getUserName());
                            request.getSession().setAttribute("LoginId", u.getLoginId());
                            request.getSession().setAttribute("roles", roles);
                        }
                    }else{
                        request.getSession().setAttribute("userName", u.getUserName());
                        request.getSession().setAttribute("LoginId", u.getLoginId());
                        request.getSession().setAttribute("roles", roles);
                    }
                    return "redirect:/loginSuccess";
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("user", user);
                if(user.getUserName()==null&&user.getPassword()==null){
                    request.setAttribute("errorMsg", "");
                }else {
                    request.setAttribute("errorMsg", "用户名或密码错误！");
                }
                return "loginNew";
            }
        }

        @RequestMapping("/loginSuccess")
        public String loginSuccess(HttpServletRequest request, Model model) {
            //xiajl20181207
            String loginid = "";
            if (request.getSession().getAttribute("LoginId") != null) {
                loginid = request.getSession().getAttribute("LoginId").toString();
            }

            User u = checkUserService.getByUserName(loginid);
            cn.csdb.portal.model.Subject subject = null;
            if (u.getSubjectCode() != null) {
                subject = checkUserService.getSubjectByCode(u.getSubjectCode());
                model.addAttribute("subject", subject);
            }

            return "index";
        }
}