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
public class AEstrela {
    //Definindo os atributos da classe A Estrela. 
    /*
    A classe A Estrela contem uma origem, um destino e uma matriz de Nos.
    Alem disso, contem 4 listas utilizadas para a execucao do alrogitmo, sao elas:
    lista fechada, lista aberta, lista de obstaculos e lista caminho. A lista fechada
    contem os Nos da matriz que ja foram verificados, a lista aberta sao os nos adjacentes
    ao No atual, a lista de obstaculos sao os No da matriz que contem obstaculos, e por fim
    a lista caminho que contem a lista com os Nos que sao o melhor caminho da origem 
    ate o destino.
    
    */
    
    private No origem;
    private No destino;
    private No[][] matriz;
    
    private ArrayList<No> caminho;
    private ArrayList<No> obstaculos;
    private ArrayList<No> fechada;
    private ArrayList<No> aberta;
    private ArrayList<No> percorridos;
    
    private float pesoHor;
    private float pesoVer;
    private float pesoDia;
    //Construtor da classe AEstrela. Recebe uma matriz do tipo No, uma origem e um destino
    //e inicia as listas!
    
    public AEstrela(No _origem, No _destino, No _matriz[][]){
        this.origem = _origem;
        this.destino = _destino;
        this.matriz = _matriz;
        caminho = new ArrayList();
        obstaculos = new ArrayList();
        fechada = new ArrayList();
        aberta = new ArrayList();
        percorridos = new ArrayList();
        pesoHor=1;
        pesoVer=1;
        pesoDia=(float)1.414;
    }

    public ArrayList<No> getPercorridos() {
        return percorridos;
    }

    public void setPercorridos(ArrayList<No> percorridos) {
        this.percorridos = percorridos;
    }

    
    public ArrayList<No> getFechada() {
        return fechada;
    }

    public void setFechada(ArrayList<No> fechada) {
        this.fechada = fechada;
    }

    public ArrayList<No> getAberta() {
        return aberta;
    }

    /*
    Gets e Sets para origem, destino, Matriz e get para lista Caminho e Obstaculos
     */
    public void setAberta(ArrayList<No> aberta) {
        this.aberta = aberta;
    }

    public No getOrigem() {
        return origem;
    }

    public void setOrigem(No origem) {
        this.origem = origem;
    }

    public No getDestino() {
        return destino;
    }

    public void setDestino(No destino) {
        this.destino = destino;
    }

    public No[][] getMatriz() {
        return matriz;
    }

    public void setMatriz(No[][] matriz) {
        this.matriz = matriz;
    }

  
    public ArrayList<No> getCaminho() {
        return caminho;
    }
    
    public ArrayList<No> getObstaculos(){
        return obstaculos;
    }
    
    public void adicionarObstaculo(No _obstaculo){
        obstaculos.add(_obstaculo);
    }
    
    public void setPesos(float pesoHor, float pesoVer, float pesoDia){
           this.pesoHor = pesoHor;
           this.pesoVer = pesoVer;
           this.pesoDia = pesoDia;
    }
            
    public float getPesoHor(){
        return pesoHor;
    }
    
    public float getPesoVer(){
        return pesoVer;
    }
     
    public float getPesoDia(){
        return pesoDia;
    }
    /*
    Inicio do Codigo A Estrela
    */
    
    public boolean iniciarBusca() {
        //Caso o no de origem seja o mesmo que o no destino, a solucao e trivial.
        if (getOrigem() == getDestino()) {  
            return true;
        }
        
        //Adiciona o No origem a lista aberta para que esse possa ser processado

        aberta.add(getOrigem());    
        
       /*
        Chamada o metodo recursivo busca para buscar e montar o melhor caminho 
        da origem ate o destino
        */
        if (buscar()) {                  
            
            /*
            Quando o método termina a busca, ou seja, acha o caminho mais curto
            ele chama o metodo caminho, para que todos os Nos que representam
            o caminho mais curto sejam adicionados a lista caminho.
            */
            return caminho();         
        }
        return false;                       
    }
    
    public float getFOrigem(){
        float custoH = getPesoHor()*Math.abs(destino.getPosX() - origem.getPosX()) + 
                getPesoVer()*Math.abs(destino.getPosY() - origem.getPosY());
        return custoH;
    }
    
