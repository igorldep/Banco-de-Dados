package servicoBD;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Igor Luciano - Igor Lacerda - Eduardo Junqueira
 */
public class LoginDAO {
 private Conexao con;

 public LoginDAO(Conexao con){
     this.con = con;
 }

    LoginDAO() {
        throw new UnsupportedOperationException("Not supported yet."); 
    }
 public boolean getLogin(String username, String password){
        boolean result = false;
        
	String sql = "SELECT * FROM usuario u WHERE u.usuario = '" + username + "' AND u.senha = '" + password + "';" ;
	try {
		Statement stm = con.getCon().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		stm.execute(sql);
		ResultSet rs = stm.getResultSet();
		rs.last();
                
		if (rs.getRow() > 0){
                        System.out.println("Log: Encontrado");
                        result = true;
                        
                        //AQUI PODE TER UM OUTRA FUNÇÃO QUE FAZ UM INNER JOIN NO BD E DA "Olá, 'nomedousuário'"
                        
		}
                else{
                    System.out.println("Log: Não encontrado");
                    result = false;
                }
	} catch (SQLException e) {
		e.printStackTrace();
                
	} finally {
                //con.fechaConexao();
        }
        return result;
    }
}


