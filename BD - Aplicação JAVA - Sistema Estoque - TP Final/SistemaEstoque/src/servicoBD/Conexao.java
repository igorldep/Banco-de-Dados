package servicoBD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Igor Luciano - Igor Lacerda - Eduardo Junqueira
 */
public class Conexao {
    private Connection conexao = null;

    public Conexao() {
       try{     //ALTERAR CONEXAO
            conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/TP_FINAL","SistemaEstoque","senha");
       }
       catch (SQLException e) {
            System.out.println("Erro na conexao");
            e.printStackTrace();
	}
    }
    
    public void fechaConexao(){
            try {
                conexao.close();
            } catch (SQLException ex) {
                Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
	public Connection getCon() {
		return conexao;
	}
}
