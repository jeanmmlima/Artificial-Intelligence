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
public class No {
    
    //Atributos da classe No. Cada No tem um custo H, um custo G, um pai, e 
    //coordenadas x e y
    private float custo_H = 1000000000;
    private float custo_G = 0;
    private float custo_F = 0;
    private No pai = null;
    private int x = 0;
    private int y = 0;
    
    //Contrutor da classe No seta as coordenadas x e y do mesmo
    
    public No(int _x, int _y){
        this.x = _x;
        this.y = _y;
    }
    
    //Metodos de acesso e atribuicao aos atributos do tipo No
    public int getPosX(){
        return x;
    }
    
    public void setPosX(int _x){
        this.x = _x;
    }
    
    public int getPosY(){
        return y;
    }
    
    public void setPosY(int _y){
        this.y = _y;
    }
    
    public float getCustoH(){
        return custo_H;
    }
    
    public void setCustoH(float _H){
        this.custo_H = _H;
    }
    
    public float getCustoG(){
        return custo_G;
    }
    
    public void setCustoG(float _G){
        this.custo_G = _G;
    }
    
    public float getCustoF(){
        this.custo_F = this.custo_G + this.custo_H;
        return custo_F;
    }
    
    public No getPai(){
        return pai;
    }
    
    public void setPai(No _pai){
        this.pai = _pai;
    }
    
}
