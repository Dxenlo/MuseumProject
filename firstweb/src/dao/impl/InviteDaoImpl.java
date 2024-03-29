package dao.impl;

import dao.DAO;
import entity.Invite;

import java.util.List;

public class InviteDaoImpl extends DAO<Invite> {
    public void updateAgree(int sendId, int resId, int flag) {
        String sql = "UPDATE invite SET agree = ? WHERE (sendId = ? AND resId = ?)";
        update(sql, flag, sendId, resId);
    }

    public List<Invite> getInvites(int resId) {
        String sql = "SELECT * FROM invite WHERE (resId = ? AND agree = ?)";
        return getForList(sql, resId, 0);
    }

    public List<Invite> getALLInvites(int id) {
        String sql = "SELECT * FROM invite WHERE (sendId = ? OR resId = ?)";
        return getForList(sql, id, id);
    }

    public void addNewInvitation(int sendId, int resId) {
        String sql = "INSERT INTO invite (sendId, resId, agree) VALUES (? , ?, 0)";
        update(sql,sendId,resId);
    }

}
