package cn.csdb.drsr.service;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.Properties;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-11 10:57
 **/
@Service
public class ConfigPropertyService {
    private Properties drsrProperties;

    @PostConstruct
    private void initWac() throws IOException {
        ClassPathResource classPathResource = new ClassPathResource("/config.properties");
        drsrProperties = PropertiesLoaderUtils.loadProperties(classPathResource);
    }

    public String getProperty(String propertyName){
        return drsrProperties.getProperty(propertyName).toString();
    }
}
