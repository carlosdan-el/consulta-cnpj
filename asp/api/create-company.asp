<%
  set conn=Server.CreateObject("ADODB.Connection")
  conn.open "DRIVER={MySQL ODBC 8.0 Unicode Driver}; SERVER=localhost; PORT=3306; DATABASE=MYSQL_DATABASE; UID=root; PWD=123456; OPTION=3;"

  Response.ContentType = "application/json"
    
  sql = "INSERT INTO tbCompany (razaoSocial, cnpj,"
  sql = sql & "logadouro, numero, complemento, municipio, uf)"
  sql = sql & " VALUES "
  sql = sql & "('" & Request.Form("razaoSocial") & "',"
  sql = sql & "'" & Request.Form("cnpj") & "',"
  sql = sql & "'" & Request.Form("logadouro") & "',"
  sql = sql & "'" & Request.Form("numero") & "',"
  sql = sql & "'" & Request.Form("complemento") & "',"
  sql = sql & "'" & Request.Form("municipio") & "',"
  sql = sql & "'" & Request.Form("uf") & "')"

  on error resume next
  conn.Execute sql, recaffected
  
  If err <> 0 Then
    Response.Status = "400"
    Response.Write("{""code"": 400, ""message"": ""Falha ao tentar inserir dados no banco.""}")
  Else
    Response.Status = "200"
    Response.Write("{""code"": 200, ""message"": ""Empresa cadastrada com sucesso.""}")
  End if
  
  conn.close
%>  