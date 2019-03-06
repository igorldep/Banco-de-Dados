package servicoBD;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author @author Igor Luciano - Igor Lacerda - Eduardo Junqueira
 */
public class CadastrarDAO {

    private Conexao con;

    public CadastrarDAO(Conexao con) {
        this.con = con;
    }

    public boolean getCadastro(String cpf, String nome, String email, String username, String password) {
        boolean result = false;

        String sqlCliente = "INSERT INTO cliente VALUES('" + cpf + "', '" + nome + "', '" + email + "');";
        String sqlUsuario = "INSERT INTO usuario VALUES('" + username + "', '" + cpf + "', '" + password + "');";

        try {
            if (!verificaCPF(cpf)) {
                System.out.println("Log: CPF válido");
                if(!verificaUSERNAME(username)){
                    System.out.println("Log: Username válido");
                    Statement stm = con.getCon().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    stm.execute(sqlCliente);

                    stm.execute(sqlUsuario);

                    System.out.println("Log: Cadastro Realizado");
                    result = true;
                }
                else{
                    System.out.println("Log: Username inválido");
                    result = false;
                }
                
            }
            else{
                System.out.println("Log: CPF inválido");
                result = false;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.println("CATCH - Log: Cadastro Não Realizado");
            result = false;

        } finally {
            //con.fechaConexao();
        }
        return result;
    }
    
    public boolean verificaCPF(String cpf){
        boolean result = false;
        
	String sql = "SELECT * FROM cliente c WHERE c.cpf = '" + cpf + "';";
        
        try {
            Statement stm = con.getCon().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            stm.execute(sql);
            ResultSet rs = stm.getResultSet();
            rs.last();
            
            if (rs.getRow() > 0){
                result = true;
            }
            else{
                result = false;
            }
                  
	} catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Log: Catch");
            result = false;
                
	} finally {
                //con.fechaConexao();
        }
        return result;
    }
    
    public boolean verificaUSERNAME(String username){
        boolean result = false;
        //String[] resultado = null;
	String sql = "SELECT * FROM usuario u WHERE u.usuario = '" + username + "';";
        
        try {
            Statement stm = con.getCon().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            stm.execute(sql);
            ResultSet rs = stm.getResultSet();
            rs.last();
            if (rs.getRow() > 0){
                result = true;
            }
            else{
                result = false;
            }
                  
	} catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Log: Catch");
            result = false;
                
	} finally {
                //con.fechaConexao();
        }
        return result;
    }
}
