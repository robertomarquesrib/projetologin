<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
    </head>
    <body>
        <%
                String nome = (String) session.getAttribute("nomeUsuario");
                
                if(nome == null){
                    response.sendRedirect("index.jsp");
                }
            %>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Lista</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarText">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
          </ul>
          <span class="navbar-text">
                Bem vindo <%out.println(nome);%> 
                <a href="sair.jsp" class="btn btn-outline-danger">Sair</a>
          </span>
        </div>
      </nav>
                
                <div class="row mt-4 mb-4">
                <button class="btn-info" data-toggle="modal" data-target="#exampleModal">Novo Usuário</button>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" name="txtbuscar" placeholder="Digite um nome" aria-label="Search">
                    <button class="btn btn-outline-info my-2 my-sm-0" type="submit">Buscar</button>
                </form>
            </div>
      <table class="table table-sm">
        <thead>
          <tr>
            <th scope="col">Cod</th>
            <th scope="col">Nome</th>
            <th scope="col">Email</th>
            <th scope="col">Nível</th>
            <th scope="col">Senha</th>
          </tr>
        </thead>
        <tbody>
          <%
                        Statement st = null;
                        ResultSet rs = null;     
                        
                        String senha_usuario = "";
                        String nivel_usuario = "";
                        String id_usuario = "";
                        String nome_usuario = "";
                        String email_usuario = "";
                        
                        try{
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM pessoas");
                            while(rs.next()){
                    %>
                  <tr>
                    <th scope="row"><%= rs.getString(1) %></th>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getString(5) %></td>
                    <td><%= rs.getString(4) %></td>
                  </tr>
                  
                   <%
                            }
                        }catch(Exception e){
                            out.println(e);
                        }
                    %>
        </tbody>
      </table>  
      <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </body>
</html>


<div class="modal" id="exampleModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        <form action="usuarios.jsp">
      <div class="modal-body">
          <input type="text" name="nome" id="nome" placeholder="Nome:" class="form-control" required>
          <input type="text" name="email" id="email" placeholder="Email" class="form-control" required>
          <input type="password" name="senha" id="senha" placeholder="Senha:" class="form-control" required>
          <select class="custom-select" name="nivel" id="validationCustom04" required>
            <option selected disabled>Nível</option>
            <option value="Comum">Comum</option>
            <option value="Administrador">Administrador</option>
          </select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" name="btn-salvar" class="btn btn-primary">Enviar</button>
      </div>
        </form>
    </div>
  </div>
</div>

<%
    
    if (request.getParameter("btn-salvar") != null) {
            String nome_cadastro = request.getParameter("nome");
            String email_cadastro = request.getParameter("email");
            String senha_cadastro = request.getParameter("senha");
            String nivel_cadastro = request.getParameter("nivel");
            
            try{
                
                st = new Conexao().conectar().createStatement();
                
                rs = st.executeQuery("SELECT * FROM pessoas WHERE email = '"+ email_cadastro +"'");
                while(rs.next()){
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("<script>alert('Usuario ja cadastrado')</script>");
                            return;
                        }
                }
                
                st.executeUpdate("INSERT INTO pessoas (nome, email, senha, nivel) VALUES ('"+nome_cadastro+"','"+email_cadastro+"','"+senha_cadastro+"','"+nivel_cadastro+"')");
                
            }catch(Exception e){
                out.println(e);
            }
            
        }

%>