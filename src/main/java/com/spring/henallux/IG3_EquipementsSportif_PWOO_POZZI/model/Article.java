package com.spring.henallux.IG3_EquipementsSportif_PWOO_POZZI.model;

import com.spring.henallux.IG3_EquipementsSportif_PWOO_POZZI.exception.ModelException;

public class Article {
    private String libelle;
    private Integer codeBarre;
    private Double prixUnitaire;
    private String taille;
    private String couleur;
    //Penser a ajouter plus d'infos comme le code barre.

    public Article(String libelle, Integer codeBarre, Double prixUnitaire, String taille, String couleur) throws ModelException{
        this.taille = taille;
        this.couleur = couleur;
        setLibelle(libelle);
        setCodeBarre(codeBarre);
        setPrixUnitaire(prixUnitaire);
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) throws ModelException{
        this.libelle = libelle;
        if (libelle == null) {
            throw new ModelException("Article", "Libelle");
        }
    }

    public Integer getCodeBarre() {
        return codeBarre;
    }

    public void setCodeBarre(Integer codeBarre) throws ModelException{
        this.codeBarre = codeBarre;
        if (codeBarre == null || codeBarre <= 0) {
            throw new ModelException("Article", "CodeBarre");
        }
    }

    public Double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(Double prixUnitaire) throws ModelException {
        this.prixUnitaire = prixUnitaire;
        if (prixUnitaire == null || prixUnitaire < 0) {
            throw new ModelException("Article", "PrixUnitaire");
        }
    }

    public String getTaille() {
        return taille;
    }

    public void setTaille(String taille) {
        this.taille = taille;
    }

    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }

    @Override
    public int hashCode() {
        Integer r = prixUnitaire.intValue();
        return codeBarre + r;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof Article) {
            Article article = (Article) obj;
            return (this.getLibelle().equals(article.getLibelle())
                    && this.getPrixUnitaire().equals(article.getPrixUnitaire())
                    && this.getCodeBarre().equals(article.getCodeBarre())
                    && this.getTaille().equals(article.getTaille())
                    && this.getCouleur().equals(article.getCouleur()));
        }
        return false;
    }
}