    /*
    Abaixo esta implementado o metodo caminho que "monta" o melhor caminho 
    achado pela busca. Basicamente ele cria um No chamado atual, o adiciona 
    na lista caminho e atualiza o seu valor para o valor do seu pai, e assim
    sucessivamente. Quando o pai do no atual e nulo, ou seja, o no é a origem
    a funcao retorna true, a lista caminho contem todo o caminho que presenta
    o melhor caminho da origem ate o destino.
    */
     private boolean caminho() {
        No atual = getDestino();

        if (atual == null) {
            return false;
        }

        while(atual != null) {
            caminho.add(atual);
            atual = atual.getPai();
        }
        return true;
        
     }
      /*
      Inicio do metodo de busca, buscar()
     */
      private boolean buscar() {
        //Atribui a no atual o no da lista aberta para comecar a busca
        No atual = aberta.get(0);
        
        /*
        Percorre os Nos na lista aberta para obter o no de MENOR custo F.
        Atualiza o no atual. Atual recebe o no de menor custo.
        */
        for (int i = 0; i < aberta.size(); i++) {
           // if(getFOrigem() >= aberta.get(i).getCustoF()){
            percorridos.add(aberta.get(i));//}
            if (atual.getCustoF() > aberta.get(i).getCustoF()) {
                
                atual = aberta.get(i);
            }
        }
        
        //Insere o no atual na lista fechada e o remove da lista aberta uma vez
        //que ele sera o no verificado e nao é necessário verifica-lo novamente
        fechada.add(atual);     
        aberta.remove(atual);  
        
        /*
        Se o no atual for o destino, o caminho foi achado!
        Caso contrario, o codigo continua ser executado
        */      
        if (atual == destino) {   
            return true;
        }

        /*
        x e y recebem as coordenadas x e t do No. Assim, e possivel calcular
        as coordenadas dos nos adjacentess ao no atual. 
        Os nos nas posicoes a direta, esquerda, acima, abaixo e diagonais do 
        no atual precisam ser avaliados
        */
        int x;
        int y;
        x = atual.getPosX();
        y = atual.getPosY();
        int acima = y - 1;
        int abaixo = y + 1;
        int direita = x + 1;
        int esquerda = x - 1;

        //No adjacente a direita
        if (direita < matriz[0].length) {
            //O no adjacente a Direita é atribuido a matriz na respectiva posicao (a direta de atual)
            No adjDireita = matriz[direita][y];
            /*
            Caso o no adjacente esteja na lista fechada ou seja obstaculo,
            o mesmo não precisa ser verificado. Do contrário, é preciso
            setar os ganhos G e H do no adjacente
            */
            if (!fechada.contains(adjDireita) && !obstaculos.contains(adjDireita)) {  
                float custoG = atual.getCustoG() + getPesoHor();
                System.out.println("O valor de peso a direita eh " + getPesoHor());
                //System.out.println("O valor de peso acima eh " + getPesoVer());
                //System.out.println("O valor de peso diagonal eh " + getPesoDia());
                
                /*
                A heuristica usada para o cálculo da distancia entre no e destino, 
                ou seja, custo H é o metodo manhatthan. 
                */
                float custoH = getPesoHor()*(Math.abs(destino.getPosX() - adjDireita.getPosX())) + 
                       getPesoVer()* (Math.abs(destino.getPosY() - adjDireita.getPosY()));       
                
                /*
                Se o no adjacente ainda não estiver na lista aberta, ele será adicionado a mesma,
                sei pai sera o nó atual, o seu custo G e H serao os calculados acima
                */
                if (!aberta.contains(adjDireita)) {    
                    adjDireita.setPai(atual);           
                    aberta.add(adjDireita);           
                    adjDireita.setCustoG(custoG);
                    adjDireita.setCustoH(custoH);
                } 
                /*
                Caso o nó adjacente já esteja na lista aberta, seu custo H será
                comparado com o custo H calculado acima. Se o custo H do nó adjacente for
                maior que o calculado, seu pai, custo G e custo H são atualizados
                pois um caminho de menor custo foi achado!
                */
                else {                                        
                    if (adjDireita.getCustoG() > custoG) { 
                        adjDireita.setPai(atual);       
                        adjDireita.setCustoG(custoG);      
                        adjDireita.setCustoH(custoH);
                    }
                }
            }
        }

        //No adjacente da esquerda
        if (esquerda >= 0) {
            //ao no adjacente a esquerda é atribuido a matriz na respectiva posicao (a esquerda de atual)
            No adjEsquerda = getMatriz()[esquerda][y];
            /*
            Caso o no adjacente esteja na lista fechada ou seja obstaculo,
            o mesmo não precisa ser verificado. Do contrário, é preciso
            setar os ganhos G e H do no adjacente
            */
            if (!fechada.contains(adjEsquerda) && !obstaculos.contains(adjEsquerda)) {  
                float custoG = atual.getCustoG() + getPesoHor();      
                float custoH = getPesoHor()*(Math.abs(destino.getPosX() - adjEsquerda.getPosX())) + 
                       getPesoVer()* (Math.abs(destino.getPosY() - adjEsquerda.getPosY()));         

                /*
                Se o no adjacente ainda não estiver na lista aberta, ele será adicionado a mesma,
                sei pai sera o nó atual, o seu custo G e H serao os calculados acima
                */
                if (!aberta.contains(adjEsquerda)) {    
                    adjEsquerda.setPai(atual);           
                    aberta.add(adjEsquerda);           
                    adjEsquerda.setCustoG(custoG);
                    adjEsquerda.setCustoH(custoH);
                }
                /*
                Caso o nó adjacente já esteja na lista aberta, seu custo H será
                comparado com o custo H calculado acima. Se o custo H do nó adjacente for
                maior que o calculado, seu pai, custo G e custo H são atualizados
                pois um caminho de menor custo foi achado!
                */
                else {                                        
                    if (adjEsquerda.getCustoG() > custoG) { 
                        adjEsquerda.setPai(atual);       
                        adjEsquerda.setCustoG(custoG);      
                        adjEsquerda.setCustoH(custoH);
                    }
                }
            }
        }

        //No adjacente de cima
        if (acima >= 0) {
            //ao no adjacente acima é atribuido a matriz na respectiva posicao (acima de atual)
            No adjAcima = getMatriz()[x][acima];
              /*
            Caso o no adjacente esteja na lista fechada ou seja obstaculo,
            o mesmo não precisa ser verificado. Do contrário, é preciso
            setar os ganhos G e H do no adjacente
            */
            if (!fechada.contains(adjAcima) && !obstaculos.contains(adjAcima)) { 
                float custoG = atual.getCustoG() + getPesoVer();   
                System.out.println("O valor de peso acima eh " + getPesoVer());
                //calcula custo G - soma 1
                float custoH = getPesoHor()*(Math.abs(destino.getPosX() - adjAcima.getPosX())) + 
                       getPesoVer()* (Math.abs(destino.getPosY() - adjAcima.getPosY()));       
                /*
                Se o no adjacente ainda não estiver na lista aberta, ele será adicionado a mesma,
                seu pai sera o nó atual, o seu custo G e H serao os calculados acima
                */
                if (!aberta.contains(adjAcima)) {    
                    adjAcima.setPai(atual);           
                    aberta.add(adjAcima);           
                    adjAcima.setCustoG(custoG);
                    adjAcima.setCustoH(custoH);
                } 
                /*
                Caso o nó adjacente já esteja na lista aberta, seu custo H será
                comparado com o custo H calculado acima. Se o custo H do nó adjacente for
                maior que o calculado, seu pai, custo G e custo H são atualizados
                pois um caminho de menor custo foi achado!
                */
                else {                                        
                    if (adjAcima.getCustoG() > custoG) { 
                        adjAcima.setPai(atual);       
                        adjAcima.setCustoG(custoG);      
                        adjAcima.setCustoH(custoH);
                    }
                }
            }
        }

        //No adjacente abaixo
        if (abaixo < matriz.length) {
            //ao no adjacente abaixo é atribuido a matriz na respectiva posicao (abaixo de atual)
            No adjAbaixo = matriz[x][abaixo];
              /*
            Caso o no adjacente esteja na lista fechada ou seja obstaculo,
            o mesmo não precisa ser verificado. Do contrário, é preciso
            setar os ganhos G e H do no adjacente
            */
            if (!fechada.contains(adjAbaixo) && !obstaculos.contains(adjAbaixo)) {  
                float custoG = atual.getCustoG() + getPesoVer();      
                float custoH = getPesoHor()*(Math.abs(destino.getPosX() - adjAbaixo.getPosX())) + 
                       getPesoVer()* (Math.abs(destino.getPosY() - adjAbaixo.getPosY()));       
                /*
                Se o no adjacente ainda não estiver na lista aberta, ele será adicionado a mesma,
                seu pai sera o nó atual, o seu custo G e H serao os calculados acima
                */
                if (!aberta.contains(adjAbaixo)) {    
                    adjAbaixo.setPai(atual);          
                    aberta.add(adjAbaixo);           
                    adjAbaixo.setCustoG(custoG);
                    adjAbaixo.setCustoH(custoH);
                } 
                /*
                Caso o nó adjacente já esteja na lista aberta, seu custo H será
                comparado com o custo H calculado acima. Se o custo H do nó adjacente for
                maior que o calculado, seu pai, custo G e custo H são atualizados
                pois um caminho de menor custo foi achado!
                */
                else {                                        
                    if (adjAbaixo.getCustoG() > custoG) { 
                        adjAbaixo.setPai(atual);       
                        adjAbaixo.setCustoG(custoG);      
                        adjAbaixo.setCustoH(custoH);
                    }
                }
            }
        }
        
        //Nó Diagonal Superior Direita - adjDSD
        if(direita < matriz[0].length && acima >= 0){
            //ao no adjacente na diagonal superior direita é atribuido a matriz na respectiva posicao (diagonal superior direita de atual)
            No adjDSD = matriz[direita][acima];
            /*
            Caso o no adjacente esteja na lista fechada ou seja obstaculo,
            o mesmo não precisa ser verificado. Do contrário, é preciso
            setar os ganhos G e H do no adjacente
            */
            if (!fechada.contains(adjDSD) && !obstaculos.contains(adjDSD)) {  
                float custoG = (float) (atual.getCustoG() + getPesoDia());  
               
                float custoH = getPesoHor()*(Math.abs(destino.getPosX() - adjDSD.getPosX())) + 
                       getPesoVer()* (Math.abs(destino.getPosY() - adjDSD.getPosY()));        
                /*
                Se o no adjacente ainda não estiver na lista aberta, ele será adicionado a mesma,
                seu pai sera o nó atual, o seu custo G e H serao os calculados acima
                */
               if (!aberta.contains(adjDSD)) {    
                    adjDSD.setPai(atual);         
                    aberta.add(adjDSD);          
                    adjDSD.setCustoG(custoG);
                    adjDSD.setCustoH(custoH);
                } 
                /*
                Caso o nó adjacente já esteja na lista aberta, seu custo H será
                comparado com o custo H calculado acima. Se o custo H do nó adjacente for
                maior que o calculado, seu pai, custo G e custo H são atualizados
                pois um caminho de menor custo foi achado!
                */
                else {                                        
                    if (adjDSD.getCustoG() > custoG) { 
                        adjDSD.setPai(atual);       
                        adjDSD.setCustoG(custoG);      
                        adjDSD.setCustoH(custoH);
                    }
                }
            }
            
        }
        
        //Nó Diagonal Inferior Direita adjDID
        if(direita < matriz[0].length && abaixo < matriz.length){
            //ao no adjacente na diagonal inferior direita é atribuido a matriz na respectiva posicao (diagonal inferior direita de atual)
            No adjDID = matriz[direita][abaixo];
            /*
            Caso o no adjacente esteja na lista fechada ou seja obstaculo,
            o mesmo não precisa ser verificado. Do contrário, é preciso
            setar os ganhos G e H do no adjacente
            */
            if (!fechada.contains(adjDID) && !obstaculos.contains(adjDID)) {  
                float custoG = (float) (atual.getCustoG() + getPesoDia());      
                 float custoH = getPesoHor()*(Math.abs(destino.getPosX() - adjDID.getPosX())) + 
                       getPesoVer()* (Math.abs(destino.getPosY() - adjDID.getPosY()));        
                /*
                Se o no adjacente ainda não estiver na lista aberta, ele será adicionado a mesma,
                seu pai sera o nó atual, o seu custo G e H serao os calculados acima
                */
                if (!aberta.contains(adjDID)) {    
                    adjDID.setPai(atual);           
                    aberta.add(adjDID);           
                    adjDID.setCustoG(custoG);
                    adjDID.setCustoH(custoH);
                } 
                /*
                Caso o nó adjacente já esteja na lista aberta, seu custo H será
                comparado com o custo H calculado acima. Se o custo H do nó adjacente for
                maior que o calculado, seu pai, custo G e custo H são atualizados
                pois um caminho de menor custo foi achado!
                */
                else {                                        
                    if (adjDID.getCustoG() > custoG) {
                        adjDID.setPai(atual);       
                        adjDID.setCustoG(custoG);      
                        adjDID.setCustoH(custoH);
                    }
                }
            }
            
        }
        
         //Nó Diagonal Superior Esquerda adjDSE
        if(esquerda >= 0 && acima >= 0){
            //ao no adjacente na diagonal superior esquerda é atribuido a matriz na respectiva posicao (diagonal superior esquerda de atual)
            No adjDSE = matriz[esquerda][acima];
            /*
            Caso o no adjacente esteja na lista fechada ou seja obstaculo,
            o mesmo não precisa ser verificado. Do contrário, é preciso
            setar os ganhos G e H do no adjacente
            */
            if (!fechada.contains(adjDSE) && !obstaculos.contains(adjDSE)) {  
                float custoG = (float) (atual.getCustoG() + getPesoDia());      
                 float custoH = getPesoHor()*(Math.abs(destino.getPosX() - adjDSE.getPosX())) + 
                       getPesoVer()* (Math.abs(destino.getPosY() - adjDSE.getPosY()));      
                /*
                Se o no adjacente ainda não estiver na lista aberta, ele será adicionado a mesma,
                seu pai sera o nó atual, o seu custo G e H serao os calculados acima
                */
                if (!aberta.contains(adjDSE)) {    
                    adjDSE.setPai(atual);           
                    aberta.add(adjDSE);           
                    adjDSE.setCustoG(custoG);
                    adjDSE.setCustoH(custoH);
                } 
                /*
                Caso o nó adjacente já esteja na lista aberta, seu custo H será
                comparado com o custo H calculado acima. Se o custo H do nó adjacente for
                maior que o calculado, seu pai, custo G e custo H são atualizados
                pois um caminho de menor custo foi achado!
                */
                else {                                        
                    if (adjDSE.getCustoG() > custoG) {
                        adjDSE.setPai(atual);       
                        adjDSE.setCustoG(custoG);      
                        adjDSE.setCustoH(custoH);
                    }
                }
            }
            
        }
        
           //Nó Diagonal Inferior Esquerda adjDIE
        if(esquerda >= 0 && abaixo<matriz.length){
            //ao no adjacente na diagonal inferior esquerda é atribuido a matriz na respectiva posicao (diagonal inferior esquerda de atual)
            No adjDIE = matriz[esquerda][abaixo];
            /*
            Caso o no adjacente esteja na lista fechada ou seja obstaculo,
            o mesmo não precisa ser verificado. Do contrário, é preciso
            setar os ganhos G e H do no adjacente
            */
            if (!fechada.contains(adjDIE) && !obstaculos.contains(adjDIE)) {  
                float custoG = (float) (atual.getCustoG() + getPesoDia());      
                float custoH = getPesoHor()*(Math.abs(destino.getPosX() - adjDIE.getPosX())) + 
                       getPesoVer()* (Math.abs(destino.getPosY() - adjDIE.getPosY()));        
                /*
                Se o no adjacente ainda não estiver na lista aberta, ele será adicionado a mesma,
                seu pai sera o nó atual, o seu custo G e H serao os calculados acima
                */
                if (!aberta.contains(adjDIE)) {    
                    adjDIE.setPai(atual);           
                    aberta.add(adjDIE);           
                    adjDIE.setCustoG(custoG);
                    adjDIE.setCustoH(custoH);
                } 
                /*
                Caso o nó adjacente já esteja na lista aberta, seu custo H será
                comparado com o custo H calculado acima. Se o custo H do nó adjacente for
                maior que o calculado, seu pai, custo G e custo H são atualizados
                pois um caminho de menor custo foi achado!
                */
                else {                                        
                    if (adjDIE.getCustoG() > custoG) {
                        adjDIE.setPai(atual);       
                        adjDIE.setCustoG(custoG);      
                        adjDIE.setCustoH(custoH);
                    }
                }
            }
            
        }

        if (aberta.isEmpty()) {    //nao ha nenhum caminho
            return false;
        }

        return buscar();     //pesquisa recursivamente
    }
     
}
