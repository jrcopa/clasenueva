<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/gal_css.css" />
        <link rel="stylesheet" href="./css/sidebar_css.css" />
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <title>Listado de cursos</title>
    </head>
    <body>
        <div id="main">  
            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = null;            
                String insertAlus ="INSERT INTO tb_alus (apyn, dni,estado) VALUES (?,?,0)";
                
                String insertRel = "INSERT INTO alus_curs (id_alus, id_curs) VALUES "
                        + "((SELECT id_alus FROM tb_alus WHERE dni=?),"
                        + "(SELECT id_curs FROM tb_curs WHERE nom_curs=?))";
                String selectInsc= "SELECT inscriptos FROM tb_curs WHERE nom_curs=?";
                String updateInsc= "UPDATE tb_curs SET inscriptos=? where nom_curs=?";/*Se incrementa la cantidad de inscriptos a los cursos*/
               
                PreparedStatement consultaAlus = null;
                PreparedStatement consultaRel = null;
                PreparedStatement consultaInsc = null;
                PreparedStatement consultaUpdate = null;
                
                String vApyn=request.getParameter("apyn");/*getParamenter recupera el dato desde una pagina web*/
                String vDni= request.getParameter("dni");
                String vCurso=request.getParameter("cursos");
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba1", "root", "");
                    consultaAlus = conexion.prepareStatement(insertAlus);
                    consultaAlus.setString(1, vApyn);/*getString recupera el dato de una cadena de caracteres, de listaInsc*/
                    consultaAlus.setString(2, vDni);
                    consultaAlus.execute();
                    
                    consultaRel = conexion.prepareStatement(insertRel);
                    consultaRel.setString(1, vDni);
                    consultaRel.setString(2, vCurso);
                    consultaRel.execute();
                    
                    consultaInsc = conexion.prepareStatement(selectInsc);
                    consultaInsc.setString(1, vCurso);
                    ResultSet listaInsc = consultaInsc.executeQuery();/*Contiene la cantidad de inscriptos*/
                    listaInsc.next();
                    
                    /*out.print("Inscriptos"+ listaInsc.getObject("inscrit}ptos"));*/
                    int vInscriptos = (Integer)listaInsc.getObject("inscriptos");/*getObject recupera el dato del objeto vInscriptos*/
                    vInscriptos= vInscriptos+1; /*Aumenta la cantidad de alumnos*/
                    
                    consultaUpdate = conexion.prepareStatement(updateInsc);
                    consultaUpdate.setInt(1,vInscriptos)
                    consultaUpdate.setString(2, request.getParameter("cursos"));
                    consultaUpdate.execute();
                    
                    out.print("FELICIDADES TE INSCRIBISTE");
                } catch (Exception e) {
                    e.printStackTrace();
                   /* out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");
                    out.println(consultaAlus + "</br>");
                    out.println(consultaRel + "</br>");*/
                } finally {
                    try {
                    
                        consultaAlus.close();
                        consultaRel.close();
                        consultaInsc.close();
                        consultaUpdate.close();
                        
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
        </div>        
    </body>
</html>
