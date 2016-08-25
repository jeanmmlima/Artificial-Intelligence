/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aestrela;
import aestrela.No;
import aestrela.AEstrela;

/**
 *
 * @author jeanmarioml
 */
public class Teste1 {
    
      /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        
        // TODO code application logic here
        
        No[][] grade = new No[10][10];
        for (int i = 0; i < grade.length; i++) {
            for (int j = 0; j < grade[i].length; j++) {
                grade[i][j] = new No(i, j);
            }
        }

        //configura grade 
        No origem = grade[1][5];
        No destino = grade[9][5];

        AEstrela aStar = new AEstrela(origem, destino,grade);
        aStar.adicionarObstaculo(grade[4][3]);
        aStar.adicionarObstaculo(grade[4][4]);
        aStar.adicionarObstaculo(grade[4][5]);
        aStar.adicionarObstaculo(grade[4][6]);
        aStar.adicionarObstaculo(grade[4][7]);
        aStar.adicionarObstaculo(grade[8][4]);
        aStar.adicionarObstaculo(grade[9][4]);

        long tempo1 = System.nanoTime();
        boolean pesquisaOk = aStar.iniciarBusca();
        long tempo2 = System.nanoTime();
        System.out.println("Tempo de pesquisa: " + (tempo2 - tempo1) + "ns");

        if (pesquisaOk) {
            System.out.println("Caminho:");
            System.out.println("X\tY");

            //lista caminho encontrado
            for (int i = 0; i < aStar.getCaminho().size(); i++) {
                System.out.println(aStar.getCaminho().get(i).getPosX()
                        + "\t" + aStar.getCaminho().get(i).getPosY());
            }
        } else {
            System.out.println("Caminho nao foi encontrado.");
        }

        //imprime em forma de matriz
        for (int i = 0; i < grade.length; i++) {
            System.out.println("");
            for (int j = 0; j < grade[i].length; j++) {
                if (origem.getPosX() == i && origem.getPosY() == j) {
                    System.out.print("[O]");
                } else if (destino.getPosX() == i && destino.getPosY() == j) {
                    System.out.print("[D]");
                } else {
                    boolean isCaminho = false;
                    for (int k = 0; k < aStar.getCaminho().size(); k++) {
                        if (aStar.getCaminho().get(k).getPosX() == i && aStar.getCaminho().get(k).getPosY() == j) {
                            System.out.print("[*]");
                            isCaminho = true;
                            break;
                        }
                    }
                    boolean isBloqueio = false;
                    for (int k = 0; k < aStar.getObstaculos().size(); k++) {
                        if (aStar.getObstaculos().get(k).getPosX() == i && aStar.getObstaculos().get(k).getPosY() == j) {
                            System.out.print("[X]");
                            isBloqueio = true;
                            break;
                        }
                    }
                    if (!isCaminho && !isBloqueio) {
                        System.out.print("[ ]");
                    }
                }

            }
        }
        System.out.println("");
    }
    
}
