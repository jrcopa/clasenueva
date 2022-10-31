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
            <form id="alta" method="post" action="alta_alus_op.jsp">
                NOMbRE: <input type="text" name="apyn" /></be>
                DNI: <input type="text" name="dni" /></br>
                <input type="submit" value="Aceptar">
            </form>
            <select name="cursos" id="curs" form="alta">
            <%
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = null;            
                String consulta ="SELECT nom_curs FROM tb_curs";
                PreparedStatement consultaCursos = null;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba1", "root", "");
                    consultaCursos = conexion.prepareStatement(consulta);
                    ResultSet listaCursos = consultaCursos.executeQuery();
                    while (listaCursos.next()) {
                        String nombreCurso= listaCursos.getString("nom_curs");
                        out.print("<option value='"+ nombreCurso +"'> "+ nombreCurso +" </option>");
                   
                    }                   
                    listaCursos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");
                    //out.println(consultaHorarios + "</br>");
                    //.println(consultaCursos + "</br>");
                } finally {
                    try {
                    
                        consultaCursos.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
            </select> 
        </div>        
    </body>
</html>
