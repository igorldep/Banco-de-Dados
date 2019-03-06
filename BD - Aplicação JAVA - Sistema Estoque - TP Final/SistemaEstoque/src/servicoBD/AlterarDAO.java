package servicoBD;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Igor Luciano - Igor Lacerda - Eduardo Junqueira
 */
public class AlterarDAO {
 private Conexao con;

 public AlterarDAO(Conexao con){
     this.con = con;
 }
 
    public boolean getAltera(String username, String password){
        boolean result = false;
	String sql = "UPDATE usuario SET senha = '" + password + "' WHERE usuario = '" + username + "';";
        
        try {
            if(verificaUsuario(username)){
                System.out.println("Log: Usuário logado e válido");
		Statement stm = con.getCon().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		stm.execute(sql);
                
                System.out.println("\nLog: Atualizado");
                result = true;
            }
            else{
                System.out.println("Log: Usuário inválido");
                System.out.println("Log: Não atualizado");
                result = false;
            }
                  
	} catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Log: CATCH - Não atualizado");
            result = false;
                
	} finally {
                //con.fechaConexao();
        }
        return result;
    }
    
    public boolean verificaUsuario(String username){
        boolean result = false;
	String sql = "SELECT * FROM usuario u WHERE u.usuario = '" + username + "';";
        
        try {
            Statement stm = con.getCon().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            stm.execute(sql);
            ResultSet rs = stm.getResultSet();
            rs.last();
            if (rs.getRow() > 0){
                System.out.println("\nLog: Atualizado");
                result = true;
            }
            else{
                System.out.println("Log: Usuário inválido");
                System.out.println("Log: Não atualizado");
                System.out.println(sql);
                result = false;
            }
                  
	} catch (SQLException e) {
            e.printStackTrace();
            System.out.println("CATCH - Log: Não atualizado");
            System.out.println(sql);
            result = false;
                
	} finally {
                //con.fechaConexao();
        }
        return result;
    }
}


