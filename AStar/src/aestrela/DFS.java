/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aestrela;

import java.util.ArrayList;

/**
 *
 * @author jeanmarioml
 */
public class DFS {
    
    private float custoCaminho = 0;
    private float menorCusto = 99999;
    private No origem;
    private No destino;
    private No[][] matriz;
    
    private ArrayList<No> pilha;
    private ArrayList<No> percorridos;
    private ArrayList<No> caminho;
    private ArrayList<No> menorCustoCaminho;
    private ArrayList<No> obstaculos;
    
    private float pesoHor;
    private float pesoVer;
    private float pesoDia;
    
    
    public DFS(No _origem, No _destino, No[][] _matriz){
        this.origem = _origem;
        this.destino = _destino;
        this.matriz = _matriz;
        pilha = new ArrayList();
        percorridos = new ArrayList();
        obstaculos = new ArrayList();
        caminho = new ArrayList();
        menorCustoCaminho = new ArrayList();
        pesoHor = 1;
        pesoVer = 1;
        pesoDia = (float) 1.414;
    }

    public float getCustoCaminho() {
        return custoCaminho;
    }

    public void setCustoCaminho(float custoCaminho) {
        this.custoCaminho = custoCaminho;
    }

    public float getMenorCusto() {
        return menorCusto;
    }

    public void setMenorCusto(float menorCusto) {
        this.menorCusto = menorCusto;
    }

    public No[][] getMatriz() {
        return matriz;
    }

    public void setMatriz(No[][] matriz) {
        this.matriz = matriz;
    }

    public ArrayList<No> getPilha() {
        return pilha;
    }

    public void setPilha(ArrayList<No> pilha) {
        this.pilha = pilha;
    }

    public ArrayList<No> getPercorridos() {
        return percorridos;
    }

    public void setPercorridos(ArrayList<No> percorridos) {
        this.percorridos = percorridos;
    }

    public ArrayList<No> getMenorCustoCaminho() {
        return menorCustoCaminho;
    }

    public void setMenorCustoCaminho(ArrayList<No> menorCustoCaminho) {
        this.menorCustoCaminho = menorCustoCaminho;
    }
    
    public No getDestino(){
        return destino;
    }
    
    public No getOrigem(){
        return origem;
    }
    
    public ArrayList<No> getCaminho(){
        return menorCustoCaminho;
    }
    
    public ArrayList<No> getObstaculos(){
        return obstaculos;
    }
    
    public void adicionarObstaculo(No _obstaculo){
        obstaculos.add(_obstaculo);
    }
    
    public boolean caminho() {
        No atual = getDestino();

        if (atual == null) {
            return false;
        }

        while(atual != null) {
            caminho.add(atual);
            custoCaminho = custoCaminho + atual.getCustoG();
            atual = atual.getPai();
            
        }
        return true;
        
     }
    
    
     public boolean iniciarBusca() {
        //Caso o no de origem seja o mesmo que o no destino, a solucao e trivial.
        if (getOrigem() == getDestino()) {  
            return true;
        }
        
        //Adiciona o No origem a lista aberta para que esse possa ser processado

       // aberta.add(getOrigem());    
        
       /*
        Chamada o metodo recursivo busca para buscar e montar o melhor caminho 
        da origem ate o destino
        */
        if (buscar(origem)) {                  
            
            /*
            Quando o método termina a busca, ou seja, acha o caminho mais curto
            ele chama o metodo caminho, para que todos os Nos que representam
            o caminho mais curto sejam adicionados a lista caminho.
            */
            return caminho();         
        }
        return false;                       
    }
    
