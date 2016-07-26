<%--
  Created by IntelliJ IDEA.
  User: svt
  Date: Nov 10, 2010
  Time: 10:40:56 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Simple GSP page</title></head>
  <body>
  <g:form controller="editor" method="post" action="upload" 
  enctype="multipart/form-data">
    <input type="file" name="file"/>
    <input type="submit"/>
</g:form>
  </body>
</html>