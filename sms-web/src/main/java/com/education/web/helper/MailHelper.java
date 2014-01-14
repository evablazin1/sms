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
	private String fromAddress;
	
	private static String newFromAddress;
	
	@PostConstruct
	public void initializeDependency(){
		newFromAddress			=	this.fromAddress;
	}
	

	
	public void sendMail(String subject,String[] emailAddress,String username,String password){
			try{
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to send mail to : " + emailAddress);
				MimeMessage message								= mailSender.createMimeMessage();
				MimeMessageHelper helper 						= new MimeMessageHelper(message, true);
				
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> from address : " + newFromAddress);
				helper.setFrom(newFromAddress);
				helper.setTo(emailAddress);
				helper.setSubject(subject);
				//If you have anything nice to say,else just send the attachment alone :)
				helper.setText("You have been successfully registered to the school management system.Please find your temporary login details below : \n" +
								"Username 	: " + username + "\n" +
								"Password	: " + password	+ "\n\n" +
								"Remember to change your login details on initial login");
				//helper.addAttachment(file.getName(), file);
		
					try{
						mailSender.send(message); 
						for(String email:emailAddress ){
							logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully sent mail to : " + email);
						}
					
					
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



	public String getFromAddress() {
		return this.fromAddress;
	}



	public  void setFromAddress(String fromAddress) {
		this.fromAddress = fromAddress;
	}

}