    public boolean buscar(No _origem){
        pilha.add(_origem);
        
        while(!pilha.isEmpty()){
            System.out.println("Termo na pilha: "+(pilha.get(0)).getPosX()+ " "+(pilha.get(0)).getPosY() );
            No atual = pilha.get(0);
            
            pilha.remove(0);
            
            if(atual == destino){
               // return true;
               caminho();
               System.out.println("NOVO CUSTO CAMINHO: "+custoCaminho);
               if(menorCusto > custoCaminho){
                   menorCusto = custoCaminho;
                   custoCaminho = 0;
                   menorCustoCaminho = caminho;
                   return true;
               }
               
            }
        else{
            
            int x;
            int y;
            x = atual.getPosX();
            y = atual.getPosY();
            int acima = y - 1;
            int abaixo = y + 1;
            int direita = x + 1;
            int esquerda = x - 1;
         
        if(!percorridos.contains(atual)){    
            //no a direita
        if(direita < matriz[0].length){
            No adjDireita = matriz[direita][y];
            if(!percorridos.contains(adjDireita) && !obstaculos.contains(adjDireita)){
                
                if (!pilha.contains(adjDireita)){
                    adjDireita.setCustoG(getPesoHor());
                    pilha.add(adjDireita);
                    adjDireita.setPai(atual);
                   
                    
               }
            
                 
            }
        }
        
        //no a esquerda
        if(esquerda >= 0){
            No adjEsquerda = matriz[esquerda][y];
            if(!percorridos.contains(adjEsquerda) && !obstaculos.contains(adjEsquerda)){
                
               if (!pilha.contains(adjEsquerda)){
                    adjEsquerda.setCustoG(getPesoHor());
                    pilha.add(adjEsquerda);
                    adjEsquerda.setPai(atual);
                }
              
            }
        }
        
          //no acima
        if(acima >= 0){
            No adjAcima = matriz[x][acima];
            if(!percorridos.contains(adjAcima) && !obstaculos.contains(adjAcima)){
               
                if (!pilha.contains(adjAcima)){
                    adjAcima.setCustoG(getPesoVer());
                    pilha.add(adjAcima);
                    adjAcima.setPai(atual);
                }
                 
            }
        }
        
          //no acima
        if(abaixo < matriz.length){
            No adjAbaixo = matriz[x][abaixo];
            if(!percorridos.contains(adjAbaixo) && !obstaculos.contains(adjAbaixo)){
               
                if (!pilha.contains(adjAbaixo)){
                    adjAbaixo.setCustoG(getPesoVer());
                    pilha.add(adjAbaixo);
                    adjAbaixo.setPai(atual);
                }
                 
            }
        }
        
        //Diagonal Superior Direita - DSD
        if(direita < matriz[0].length && acima >= 0){
            No adjDSD = matriz[direita][acima];
            if(!percorridos.contains(adjDSD) && !obstaculos.contains(adjDSD)){
               
                if (!pilha.contains(adjDSD)){
                    adjDSD.setCustoG(getPesoDia());
                    pilha.add(adjDSD);
                    adjDSD.setPai(atual);
                }
                 
            }
        }
        
        //Diagonal Inferior Direita - DID
        if(direita < matriz[0].length && abaixo < matriz.length){
            No adjDID = matriz[direita][abaixo];
            if(!percorridos.contains(adjDID) && !obstaculos.contains(adjDID)){
               
                if (!pilha.contains(adjDID)){
                    adjDID.setCustoG(getPesoDia());
                    pilha.add(adjDID);
                    adjDID.setPai(atual);
                }
                 
            }
        }
        
        //Diagonal Superior Esquerda - DSE
        if(esquerda >= 0 && acima >= 0){
            No adjDSE = matriz[esquerda][acima];
            if( !percorridos.contains(adjDSE) && !obstaculos.contains(adjDSE)){
               
                if (!pilha.contains(adjDSE)){
                    adjDSE.setCustoG(getPesoDia());
                    pilha.add(adjDSE);
                    adjDSE.setPai(atual);
                }
                 
            }
        }
        
          //Diagonal Inferior Esquerda - DIE
        if(esquerda >= 0 && abaixo<matriz.length){
            No adjDIE = matriz[esquerda][abaixo];
            if(!percorridos.contains(adjDIE) && !obstaculos.contains(adjDIE)){
               
                if (!pilha.contains(adjDIE)){
                    adjDIE.setCustoG(getPesoDia());
                    pilha.add(adjDIE);
                    adjDIE.setPai(atual);
                }
                 
            }
        
        }
        percorridos.add(atual);
        }
        }
         
    }
        return true;
    }
    
    
   
    

    /**
     * @return the pesoHor
     */
    public float getPesoHor() {
        return pesoHor;
    }

    /**
     * @param pesoHor the pesoHor to set
     */
    public void setPesoHor(float pesoHor) {
        this.pesoHor = pesoHor;
    }

    /**
     * @return the pesoVer
     */
    public float getPesoVer() {
        return pesoVer;
    }

    /**
     * @param pesoVer the pesoVer to set
     */
    public void setPesoVer(float pesoVer) {
        this.pesoVer = pesoVer;
    }

    /**
     * @return the pesoDia
     */
    public float getPesoDia() {
        return pesoDia;
    }

    /**
     * @param pesoDia the pesoDia to set
     */
    public void setPesoDia(float pesoDia) {
        this.pesoDia = pesoDia;
    }
}
