/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aestrela;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JPanel;
import java.util.ArrayList;


/**
 *
 * @author jeanmarioml
 */
public class Desenho extends JPanel {
    
    
    static int[][][] M = new int[100][100][4];
    private ArrayList<No> caminho;
    
    private int xOrigem = 0;
    private int yOrigem = 0;
    public int _xOrigem = 0;
    public int _yOrigem = 0;
    
    private int xDestino = 0;
    private int yDestino = 0;
    public int _xDestino = 0;
    public int _yDestino = 0;
    
    private int xObstaculo = 0;
    private int yObstaculo = 0;
    public int _xObstaculo = 0;
    public int _yObstaculo = 0;
    
    private int xCaminho = 0;
    private int yCaminho = 0;
    
    private int xFechada = 0;
    private int yFechada = 0;
    
    public int linhas;
    public int colunas;
    

    
    @Override
    protected void paintComponent(Graphics g) {
     //  if (x < 0){
      super.paintComponent(g); //To change body of generated methods, choose Tools | Templates.
      
      geraMatriz(g);
      
      if (xObstaculo > 0){
        obstaculo(g);
      }
      if(xFechada > 0){
          geraFechados(g);
      }
       if(xCaminho > 0){
           geraCaminho(g);
       }
      
      if(xOrigem > 0){
        origem(g);
      }
       if(xDestino > 0){
        destino(g);
      }
      
    }
    
    private void geraMatriz(Graphics g){
    
    if ((linhas != 0) && (colunas != 0)){
     
    
    g.setColor(Color.white);
     
    
    int largura = 500/linhas,altura = 500/colunas;
    int pos_x = 0, pos_y = 0;
    
    for(int i  = 0; i < linhas; i++){
        for(int j = 0; j < colunas; j++){
            if(M[i][j][2] == 1){
                g.setColor(Color.red);
                g.fillRect(pos_x, pos_y, largura, altura);
                g.setColor(Color.white);
            }
            else if(M[i][j][2] == 2){
                g.setColor(Color.green);
                g.fillRect(pos_x, pos_y, largura, altura);
                g.setColor(Color.white);
            }
             else if(M[i][j][2] == 3){
                g.setColor(Color.gray);
                g.fillRect(pos_x, pos_y, largura, altura);
                g.setColor(Color.white);
            }
            else{
            g.fillRect(pos_x, pos_y, largura, altura);
            M[i][j][2] = 0;
            }
            M[i][j][0] = pos_x;
            M[i][j][1] = pos_y;
            
            pos_x = pos_x + largura + 1;
            if(pos_x > 500){
                pos_y = pos_y + altura + 1;
                pos_x = 0;
            }
            
        }
    }}
    
    }
    
    public void geraMatriz(int _linhas, int _colunas){
     linhas = _linhas;
     colunas = _colunas;
     repaint();
    }
    
    public void obstaculo(int pos_x, int pos_y){
        xObstaculo = pos_x;
        yObstaculo = pos_y;
         for(int i = 0; i < linhas; i++){
            for(int j = 0; j < colunas; j++){
                if((xObstaculo < (M[i][j][0]+500/linhas)) && ((yObstaculo-40) < (M[i][j][1]+500/colunas))){
                    M[i][j][2] = 1;
                    _xObstaculo = i;
                    _yObstaculo = j;
                    i = linhas;
                    j = colunas;
                }
            }
        }
        repaint();
    }
    
    private void obstaculo(Graphics g){
        g.setColor(Color.red);
        g.fillRect(M[this._xObstaculo][this._yObstaculo][0], M[this._xObstaculo][this._yObstaculo][1], 500/linhas, 500/colunas);
      
    }
    
    public void origem(int pos_x, int pos_y){
        xOrigem = pos_x;
        yOrigem = pos_y;
          for(int i = 0; i < linhas; i++){
            for(int j = 0; j < colunas; j++){
                if(xOrigem < (M[i][j][0] + 500/linhas) && (yOrigem-40) < (M[i][j][1]+500/colunas)){
                    this._xOrigem = i;
                    this._yOrigem = j;
                    System.out.println("x: "+this._xOrigem+" y: "+this._yOrigem);
                    i = linhas;
                    j = colunas;   
                }
            }
        }
        repaint();
        
    }

    private void origem(Graphics g){
        g.setColor(Color.yellow);
        g.fillRect(M[this._xOrigem][this._yOrigem][0], M[this._xOrigem][this._yOrigem][1], 500/linhas, 500/colunas);
      
    }
    
     public void destino(int pos_x, int pos_y){
        xDestino = pos_x;
        yDestino = pos_y;
        for(int i = 0; i < linhas; i++){
            for(int j = 0; j < colunas; j++){
                if(xDestino < (M[i][j][0] + 500/linhas) && (yDestino-40) < (M[i][j][1]+500/colunas)){
                    _xDestino = i;
                    _yDestino = j;
                    i = linhas;
                    j = colunas;
                }
            }
        }
        
        repaint();
    }

    private void destino(Graphics g){
        g.setColor(Color.blue);
        g.fillRect(M[this._xDestino][this._yDestino][0], M[this._xDestino][this._yDestino][1], 500/linhas, 500/colunas);
        
    }
    
    public void geraCaminho(No _caminho){
        this.xCaminho = _caminho.getPosX();
        this.yCaminho = _caminho.getPosY();
        System.out.println("X_CAMINHO: "+xCaminho+" Y_CAMINHO: "+yCaminho);
        M[this.xCaminho][this.yCaminho][2] = 2;
        repaint();
        
    }
    
    private void geraCaminho(Graphics g){
        g.setColor(Color.green);
        g.fillRect(M[this.xCaminho][this.yCaminho][0], M[this.xCaminho][this.yCaminho][1], 500/linhas, 500/colunas);
        
    }
    
    public void geraFechados(No _fechados){
        this.xFechada = _fechados.getPosX();
        this.yFechada = _fechados.getPosY();
        System.out.println("X_FECHADO: "+xFechada+" Y_FECHADO: "+yFechada);
        M[this.xFechada][this.yFechada][2] = 3;
        repaint();
        
    }
    
    private void geraFechados(Graphics g){
        g.setColor(Color.gray);
        g.fillRect(M[this.xFechada][this.yFechada][0], M[this.xFechada][this.yFechada][1], 500/linhas, 500/colunas);
        
    }
    
    public int getXOrigem(){
        return this._xOrigem;
    }
    
    public int getYOrigem(){
        return this._yOrigem;
    }
    
    public void setCaminho(ArrayList<No> _caminho){
        this.caminho = _caminho;
    }
    
    public ArrayList<No> getCaminho(){
        return caminho;
    }
}
