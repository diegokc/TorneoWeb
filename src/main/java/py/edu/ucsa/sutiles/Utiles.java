package py.edu.ucsa.sutiles;

import java.util.Objects;

public class Utiles {

	public static Long valLong(String pValor) {

		Long nro = 0L;

		try {
			nro = Long.parseLong(pValor.trim());

		} catch (NumberFormatException excepcion) {
			nro = 0L;
		}
		return nro;

	}

	public static Integer valInteger(String pValor) {

		Integer nro = 0;

		try {
			nro = Integer.parseInt(pValor.trim());

		} catch (NumberFormatException excepcion) {
			nro = 0;
		}
		return nro;

	}
	
	public static boolean tieneDato(String[] lista, String valor) {
		boolean retorno=false;
		if(!Objects.isNull(lista)) {
			for (int i = 0; i < lista.length; i++) {
				if( valor.equals( lista[i] ) ) {
					retorno=true;
					break;
				} 
			}
		}
		return retorno;
		
	}
	
}
