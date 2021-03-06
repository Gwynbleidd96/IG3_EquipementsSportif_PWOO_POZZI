package com.spring.henallux.IG3_EquipementsSportif_PWOO_POZZI.dataAccess.entity;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Collection;

@Entity
@Table(name = "COMMANDE")
public class CommandeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "NUMTICKET")
    private Integer numTicket;

    @Column(name = "DATE")
    private Timestamp date;

    @JoinColumn(name = "USERNAME_FK", referencedColumnName = "USERNAME")
    @ManyToOne
    private UserEntity userEntity;

    @OneToMany(mappedBy = "commandeEntity")
    private Collection<LigneCommandeEntity> ligneCommandeEntities;

    public Integer getNumTicket() {
        return numTicket;
    }

    public void setNumTicket(Integer numTicket) {
        this.numTicket = numTicket;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public UserEntity getUserEntity() {
        return userEntity;
    }

    public void setUserEntity(UserEntity userEntity) {
        this.userEntity = userEntity;
    }

    public Collection<LigneCommandeEntity> getLigneCommandeEntities() {
        return ligneCommandeEntities;
    }

    public void setLigneCommandeEntities(Collection<LigneCommandeEntity> ligneCommandeEntities) {
        this.ligneCommandeEntities = ligneCommandeEntities;
    }
}
