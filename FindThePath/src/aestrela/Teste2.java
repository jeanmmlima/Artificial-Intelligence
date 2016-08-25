/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aestrela;

/**
 *
 * @author jeanmarioml
 */
public class Teste2 {
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        
        // TODO code application logic here
        
        No[][] grade = new No[5][5];
        for (int i = 0; i < grade.length; i++) {
            for (int j = 0; j < grade[i].length; j++) {
                grade[i][j] = new No(i, j);
            }
        }

        //configura grade 
        No origem = grade[0][0];
        No destino = grade[4][4];

       DFS dFS = new DFS(origem,destino,grade);
        dFS.adicionarObstaculo(grade[1][2]);
        dFS.adicionarObstaculo(grade[2][2]);
        dFS.adicionarObstaculo(grade[3][2]);
        dFS.adicionarObstaculo(grade[4][2]);
        dFS.adicionarObstaculo(grade[1][3]);
        

        long tempo1 = System.nanoTime();
        boolean pesquisaOk = dFS.iniciarBusca();
        long tempo2 = System.nanoTime();
        System.out.println("Tempo de pesquisa: " + (tempo2 - tempo1) + "ns");

        if (pesquisaOk) {
            System.out.println("Caminho:");
            System.out.println("X\tY");

            //lista caminho encontrado
            for (int i = 0; i < dFS.getCaminho().size(); i++) {
                System.out.println(dFS.getCaminho().get(i).getPosX()
                        + "\t" + dFS.getCaminho().get(i).getPosY());
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
                    for (int k = 0; k < dFS.getCaminho().size(); k++) {
                        if (dFS.getCaminho().get(k).getPosX() == i && dFS.getCaminho().get(k).getPosY() == j) {
                            System.out.print("[*]");
                            isCaminho = true;
                            break;
                        }
                    }
                    boolean isBloqueio = false;
                    for (int k = 0; k < dFS.getObstaculos().size(); k++) {
                        if (dFS.getObstaculos().get(k).getPosX() == i && dFS.getObstaculos().get(k).getPosY() == j) {
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
