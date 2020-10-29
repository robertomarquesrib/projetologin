<%@page import="config.Conexao"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <%
    Statement st = null;
    ResultSet rs = null;
%>
    <body>
        <h3 class="text-center">Formulário de Login</h3>
        <div class="container">
            <form class="form" action="index.jsp" method="post">
                <div class="form-group">
                    <label>Usuário</label><br>
                    <input type="email" name="email" id="email" class="form-control">
                </div>
                <div class="form-group">
                    <label for="password">Senha</label><br>
                    <input type="password" name="senha" id="senha" class="form-control">
                </div>
                <div class="form-group">

                    <input type="submit" name="submit" class="btn btn-info btn-block" value="Login">
                </div>
                <p>
                 <%
                        String user = request.getParameter("email");
                        String pass = request.getParameter("senha");
                        String nomeUsuario = "";
                        
                        String usuario = "";
                        String senha = "";
                        
                        int i = 0;

                        try{
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM pessoas WHERE email = '"+ user +"' and senha = '" + pass + "'");
                              
                            while(rs.next()){
                                nomeUsuario = rs.getString(2);
                                usuario = rs.getString(3);
                                senha = rs.getString(4);                        
                                rs.last();
                                i = rs.getRow();
                            }

                        }catch(Exception e){
                            out.println(e);
                        }

                        if(user == null || pass == null){
                            out.println("PREENCHER OS DADOS");
                        } else{
                            if(i>0){
                                session.setAttribute("nomeUsuario", nomeUsuario);
                                response.sendRedirect("usuarios.jsp");
                            }
                        }
    %>
                </p>
            </form>
        </div>
</body>
</html>