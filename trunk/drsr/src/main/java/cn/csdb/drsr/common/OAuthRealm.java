package cn.csdb.drsr.common;

import com.alibaba.fastjson.JSON;
import com.google.common.base.Strings;
import com.google.common.collect.Sets;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;


/**
 * Created by admin on 2018/9/19.
 */
public class OAuthRealm extends AuthorizingRealm {

    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String username = (String) principalCollection.fromRealm(getName()).iterator().next();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        //String roles = HTTPAccess.getRoles(username);

        String roles = "admin";
        if (Strings.isNullOrEmpty(roles)) {
            return authorizationInfo;
        }
        authorizationInfo.setRoles(Sets.newHashSet(JSON.parseArray(roles, String.class)));

        return authorizationInfo;
    }

    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        /*UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        String username = token.getUsername();
        if (StringUtils.isNotEmpty(username)) {
            String userJson = HTTPAccess.getUserInfo(username);
            if (userJson != null)
                return new SimpleAuthenticationInfo(username, token.getPassword(), getName());
        }*/
        return null;
    }
}
