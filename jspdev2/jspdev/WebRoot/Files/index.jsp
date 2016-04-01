<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>多文件上传</title>
    
  </head>
  
  <body>
      <s:form action="upload.action" method="post" enctype="multipart/form-data">
      <s:file name="upload" label="上传的文件一"></s:file>
      <s:file name="upload" label="上传的文件二"></s:file>
      <s:file name="upload" label="上传的文件三"></s:file>
      <s:submit value="上传"></s:submit>
      </s:form>
  </body>
</html>
