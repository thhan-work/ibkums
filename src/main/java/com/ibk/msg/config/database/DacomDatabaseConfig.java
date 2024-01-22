package com.ibk.msg.config.database;

import javax.sql.DataSource;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(basePackages = "com.ibk.msg.web", sqlSessionFactoryRef = "dacomSessionFactory",
annotationClass = DacomRepository.class)
public class DacomDatabaseConfig {

	@Bean
	@ConfigurationProperties(prefix = "spring.dacom-dist.datasource.hikari")
	public DataSource dacomDataSource() {
		return new HikariDataSource();
	}

	@Bean
	public SqlSessionFactory dacomSessionFactory(
			@Qualifier("dacomDataSource") DataSource dataSource,
			ApplicationContext applicationContext) throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource);
		sqlSessionFactoryBean
		.setMapperLocations(applicationContext.getResources("classpath:mapper/**/*.xml"));
		sqlSessionFactoryBean.getObject().getConfiguration().setJdbcTypeForNull(JdbcType.NULL);
		sqlSessionFactoryBean.getObject().getConfiguration().setMapUnderscoreToCamelCase(true);
		sqlSessionFactoryBean.getObject().getConfiguration().setCacheEnabled(true);
		sqlSessionFactoryBean.getObject().getConfiguration().setDefaultStatementTimeout(60);
		sqlSessionFactoryBean.getObject().getConfiguration().setDefaultExecutorType(ExecutorType.REUSE);
		return sqlSessionFactoryBean.getObject();
	}

	@Bean
	public DataSourceTransactionManager dacomTxManager() {
		return new DataSourceTransactionManager(dacomDataSource());
	}

}
