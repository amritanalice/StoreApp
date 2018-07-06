package com.ibm.mr.inventory.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;


@Component
@PropertySource("classpath:usercredentials.properties")

public class UserCredentials {

}
