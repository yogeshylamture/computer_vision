function gmail_settings(my_mail,password)

% Define these variables appropriately:
%my_mail    %Your GMail email address
%password   %Your GMail password

% Then this code will set up the preferences properly:
setpref('Internet','E_mail',my_mail);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',my_mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

