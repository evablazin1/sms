package com.education.web.helper;

import javax.annotation.PostConstruct;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class MailHelper {
	
	private static final Logger logger 												= LoggerFactory.getLogger(MailHelper.class);
	
	private static JavaMailSender mailSender;
	
	@Value("${email.from.address}")
	private String fromaddress;
	
	private static String fromAddress;
	
	@PostConstruct
	public void initializeDependency(){
		fromAddress			=	this.fromaddress;
	}
	

	
	public void sendMail(String subject,String emailAddress, String profileNumber,String pinNumber){
			try{
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to send mail to : " + emailAddress);
				
				MimeMessage message													= mailSender.createMimeMessage();
				MimeMessageHelper helper 											= new MimeMessageHelper(message, true);
				
				helper.setFrom(fromAddress);
				helper.setTo(emailAddress);
				helper.setSubject(subject);
				
				//If you have anything nice to say,else just send the attachment alone :)
				helper.setText("You have been successfully registered to the school management system.Please find your temporary login details below : \n" +
								"Profile Number 	: " + profileNumber + "\n" +
								"Pin Number	: " + pinNumber	+ "\n\n" +
								"Remember to change your pin number on initial login");
				//helper.addAttachment(file.getName(), file);
		
					try{
						mailSender.send(message); 
						logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully sent mail to : " + emailAddress);					
					
					}catch(MailException ex) {
						logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + ex.getMessage());
					}
					
					
			}catch(MessagingException m){
				logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + m.getMessage()); 
			}
	}



	public static JavaMailSender getMailSender() {
		return mailSender;
	}



	public static void setMailSender(JavaMailSender mailSender) {
		MailHelper.mailSender = mailSender;
	}

}
