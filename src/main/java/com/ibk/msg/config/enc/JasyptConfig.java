package com.ibk.msg.config.enc;

import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.PooledPBEStringEncryptor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimpleStringPBEConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 관련 싸이트 참고 하세요 https://elfinlas.github.io/2017/12/21/jsaypt/
 */
@Configuration
public class JasyptConfig {

	private static final String JAS_PASSWORD = "ibk";

	@Bean("jasyptStringEncryptor")
	public StringEncryptor jasyptStringEncryptor() {
		PooledPBEStringEncryptor encryptor = new PooledPBEStringEncryptor();
		SimpleStringPBEConfig config = new SimpleStringPBEConfig();
		config.setPassword(JAS_PASSWORD); //암호화에 사용할 키 -> 중요
		config.setAlgorithm("PBEWithMD5AndDES"); //사용할 알고리즘
		config.setKeyObtentionIterations("1000");
		config.setPoolSize("1");
		//    config.setProviderName("SunJCE");
		config.setSaltGeneratorClassName("org.jasypt.salt.RandomSaltGenerator");
		config.setStringOutputType("base64");
		encryptor.setConfig(config);
		return encryptor;
	}

	public static void main(String[] args) {
		StandardPBEStringEncryptor jasypt = new StandardPBEStringEncryptor();
		jasypt.setPassword(JAS_PASSWORD);      //암호화 키(password)
		jasypt.setAlgorithm("PBEWithMD5AndDES");

		if(args.length > 0){
			String pw = args[0];
			String encryptedText = jasypt.encrypt(pw);    //암호화
			String plainText1 = jasypt.decrypt(encryptedText);  //복호화

			System.out.println("encryptedText:  " + encryptedText); //암호화된 값
			System.out.println("plainText1:  " + plainText1);         //복호화된 값
		}else{
			String encryptedText = jasypt.encrypt("sms_kiup");    //암호화
			String plainText1 = jasypt.decrypt("ZyvYe+xcpuiAFatl8dGwD1E1UEgIU1Rj");  //복호화
			String plainText2 = jasypt.decrypt("4YLVdG2MitUc1n6LtmS17g==");  //복호화
			String plainText3 = jasypt.decrypt("MqDRest43d5arS6Vm9mbrw==");  //복호화

			System.out.println("encryptedText:  " + encryptedText); //암호화된 값
			System.out.println("plainText1:  " + plainText1);         //복호화된 값
			System.out.println("plainText2:  " + plainText2);         //복호화된 값
			System.out.println("plainText3:  " + plainText3);         //복호화된 값
		}
	}

}
