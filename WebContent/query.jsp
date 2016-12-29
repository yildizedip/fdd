<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="botdetect.web.Captcha"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BotDetect CAPTCHA Basic JSP Example</title>
    <link rel="stylesheet" href="stylesheet.css" type="text/css"/>
  </head>
  <body>
    <form action="query.jsp" method="post">
      <h1>BotDetect CAPTCHA Basic JSP Example</h1>
      <fieldset>
        <legend>CAPTCHA Validation</legend>
        <label for="captchaCode" class="prompt">
        Retype the code from the picture:</label>
        <%
        // Adding BotDetect Captcha to the page
        Captcha captcha = Captcha.load(request, "basicCaptcha");
        captcha.setUserInputClientId("captchaCode");
        captcha.renderCaptchaMarkup(pageContext.getServletContext(), 
        pageContext.getOut());
        %>
        <div class="validationDiv">
          <input id="captchaCode" type="text" name="captchaCode" />
          <input type="submit" name="validate" value="Validate" />&nbsp;
          <%
          // when the form is submitted
          if("POST".equalsIgnoreCase(request.getMethod())){
            // validate the Captcha to check we're not dealing with a bot
            boolean isHuman = captcha.validate(request,
                  request.getParameter("captchaCode"));
            if (isHuman) {
              // Captcha validation passed, perform protected action
              out.print("<span class=\"correct\">Correct.</span>");
            } else {
              // Captcha validation failed, show error message
              out.print("<span class=\"incorrect\">Incorrect!</span>");
            }
          }
          %>
        </div>
      </fieldset>
    </form>
  </body>
</html>