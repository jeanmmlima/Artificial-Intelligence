/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aestrela;

import java.awt.Graphics;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jeanmarioml
 */
public class DesenhoWindow extends javax.swing.JFrame {
    
    Desenho d = new Desenho();
    AEstrela aEstrela;
    DFS dfs;
    No[][] matriz;
    No origem;
    No destino;

    /**
     * Creates new form DesenhoWindow
     */
    public DesenhoWindow() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        buttonGroup1 = new javax.swing.ButtonGroup();
        buttonGroup2 = new javax.swing.ButtonGroup();
        panel1 = this.d;
        btnGerarMat = new javax.swing.JButton();
        ftOrdemMat = new javax.swing.JTextField();
        rbObstaculos = new javax.swing.JRadioButton();
        rbPontoPartida = new javax.swing.JRadioButton();
        rbPontoChegada = new javax.swing.JRadioButton();
        btnMelhorCaminho = new javax.swing.JButton();
        ftPesoHorizontal = new javax.swing.JTextField();
        btnGerarPesos = new javax.swing.JButton();
        ftPesoVertical = new javax.swing.JTextField();
        ftPesoDiagonal = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        cbMostrarPesos = new javax.swing.JCheckBox();
        labelPesos = new javax.swing.JLabel();
        labelResultado = new javax.swing.JLabel();
        cbDFS = new javax.swing.JCheckBox();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseReleased(java.awt.event.MouseEvent evt) {
                formMouseReleased(evt);
            }
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                formMouseClicked(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                formMouseExited(evt);
            }
        });

        javax.swing.GroupLayout panel1Layout = new javax.swing.GroupLayout(panel1);
        panel1.setLayout(panel1Layout);
        panel1Layout.setHorizontalGroup(
            panel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 591, Short.MAX_VALUE)
        );
        panel1Layout.setVerticalGroup(
            panel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 503, Short.MAX_VALUE)
        );

        btnGerarMat.setText("Gerar Matriz");
        btnGerarMat.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnGerarMatMouseClicked(evt);
            }
        });
        btnGerarMat.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGerarMatActionPerformed(evt);
            }
        });

        rbObstaculos.setText("Inserir Obstáculos");
        rbObstaculos.setEnabled(false);
        rbObstaculos.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                rbObstaculosItemStateChanged(evt);
            }
        });
        rbObstaculos.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                rbObstaculosStateChanged(evt);
            }
        });
        rbObstaculos.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rbObstaculosActionPerformed(evt);
            }
        });

        rbPontoPartida.setText("Marcar Ponto de Partida");
        rbPontoPartida.setEnabled(false);
        rbPontoPartida.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                rbPontoPartidaStateChanged(evt);
            }
        });
        rbPontoPartida.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rbPontoPartidaActionPerformed(evt);
            }
        });

        rbPontoChegada.setText("Marcar Ponto de Chegada");
        rbPontoChegada.setEnabled(false);
        rbPontoChegada.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                rbPontoChegadaStateChanged(evt);
            }
        });
        rbPontoChegada.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rbPontoChegadaActionPerformed(evt);
            }
        });

        btnMelhorCaminho.setText("Melhor Caminho");
        btnMelhorCaminho.setEnabled(false);
        btnMelhorCaminho.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMelhorCaminhoActionPerformed(evt);
            }
        });

        btnGerarPesos.setText("Add Pesos");
        btnGerarPesos.setEnabled(false);
        btnGerarPesos.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnGerarPesosMouseClicked(evt);
            }
        });
        btnGerarPesos.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGerarPesosActionPerformed(evt);
            }
        });

        ftPesoDiagonal.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ftPesoDiagonalActionPerformed(evt);
            }
        });

        jLabel1.setText("Diagonal");

        jLabel2.setText("Vertical");

        jLabel3.setText("Horizontal");

        cbMostrarPesos.setText("Mostrar Pesos");
        cbMostrarPesos.setEnabled(false);
        cbMostrarPesos.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                cbMostrarPesosStateChanged(evt);
            }
        });

        cbDFS.setText("DFS");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(panel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(6, 6, 6)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.CENTER)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(cbDFS)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(labelResultado))
                    .addComponent(btnMelhorCaminho, javax.swing.GroupLayout.DEFAULT_SIZE, 204, Short.MAX_VALUE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(layout.createSequentialGroup()
                .addGap(603, 603, 603)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.CENTER)
                    .addComponent(ftPesoHorizontal, javax.swing.GroupLayout.DEFAULT_SIZE, 133, Short.MAX_VALUE)
                    .addComponent(ftPesoVertical)
                    .addComponent(ftPesoDiagonal))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.CENTER)
                        .addComponent(jLabel2)
                        .addComponent(jLabel1))
                    .addComponent(jLabel3))
                .addGap(6, 6, 6))
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(615, 615, 615)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(rbObstaculos)
                            .addComponent(rbPontoChegada)
                            .addComponent(rbPontoPartida)))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(632, 632, 632)
                        .addComponent(labelPesos))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(603, 603, 603)
                        .addComponent(cbMostrarPesos))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(603, 603, 603)
                        .addComponent(btnGerarMat, javax.swing.GroupLayout.PREFERRED_SIZE, 114, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(603, 603, 603)
                        .addComponent(ftOrdemMat, javax.swing.GroupLayout.PREFERRED_SIZE, 114, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.CENTER, layout.createSequentialGroup()
                        .addGap(622, 622, 622)
                        .addComponent(btnGerarPesos, javax.swing.GroupLayout.PREFERRED_SIZE, 161, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(14, 14, 14)
                        .addComponent(cbMostrarPesos)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(labelPesos)
                        .addGap(28, 28, 28)
                        .addComponent(ftOrdemMat, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(btnGerarMat)
                        .addGap(18, 18, 18)
                        .addComponent(rbPontoPartida)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(rbPontoChegada)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(rbObstaculos)
                        .addGap(32, 32, 32)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(ftPesoDiagonal, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel1))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(ftPesoVertical, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel2))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(ftPesoHorizontal, javax.swing.GroupLayout.PREFERRED_SIZE, 28, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel3))
                        .addGap(18, 18, 18)
                        .addComponent(btnGerarPesos)
                        .addGap(18, 18, 18)
                        .addComponent(btnMelhorCaminho)
                        .addGap(12, 12, 12)
                        .addComponent(cbDFS)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(labelResultado))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(panel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(22, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnGerarMatActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGerarMatActionPerformed
    int n;
    n = Integer.parseInt(ftOrdemMat.getText());
    d.geraMatriz(n, n);
    matriz = new No[n][n];
        for (int i = 0; i < matriz.length; i++) {
            for (int j = 0; j < matriz[i].length; j++) {
                matriz[i][j] = new No(i, j);
            }
        }
    panel1 = d;
    rbPontoPartida.setEnabled(true);
    }//GEN-LAST:event_btnGerarMatActionPerformed

    private void formMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_formMouseClicked
        // TODO add your handling code here:
        if(rbObstaculos.isSelected()){
        int x = evt.getX();
        int y = evt.getY();
       
        d.obstaculo(x, y);
        System.out.println("X_OBSTACULO: "+d._xObstaculo+" Y_OBSTACULO: "+d._yObstaculo);
        if(!cbDFS.isSelected()){
        aEstrela.adicionarObstaculo(matriz[d._xObstaculo][d._yObstaculo]);}
        else{
            dfs.adicionarObstaculo(matriz[d._xObstaculo][d._yObstaculo]);
        }
        }
        //Adiciona Ponto de Partida - Origem
        else if(rbPontoPartida.isSelected()){
        int x = evt.getX();
        int y = evt.getY();
     
        d.origem(x, y);
        System.out.println("X_ORIGEM: "+d._xOrigem+" Y_ORIGEM: "+d._yOrigem);
        origem = matriz[d._xOrigem][d._yOrigem];
        rbPontoChegada.setEnabled(true);
        
   
        }
        else if(rbPontoChegada.isSelected()){
        int x = evt.getX();
        int y = evt.getY();
        
        d.destino(x, y);
        System.out.println("X_DESTINO: "+d._xDestino+" Y_DESTINO: "+d._yDestino);
        destino = matriz[d._xDestino][d._yDestino];
        if(!cbDFS.isSelected()){
        aEstrela = new AEstrela(origem, destino,matriz);}
        else{
           dfs = new DFS(origem,destino,matriz);
        }
        cbMostrarPesos.setEnabled(true);
        btnGerarPesos.setEnabled(true);
        btnMelhorCaminho.setEnabled(true);
        rbObstaculos.setEnabled(true);
        }
    }//GEN-LAST:event_formMouseClicked

    private void rbObstaculosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rbObstaculosActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_rbObstaculosActionPerformed

    private void rbPontoPartidaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rbPontoPartidaActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_rbPontoPartidaActionPerformed

    private void rbObstaculosItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_rbObstaculosItemStateChanged
        // TODO add your handling code here:
    }//GEN-LAST:event_rbObstaculosItemStateChanged

    private void formMouseReleased(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_formMouseReleased
        // TODO add your handling code here:
     
    }//GEN-LAST:event_formMouseReleased

    private void formMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_formMouseExited
        // TODO add your handling code here:
       
    }//GEN-LAST:event_formMouseExited

    private void btnMelhorCaminhoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMelhorCaminhoActionPerformed
        // TODO add your handling code here:
        
        //Inicia a busca do melhor caminho. Se retornar verdadeiro, achou o caminho!
        if(!cbDFS.isSelected()){
       boolean caminho = aEstrela.iniciarBusca();
       if(caminho){
           //Exibe o caminho no terminal
       labelResultado.setText("Caminho foi encontrado!");
       System.out.println("Caminho:");
            System.out.println("X\tY");
            
            //lista de nos percorridos (lista fechada)
            
            for(int i = 0; i < aEstrela.getPercorridos().size(); i++){
                d.geraFechados(aEstrela.getPercorridos().get(i));
            }

            //lista caminho encontrado
            for (int i = 0; i < aEstrela.getCaminho().size(); i++) {
                //Desenha o caminho na inetrface
                d.geraCaminho(aEstrela.getCaminho().get(i));
                System.out.println(aEstrela.getCaminho().get(i).getPosX()
                        + "\t" + aEstrela.getCaminho().get(i).getPosY());
            }
       }
       else {
            System.out.println("Caminho nao pode ser encontrado.");
            labelResultado.setText("Caminho nao pode ser encontrado");
        }
        }
        else{
        boolean caminho = dfs.iniciarBusca();
       if(caminho){
           //Exibe o caminho no terminal
       labelResultado.setText("Caminho foi encontrado!");
       System.out.println("Caminho:");
            System.out.println("X\tY");
            
             for(int i = 0; i < dfs.getPercorridos().size(); i++){
                d.geraFechados(dfs.getPercorridos().get(i));
            }
          
            //lista caminho encontrado
            for (int i = 0; i < dfs.getCaminho().size(); i++) {
                //Desenha o caminho na inetrface
                d.geraCaminho(dfs.getCaminho().get(i));
                System.out.println(dfs.getCaminho().get(i).getPosX()
                        + "\t" + dfs.getCaminho().get(i).getPosY());
            }
       }
       else {
            System.out.println("Caminho nao pode ser encontrado.");
            labelResultado.setText("Caminho nao pode ser encontrado");
        }
        }
    }//GEN-LAST:event_btnMelhorCaminhoActionPerformed

    private void rbPontoPartidaStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_rbPontoPartidaStateChanged
        // TODO add your handling code here:
        if(rbPontoPartida.isSelected()){
            rbObstaculos.setSelected(false);
            rbPontoChegada.setSelected(false);
        }
    }//GEN-LAST:event_rbPontoPartidaStateChanged

    private void rbPontoChegadaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rbPontoChegadaActionPerformed
        // TODO add your handling code here:
      
    }//GEN-LAST:event_rbPontoChegadaActionPerformed

    private void rbPontoChegadaStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_rbPontoChegadaStateChanged
        // TODO add your handling code here:
          if(rbPontoChegada.isSelected()){
            rbObstaculos.setSelected(false);
            rbPontoPartida.setSelected(false);
        }
    }//GEN-LAST:event_rbPontoChegadaStateChanged

    private void rbObstaculosStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_rbObstaculosStateChanged
        // TODO add your handling code here:
          if(rbObstaculos.isSelected()){
            rbPontoChegada.setSelected(false);
            rbPontoPartida.setSelected(false);
        }
    }//GEN-LAST:event_rbObstaculosStateChanged

    private void btnGerarMatMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnGerarMatMouseClicked
        // TODO add your handling code here:
    }//GEN-LAST:event_btnGerarMatMouseClicked

    private void btnGerarPesosMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnGerarPesosMouseClicked
        // TODO add your handling code here:
    }//GEN-LAST:event_btnGerarPesosMouseClicked

    private void btnGerarPesosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGerarPesosActionPerformed
        // TODO add your handling code here:
    float pesohorizontal, pesovertical, pesodiagonal;
    pesohorizontal = Float.parseFloat(ftPesoHorizontal.getText());
    pesovertical = Float.parseFloat(ftPesoVertical.getText());
    pesodiagonal = Float.parseFloat(ftPesoDiagonal.getText());
    aEstrela.setPesos(pesohorizontal, pesovertical, pesodiagonal);
    }//GEN-LAST:event_btnGerarPesosActionPerformed

    private void ftPesoDiagonalActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ftPesoDiagonalActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_ftPesoDiagonalActionPerformed

    private void cbMostrarPesosStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_cbMostrarPesosStateChanged
        // TODO add your handling code here:
        if(cbMostrarPesos.isSelected()){
            labelPesos.setText("H: "+aEstrela.getPesoHor()+" V: "+aEstrela.getPesoVer()+" D: "+aEstrela.getPesoDia());
        }
        else{
            labelPesos.setText(" ");
        }
    }//GEN-LAST:event_cbMostrarPesosStateChanged
    
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(DesenhoWindow.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(DesenhoWindow.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(DesenhoWindow.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(DesenhoWindow.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new DesenhoWindow().setVisible(true);
            }
        });
        
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnGerarMat;
    private javax.swing.JButton btnGerarPesos;
    private javax.swing.JButton btnMelhorCaminho;
    private javax.swing.ButtonGroup buttonGroup1;
    private javax.swing.ButtonGroup buttonGroup2;
    private javax.swing.JCheckBox cbDFS;
    private javax.swing.JCheckBox cbMostrarPesos;
    private javax.swing.JTextField ftOrdemMat;
    private javax.swing.JTextField ftPesoDiagonal;
    private javax.swing.JTextField ftPesoHorizontal;
    private javax.swing.JTextField ftPesoVertical;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel labelPesos;
    private javax.swing.JLabel labelResultado;
    private javax.swing.JPanel panel1;
    private javax.swing.JRadioButton rbObstaculos;
    private javax.swing.JRadioButton rbPontoChegada;
    private javax.swing.JRadioButton rbPontoPartida;
    // End of variables declaration//GEN-END:variables
}
