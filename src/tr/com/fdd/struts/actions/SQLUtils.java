package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts.action.ActionForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tr.com.fdd.dto.TAnketDTO;
import tr.com.fdd.dto.TAramaKaydiDTO;
import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.TGelirGiderDTO;
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaIslemBorcTakipDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.THastaRandevuDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.dto.TIslemTipDTO;
import tr.com.fdd.dto.TLabrotuvarDTO;
import tr.com.fdd.dto.TLabrotuvarProvaDTO;
import tr.com.fdd.dto.TMenuDTO;
import tr.com.fdd.dto.TSubeDTO;
import tr.com.fdd.dto.TTurKodDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.DoktorForm;
import tr.com.fdd.struts.form.IslemBorcOdemeTakipForm;
import tr.com.fdd.struts.form.LabrotuvarForm;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.struts.form.SubeForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GenelDegiskenler;
import tr.com.fdd.utils.enums.LaboratuvarIslemDurum;
import tr.com.fdd.utils.enums.ProvaTip;

public class SQLUtils {

	private static Logger logger = LoggerFactory.getLogger(SQLUtils.class);

	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yy");

	public static Connection getMySqlConneciton() {

		logger.info("Getting Mysql connection..");

		Connection conn = null;
		try {

			conn = MysqlUtil.instance.getConnection();
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return conn;
	}

	public List<TGelirGiderDTO> gelirParaBirimiRaporu(String basTar,
			String bitTar, Connection conn, String doktorKuId, String kuTur,
			int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = "select  G.PARA_BIRIMI,  sum( g.MIKTAR) AS  MIKTAR "
				+ " from t_gelir_gider  g  , t_odeme_sekli o, t_doktor d "
				+ " where  g.tip=1 and g.durum='A' " + " and g.doktor=d.d_id "
				+ " and g.ODEME_SEKLI= o.KOD ";
		if (basTar != null) {
			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null) {
			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (doktorKuId != null && kuTur.equals("3")) {
			sql += " and d.d_member_id =" + new Integer(doktorKuId).intValue();
		}
		sql += " and g.SUBE_ID=? group by G.PARA_BIRIMI ";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();

		logger.info("gelirParaBirimiRaporu" + " : " + sql);

		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setMiktar(rs.getDouble("MIKTAR"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			list.add(dto);
		}
		return list;

	}

	public List<TGelirGiderDTO> gelirDoktorMiktarRaporu(String basTar,
			String bitTar, Connection conn, String doktorKuId, String kuTur,
			int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = "select  d.d_ad , d.d_soyad,  sum( g.MIKTAR) AS  MIKTAR "
				+ " from t_gelir_gider  g  , t_odeme_sekli o, t_doktor d "
				+ " where  g.tip=1 and g.durum='A' " + " and g.doktor=d.d_id "
				+ " and g.ODEME_SEKLI= o.KOD ";
		if (basTar != null) {
			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null) {
			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (doktorKuId != null && kuTur.equals("3")) {
			sql += " and d.d_member_id =" + new Integer(doktorKuId).intValue();
		}
		sql += " g.SUBE_ID=? group by d.d_ad , d.d_soyad";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);

		logger.info("gelirDoktorMiktarRaporu" + " : " + sql.toString());

		ResultSet rs = stm.executeQuery();
		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setMiktar(rs.getDouble("MIKTAR"));
			dto.setdAd(rs.getString("d_ad"));
			dto.setdSoyAd(rs.getString("d_soyad"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			list.add(dto);
		}
		return list;
	}

	public List<TGelirGiderDTO> gelirOdemeSekliMiktarRaporu(String basTar,
			String bitTar, Connection conn, String doktorKuId, String kuTur,
			int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = "select o.ODEME_SEKLI, sum( g.MIKTAR) AS  MIKTAR "
				+ " from t_gelir_gider  g  , t_odeme_sekli o, t_doktor d "
				+ " where  g.tip=1 and g.durum='A' " + " and g.doktor=d.d_id "
				+ " and g.ODEME_SEKLI= o.KOD ";
		if (basTar != null) {

			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null) {

			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (doktorKuId != null && kuTur.equals("3")) {
			sql += " and d.d_member_id =" + new Integer(doktorKuId).intValue();
		}
		sql += " and g.SUBE_ID=? group by o.ODEME_SEKLI ";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();

		logger.info("gelirOdemeSekliMiktarRaporu" + " : " + sql.toString());

		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setMiktar(rs.getDouble("MIKTAR"));
			dto.setOdemeSekliStr(rs.getString("ODEME_SEKLI"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			list.add(dto);

		}
		return list;
	}

	public List<TGelirGiderDTO> gelirListesi(String basTar, String bitTar,
			Connection conn, String doktorKuId, String kuTur, String aciklama,
			int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = " select g.ID,g.TARIH, g.TIP,  g.MIKTAR , o.ODEME_SEKLI ,g.ACIKLAMA, d.d_ad , d.d_soyad "
				+ " from t_gelir_gider  g  , t_odeme_sekli o, t_doktor d "
				+ " where  g.tip=1 and durum='A' "
				+ " and g.doktor=d.d_id "
				+ " and g.ODEME_SEKLI= o.KOD ";
		if (basTar != null && basTar != "") {

			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null && basTar != "") {

			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (doktorKuId != null && kuTur.equals("3")) {
			sql += " and d.d_member_id =" + new Integer(doktorKuId).intValue();
		}
		if (aciklama != null) {
			sql += " and g.ACIKLAMA like '" + aciklama + "%'";
		}
		sql += " and g.SUBE_ID=? order by g.TARIH desc";

		PreparedStatement stm = conn.prepareStatement(sql);

		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();

		logger.info("gelirListesi" + " : " + sql.toString());

		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setAciklama(rs.getString("ACIKLAMA"));
			dto.setTarih(rs.getDate("TARIH"));
			dto.setId(rs.getInt("ID"));
			dto.setMiktar(rs.getDouble("MIKTAR"));
			dto.setTip(rs.getInt("TIP"));
			dto.setOdemeSekliStr(rs.getString("ODEME_SEKLI"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			dto.setdAd(rs.getString("d_ad"));
			dto.setdSoyAd(rs.getString("d_soyad"));
			list.add(dto);

		}
		return list;

	}

	public List<TGelirGiderDTO> giderListesi(String basTar, String bitTar,
			String giderTuru, Connection conn, int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = " select g.ID, g.TARIH, kod.TUR_AD, g.MIKTAR ,g.TIP , "
				+ " o.ODEME_SEKLI ,g.ACIKLAMA "
				+ " from t_gelir_gider  g , t_tur_kod kod , t_odeme_sekli o "
				+ " where  g.tip=2  and g.durum='A' "
				+ " and g.TUR= kod.TUR_KOD  and kod.tur_durum='A' " + " and g.ODEME_SEKLI= o.KOD ";

		if (basTar != null) {

			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null) {

			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (giderTuru != null && !"-1".equals(giderTuru)) {
			sql += " and g.TUR = '" + giderTuru + "'";
		}

		sql += " and g.SUBE_ID=? order by g.TARIH ";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, new Integer(subeId));

		logger.info("giderListesi" + " : " + sql.toString());

		ResultSet rs = stm.executeQuery();
		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setAciklama(rs.getString("ACIKLAMA"));
			dto.setTarih(rs.getDate("TARIH"));
			if (dto.getTarih() != null)
				dto.setTarihStr(sdf.format(dto.getTarih()));

			dto.setId(rs.getInt("ID"));
			dto.setMiktar(rs.getDouble("MIKTAR"));
			dto.setTip(rs.getInt("TIP"));
			dto.setTurAd(rs.getString("TUR_AD"));
			dto.setOdemeSekliStr(rs.getString("ODEME_SEKLI"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			list.add(dto);

		}
		return list;
	}

	public List<TGelirGiderDTO> giderParaBirimiRaporu(String basTar,
			String bitTar, Connection conn, String doktorAd, String kuTur,
			int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = " select   g.PARA_BIRIMI  , sum(g.MIKTAR) as MIKTAR "
				+ " from t_gelir_gider  g , t_tur_kod kod , t_odeme_sekli o "
				+ " where  g.tip=2  and g.durum='A' "
				+ " and g.TUR= kod.TUR_KOD  and kod.tur_durum='A'	and g.ODEME_SEKLI= o.KOD ";
		if (basTar != null) {
			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null) {
			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (doktorAd != null && kuTur.equals("3")) {
			sql += " and kod.TUR_AD like '" + doktorAd + "%'";
		}
		sql += " and g.SUBE_ID=? group by  g.PARA_BIRIMI ";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);

		ResultSet rs = stm.executeQuery();
		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setMiktar(rs.getDouble("MIKTAR"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			list.add(dto);
		}
		return list;

	}

	public List<TGelirGiderDTO> giderGiderTurBazliRapor(String basTar,
			String bitTar, Connection conn, String doktorAd, String kuTur,
			int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = " select  kod.TUR_AD, sum(g.MIKTAR) AS MIKTAR "
				+ " from t_gelir_gider  g , t_tur_kod kod , t_odeme_sekli o "
				+ " where  g.tip=2 and g.durum='A' and kod.tur_durum='A' "
				+ " and g.TUR= kod.TUR_KOD 	and g.ODEME_SEKLI= o.KOD ";
		if (basTar != null) {
			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null) {
			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (doktorAd != null && kuTur.equals("3")) {
			sql += " and kod.TUR_AD like '" + doktorAd + "%'";
		}

		sql += " and g.SUBE_ID=? group by  kod.TUR_AD order by MIKTAR desc ";

		logger.info("giderGiderTurBazliRapor :"+sql.toString());
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);

		ResultSet rs = stm.executeQuery();
		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setMiktar(rs.getDouble("MIKTAR"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			dto.setGiderTuru(rs.getString("TUR_AD"));
			list.add(dto);
		}
		return list;

	}

	public List<THastaOdemeDTO> gelirListesi(String basTar, String bitTar,
			int doktorId, int islemTipId, int subeId, Connection conn,
			boolean implantGeliriGoster) throws SQLException {

		List<THastaOdemeDTO> list = new ArrayList<THastaOdemeDTO>();

		// String gelirSql =
		// " select g.ID,g.TARIH, g.TIP,  g.MIKTAR , g.PARA_BIRIMI, o.ODEME_SEKLI ,g.ACIKLAMA, d.d_ad , d.d_soyad "
		// + " from t_gelir_gider  g  , t_odeme_sekli o, t_doktor d "
		// + " where  g.tip=1  and g.durum='A' "
		// + " and g.doktor=d.d_id "
		// + " and g.ODEME_SEKLI= o.KOD ";
		//
		// if (basTar != null) {
		//
		// gelirSql += " and g.TARIH >= '" + basTar + "'";
		// }
		// if (bitTar != null) {
		//
		// gelirSql += " and g.TARIH <= '" + bitTar + "'";
		// }
		// gelirSql += " order by g.ID desc";

		String gelirSql = " select i.dis_say, i.dis_no, g.*,h.*, t.ad islemAd ,d.d_ad, d.d_soyad  "
				+ " from t_hasta_gelir g, t_hasta h  , t_islem i, t_islem_tip t, t_doktor d "
				+ " where  g.durumu='A' "
				+ " and h.durum='A' and g.odeme_turu <> 1 AND i.durum not in ('P') "
				+ " and i.id= g.islem_id"

				+ " and t.id=i.islem_tipi and i.hasta_id=h.id "
				+ " and d.d_id= i.doktor_id "
				+ " and g.tarih >= ? and g.tarih <= ? ";
		if (doktorId != -1) {
			//
			gelirSql = gelirSql + " and i.doktor_id =" + doktorId;

			if (implantGeliriGoster)
				gelirSql += " and i.islem_tipi in ("
						+ GenelDegiskenler.OperasyonTipleri.IMPLANT + ","
						+ GenelDegiskenler.OperasyonTipleri.IMPLANT_DESTEK
						+ ")";
			else
				gelirSql += " and i.islem_tipi not in ("
						+ GenelDegiskenler.OperasyonTipleri.IMPLANT + ","
						+ GenelDegiskenler.OperasyonTipleri.IMPLANT_DESTEK
						+ ")";
		}
		if (islemTipId != -1) {
			gelirSql = gelirSql + " and i.islem_tipi =" + islemTipId;
		}

		gelirSql += " 	and h.sube_id=?   order by g.tarih ";
		PreparedStatement pstm = conn.prepareStatement(gelirSql);

		logger.info("gelir listesi sql=" + gelirSql);

		pstm.setString(1, basTar);
		pstm.setString(2, bitTar);
		pstm.setInt(3, subeId);
		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			THastaOdemeDTO dto = new THastaOdemeDTO();
			THastaDTO hasta = new THastaDTO();
			hasta.setId(rs.getInt("id"));
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setProtokolNo(rs.getString("protokol_no"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			hasta.setTel(rs.getString("tel"));
			hasta.setDurum(rs.getString("durum"));
			TIslemDTO islem = new TIslemDTO();
			islem.setDisAdet(rs.getInt("dis_say"));
			islem.setDisNo(rs.getString("dis_no"));
			dto.setIslem(islem);

			TIslemTipDTO islemTip = new TIslemTipDTO();

			islemTip.setAd(rs.getString("islemAd"));

			TDoktorDTO doktor = new TDoktorDTO();

			doktor.setdAd(rs.getString("d_ad"));
			doktor.setdSoyad(rs.getString("d_soyad"));

			dto.setIslemTip(islemTip);
			dto.setHasta(hasta);
			dto.setDoktor(doktor);

			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setOdemeTarihi(rs.getDate("tarih"));
			if (dto.getOdemeTarihi() != null)
				dto.setOdemeTarihiStr(sdf.format(dto.getOdemeTarihi()));

			dto.setOdemeTuru(rs.getInt("odeme_turu"));
			dto.setMiktar(rs.getDouble("miktar"));
			dto.setKalanMiktar(rs.getDouble("kalan_miktar"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDurumu(rs.getString("durumu"));

			list.add(dto);
		}
		return list;

	}

	public List<THastaOdemeDTO> odemeSeklineGoreGelirListesi(String basTar,
			String bitTar, int doktorId, int islemTipId, Connection conn,
			int subeId) throws SQLException {

		List<THastaOdemeDTO> list = new ArrayList<THastaOdemeDTO>();
		String gelirSql = " select odeme_turu, sum(g.miktar) toplam "
				+ " from t_hasta_gelir g, t_hasta h  , t_islem i, t_islem_tip t, t_doktor d "
				+ " where  g.durumu='A' "
				+ " and h.durum='A' and g.odeme_turu <> 1 and i.durum not in ('P')   "
				+ " and i.id= g.islem_id "
				+ " and t.id=i.islem_tipi and i.hasta_id=h.id "
				+ " and d.d_id= i.doktor_id "
				+ " and g.tarih >= ? and g.tarih <= ? ";
		if (doktorId != -1) {
			gelirSql = gelirSql + " and i.doktor_id =" + doktorId;
		}
		if (islemTipId != -1) {
			gelirSql = gelirSql + " and i.islem_tipi =" + islemTipId;
		}
		gelirSql += " and h.sube_id=? group by odeme_turu order by toplam desc ";
		PreparedStatement pstm = conn.prepareStatement(gelirSql);

		logger.info("odeme sekline gore gelir listesi sql=" + gelirSql);

		pstm.setString(1, basTar);
		pstm.setString(2, bitTar);
		pstm.setInt(3, subeId);

		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			THastaOdemeDTO dto = new THastaOdemeDTO();
			dto.setOdemeTuru(rs.getInt("odeme_turu"));
			dto.setMiktar(rs.getDouble("toplam"));
			list.add(dto);
		}
		return list;

	}

	public List<THastaOdemeDTO> operasyonTuruneGoreGelirListesi(String basTar,
			String bitTar, int doktorId, int islemTipId, Connection conn,
			int subeId) throws SQLException {

		List<THastaOdemeDTO> list = new ArrayList<THastaOdemeDTO>();
		String gelirSql = " select t.ad, sum(g.miktar) toplam "
				+ " from t_hasta_gelir g, t_hasta h  , t_islem i, t_islem_tip t, t_doktor d "
				+ " where  g.durumu='A' "
				+ " and h.durum='A' and g.odeme_turu <> 1 and i.durum not in ('P')   "
				+ " and i.id= g.islem_id "
				+ " and t.id=i.islem_tipi and i.hasta_id=h.id "
				+ " and d.d_id= i.doktor_id "
				+ " and g.tarih >= ? and g.tarih <= ? ";
		if (doktorId != -1) {
			gelirSql = gelirSql + " and i.doktor_id =" + doktorId;
		}
		if (islemTipId != -1) {
			gelirSql = gelirSql + " and i.islem_tipi =" + islemTipId;
		}
		gelirSql += " and h.sube_id=? group by t.ad order by toplam desc ";
		PreparedStatement pstm = conn.prepareStatement(gelirSql);

		logger.info("operasyonTuruneGoreGelirListesi sql=" + gelirSql);

		pstm.setString(1, basTar);
		pstm.setString(2, bitTar);
		pstm.setInt(3, subeId);

		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			THastaOdemeDTO dto = new THastaOdemeDTO();
			TIslemTipDTO islemTipDTO = new TIslemTipDTO();
			islemTipDTO.setAd(rs.getString("ad"));
			dto.setIslemTip(islemTipDTO);
			dto.setMiktar(rs.getDouble("toplam"));
			list.add(dto);
		}
		return list;

	}

	public List<THastaOdemeDTO> doktoraGoreGelirListesi(String basTar,
			String bitTar, int doktorId, int islemTipId, Connection conn,
			int subeId) throws SQLException {

		List<THastaOdemeDTO> list = new ArrayList<THastaOdemeDTO>();
		String gelirSql = " select d.d_ad, d.d_soyad, sum(g.miktar) toplam "
				+ " from t_hasta_gelir g, t_hasta h  , t_islem i, t_islem_tip t, t_doktor d "
				+ " where  g.durumu='A' "
				+ " and h.durum='A' and g.odeme_turu <> 1   and i.durum not in ('P') "
				+ " and i.id= g.islem_id "
				+ " and t.id=i.islem_tipi and i.hasta_id=h.id "
				+ " and d.d_id= i.doktor_id "
				+ " and g.tarih >= ? and g.tarih <= ? ";
		if (doktorId != -1) {
			gelirSql = gelirSql + " and i.doktor_id =" + doktorId;
		}
		if (islemTipId != -1) {
			gelirSql = gelirSql + " and i.islem_tipi =" + islemTipId;
		}
		gelirSql += " and h.sube_id=? group by d.d_ad, d.d_soyad order by toplam desc ";
		PreparedStatement pstm = conn.prepareStatement(gelirSql);

		logger.info("doktoraGoreGelirListesi sql=" + gelirSql);

		pstm.setString(1, basTar);
		pstm.setString(2, bitTar);
		pstm.setInt(3, subeId);

		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			THastaOdemeDTO dto = new THastaOdemeDTO();
			TDoktorDTO doktor = new TDoktorDTO();
			doktor.setdAd(rs.getString("d_ad"));
			doktor.setdSoyad(rs.getString("d_soyad"));

			dto.setDoktor(doktor);
			dto.setMiktar(rs.getDouble("toplam"));
			list.add(dto);
		}
		return list;

	}

	public List<TGelirGiderDTO> giderListesi(String basTar, String bitTar,
			Connection conn, String aciklama, int giderKodu, String kuTur,
			int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = " select g.ID, g.TARIH, kod.TUR_AD, g.MIKTAR ,g.TIP , "
				+ "  o.ODEME_SEKLI ,g.ACIKLAMA "
				+ " from t_gelir_gider  g , t_tur_kod kod , t_odeme_sekli o "
				+ " where  g.tip=2 and g.durum='A'  and kod.tur_durum='A' "
				+ " and g.TUR= kod.TUR_KOD " + " and g.ODEME_SEKLI= o.KOD ";

		if (basTar != null && basTar != "") {

			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null && basTar != "") {

			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (giderKodu != -1 && kuTur.equals("3")) {
			sql += " and kod.TUR_ID = '" + giderKodu + "'";
		}
		sql += "and  g.SUBE_ID=?  order by g.TARIH desc";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();

		logger.info(sql);
		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setAciklama(rs.getString("ACIKLAMA"));
			dto.setTarih(rs.getDate("TARIH"));
			if(dto.getTarih()!=null)
			dto.setTarihStr(sdf.format(dto.getTarih()));
			dto.setId(rs.getInt("ID"));
			dto.setMiktar(rs.getDouble("MIKTAR"));
			dto.setTip(rs.getInt("TIP"));
			dto.setTurAd(rs.getString("TUR_AD"));
			dto.setOdemeSekliStr(rs.getString("ODEME_SEKLI"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			list.add(dto);

		}
		return list;
	}

	public List<TGelirGiderDTO> giderOdemeSekliMiktarRaporu(String basTar,
			String bitTar, Connection conn, String doktorAd, String kuTur,
			int subeId) throws SQLException {

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();

		String sql = "select o.ODEME_SEKLI,  sum( g.MIKTAR) AS  MIKTAR "
				+ " from t_gelir_gider  g  , t_odeme_sekli o ";
		if (doktorAd != null && kuTur.equals("3")) {
			sql += " , t_tur_kod kod ";
		}
		sql += " where  g.tip=2 and g.durum='A' " +

		" and g.ODEME_SEKLI= o.KOD ";
		if (basTar != null) {

			sql += " and g.TARIH >= '" + basTar + "'";
		}
		if (bitTar != null) {

			sql += " and g.TARIH <= '" + bitTar + "'";
		}
		if (doktorAd != null && kuTur.equals("3")) {
			sql += " and kod.TUR_AD like '" + doktorAd + "%'";
			sql += " and g.TUR= kod.TUR_KOD   and kod.tur_durum='A' ";
		}

		sql += " and g.SUBE_ID=? group by o.ODEME_SEKLI ";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);

		ResultSet rs = stm.executeQuery();
		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setMiktar(rs.getDouble("MIKTAR"));
			dto.setOdemeSekliStr(rs.getString("ODEME_SEKLI"));
			// dto.setParaBirimi(rs.getString("PARA_BIRIMI"));
			list.add(dto);

		}
		return list;
	}

	public List<TGelirGiderDTO> gelirGiderFarkListesi(String gunlukTarih,
			String gunlukTarih2, Connection conn, int subeId)
			throws SQLException {

		String sql = "	select gelOd ,gelParaBirimi,gelir,gider, sum(gelir-gider) fark	"
				+ "	from 	"
				+ "	(	"
				+ "	select   o.ODEME_SEKLI as gelOd , g.PARA_BIRIMI gelParaBirimi, sum(g.MIKTAR) as gelir	"
				+ "	from t_gelir_gider  g  , t_odeme_sekli o  	"
				+ "	where  g.tip=1 and g.durum='A'   and g.ODEME_SEKLI= o.KOD  	"
				+ "	and g.TARIH >= ? and g.TARIH <= ?  and g.SUBE_ID=?	"
				+ "	group by o.ODEME_SEKLI	"
				+ "	order by g.ID desc	"
				+ "	) gel,	"
				+ "	(	"
				+ "	select   o.ODEME_SEKLI as gidOd ,g.PARA_BIRIMI gidParaBirimi, sum(g.MIKTAR) as gider	"
				+ "	from t_gelir_gider  g  , t_odeme_sekli o  	"
				+ "	where  g.tip=2  and g.durum='A'  and g.ODEME_SEKLI= o.KOD  	"
				+ "	and g.TARIH >= ? and g.TARIH <= ? and g.SUBE_ID=?	"
				+ "	group by o.ODEME_SEKLI	"
				+ "	order by g.ID desc	"
				+ "	) gid	"
				+ "	where gel.gelOd=gid.gidOd	"
				+ "	and gel.gelParaBirimi=gid.gidParaBirimi	 group by gelOd ";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("gunluk analiz=" + sql);

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();
		stm.setString(1, gunlukTarih);
		stm.setString(2, gunlukTarih2);
		stm.setInt(3, subeId);
		stm.setString(4, gunlukTarih);
		stm.setString(5, gunlukTarih2);
		stm.setInt(6, subeId);

		ResultSet rs = stm.executeQuery();
		logger.info("gunluk durum fark analizi=" + sql);

		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setOdemeSekliStr(rs.getString("gelOd"));
			dto.setParaBirimi(rs.getString("gelParaBirimi"));
			dto.setGelirMiktar(rs.getDouble("gelir"));
			dto.setGiderMiktar(rs.getDouble("gider"));
			dto.setFark(rs.getDouble("fark"));
			list.add(dto);
		}
		return list;
	}

	public List<TGelirGiderDTO> kasaAnalizi(String gunlukTarih,
			Connection conn, int subeId) throws SQLException {

		String sql = "	select gelOd ,gelParaBirimi,gelir,gider, sum(gelir-gider) fark	"
				+ "	from 	"
				+ "	(	"
				+ "	select   o.ODEME_SEKLI as gelOd , g.PARA_BIRIMI gelParaBirimi, sum(g.MIKTAR) as gelir	"
				+ "	from t_gelir_gider  g  , t_odeme_sekli o  	"
				+ "	where  g.tip=1  and g.durum='A'  and g.ODEME_SEKLI= o.KOD  	"
				+ "	 and g.TARIH <= ?  and g.SUBE_ID=?	"
				+ "	group by o.ODEME_SEKLI	"
				+ "	order by g.ID desc	"
				+ "	) gel,	"
				+ "	(	"
				+ "	select   o.ODEME_SEKLI as gidOd ,g.PARA_BIRIMI gidParaBirimi, sum(g.MIKTAR) as gider	"
				+ "	from t_gelir_gider  g  , t_odeme_sekli o  	"
				+ "	where  g.tip=2   and g.durum='A' and g.ODEME_SEKLI= o.KOD  	"
				+ "	 and g.TARIH <= ?  and g.SUBE_ID=?	"
				+ "	group by o.ODEME_SEKLI	"
				+ "	order by g.ID desc	"
				+ "	) gid	"
				+ "	where gel.gelOd=gid.gidOd	"
				+ "	and gel.gelParaBirimi=gid.gidParaBirimi	 group by gelOd ";

		PreparedStatement stm = conn.prepareStatement(sql);

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();
		stm.setString(1, gunlukTarih);
		stm.setInt(2, subeId);
		stm.setString(3, gunlukTarih);
		stm.setInt(4, subeId);

		ResultSet rs = stm.executeQuery();
		logger.info("kasa" + sql);

		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setOdemeSekliStr(rs.getString("gelOd"));
			dto.setParaBirimi(rs.getString("gelParaBirimi"));
			dto.setGelirMiktar(rs.getDouble("gelir"));
			dto.setGiderMiktar(rs.getDouble("gider"));
			dto.setFark(rs.getDouble("fark"));
			list.add(dto);
		}
		return list;
	}

	public List<TGelirGiderDTO> giderToplami(String gunlukTarih,
			String gunlukTarih2, Connection conn, int subeId)
			throws SQLException {

		String giderSQL = "select  o.kod, o.ODEME_SEKLI as gidOd ,g.PARA_BIRIMI gidParaBirimi, sum(g.MIKTAR) as gider		"
				+ " from t_gelir_gider  g  , t_odeme_sekli o "
				+ "where  g.tip=2 and g.durum='A'   and g.ODEME_SEKLI= o.KOD and g.TARIH >=? and g.TARIH <= ?		"
				+ " and g.SUBE_ID=? "
				+ " group by o.ODEME_SEKLI		order by g.ID desc";

		PreparedStatement stm = conn.prepareStatement(giderSQL);
		logger.info("gunluk analiz gider sql=" + giderSQL);

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();
		stm.setString(1, gunlukTarih);
		stm.setString(2, gunlukTarih2);
		stm.setInt(3, subeId);

		ResultSet rs = stm.executeQuery();
		logger.info("kasa" + giderSQL);

		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setOdemeSekli(rs.getInt("kod"));
			dto.setOdemeSekliStr(rs.getString("gidOd"));
			dto.setParaBirimi(rs.getString("gidParaBirimi"));
			dto.setGiderMiktar(rs.getDouble("gider"));
			list.add(dto);
		}
		return list;
	}

	public List<TGelirGiderDTO> gelirToplami(String gunlukTarih,
			String gunlukTarih2, Connection conn, int subeId)
			throws SQLException {

		String giderSQL = " select   o.KOD,  o.ODEME_SEKLI as gelOd , g.PARA_BIRIMI gelParaBirimi, sum(g.MIKTAR) as gelir	"
				+ " from t_gelir_gider  g  , t_odeme_sekli o  		where  g.tip=1  and g.durum='A'  and g.ODEME_SEKLI= o.KOD  		"
				+ " and g.TARIH >= ? and g.TARIH <= ?	and g.SUBE_ID=?	group by o.ODEME_SEKLI		"
				+ " order by g.ID desc";

		PreparedStatement stm = conn.prepareStatement(giderSQL);
		logger.info("gunluk analiz gider sql=" + giderSQL);

		List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();
		stm.setString(1, gunlukTarih);
		stm.setString(2, gunlukTarih2);
		stm.setInt(3, subeId);

		ResultSet rs = stm.executeQuery();
		logger.info("kasa" + giderSQL);

		while (rs.next()) {
			TGelirGiderDTO dto = new TGelirGiderDTO();
			dto.setOdemeSekli(rs.getInt("KOD"));
			dto.setOdemeSekliStr(rs.getString("gelOd"));
			dto.setParaBirimi(rs.getString("gelParaBirimi"));
			dto.setGelirMiktar(rs.getDouble("gelir"));
			list.add(dto);
		}
		return list;
	}

	public List<TGelirGiderDTO> getGunlukFark(
			List<TGelirGiderDTO> gelirToplami, List<TGelirGiderDTO> giderToplami) {

		gelirToplami.addAll(giderToplami);

		for (int i = 0; i < gelirToplami.size(); i++) {
			TGelirGiderDTO gelir = gelirToplami.get(i);

			if (giderToplami.size() > 0)
				for (int k = 0; k < giderToplami.size(); k++) {
					TGelirGiderDTO gider = giderToplami.get(k);
					if (gelir.getOdemeSekli() == gider.getOdemeSekli()
							&& gelir.getParaBirimi().equals(
									gider.getParaBirimi())) {
						gelir.setGiderMiktar(gider.getGiderMiktar());
						gelir.setFark(gelir.getGelirMiktar()
								- gelir.getGiderMiktar());
					}
				}
			else {

				gelir.setFark(gelir.getGelirMiktar() - gelir.getGiderMiktar());

			}
		}

		return gelirToplami;
	}

	public List<THastaDTO> getHastaListesi(String ad, String soyad,
			String protokolNo, Connection conn, int subeId, String basTar,
			String bitTar, String tel) throws SQLException {

		List<THastaDTO> list = new ArrayList<THastaDTO>();

		String sql = " select * from t_hasta where 1=1 and durum not in ('P') ";
		if (ad != null && ad != "") {

			sql += " and ad like '" + ad + "%'";
		}
		if (soyad != null && soyad != "") {

			sql += " and soyad like '" + soyad + "%'";
		}
		if (protokolNo != null && protokolNo != "") {
			sql += " and protokol_no like '" + protokolNo + "%'";
		}
		if (tel != null && tel != "") {
			sql += " and tel like '" + tel + "%'";
		}
		if (basTar != null && bitTar != null && !basTar.equals("")
				&& !bitTar.equals("")) {

			sql += " and eklenmeTarihi between date_format('" + basTar
					+ "','%Y-%m-%d') and date_format('" + bitTar
					+ "','%Y-%m-%d')";

		}

		sql += " and sube_id=? ";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		logger.info(sql.toString());

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			THastaDTO dto = new THastaDTO();
			dto.setId(rs.getInt("id"));
			dto.setAd(rs.getString("ad"));
			dto.setSoyad(rs.getString("soyad"));
			dto.setProtokolNo(rs.getString("protokol_no"));
			dto.setTckimlik(rs.getString("tckimlik"));
			dto.setTel(rs.getString("tel"));
			dto.setDurum(rs.getString("durum"));
			dto.setEklenmeTarihi(rs.getDate("eklenmeTarihi"));
			
			dto.setHastaOperasyonList(getHastaOperasyonListesiGoruntuleForAnket(dto.getId(), conn,subeId));

			if (dto.getEklenmeTarihi() != null)
				dto.setEklenmeTarihiStr(sdf.format(dto.getEklenmeTarihi()));

			list.add(dto);
		}
		return list;

	}
	public List<THastaDTO> getHastaListesiForAnket(String ad, String soyad,
			String protokolNo, Connection conn, int subeId, String basTar,
			String bitTar) throws SQLException {
		
		List<THastaDTO> list = new ArrayList<THastaDTO>();
		
		String sql = " select * from t_hasta where 1=1 and durum not in ('P') ";
		if (ad != null && ad != "") {
			
			sql += " and ad like '" + ad + "%'";
		}
		if (soyad != null && soyad != "") {
			
			sql += " and soyad like '" + soyad + "%'";
		}
		if (protokolNo != null && protokolNo != "") {
			sql += " and protokol_no like '" + protokolNo + "%'";
		}
		if (basTar != null && bitTar != null && !basTar.equals("")
				&& !bitTar.equals("")) {

			sql += " and eklenmeTarihi between date_format('" + basTar
					+ "','%Y-%m-%d') and date_format('" + bitTar
					+ "','%Y-%m-%d')";

		}
		sql += " and sube_id=? ";
		
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		logger.info(sql.toString());
		
		ResultSet rs = stm.executeQuery();
		
		while (rs.next()) {
			THastaDTO dto = new THastaDTO();
			dto.setId(rs.getInt("id"));
			dto.setAd(rs.getString("ad"));
			dto.setSoyad(rs.getString("soyad"));
			dto.setProtokolNo(rs.getString("protokol_no"));
			dto.setTckimlik(rs.getString("tckimlik"));
			dto.setTel(rs.getString("tel"));
			dto.setDurum(rs.getString("durum"));
			dto.setEklenmeTarihi(rs.getDate("eklenmeTarihi"));
			dto.setHastaOperasyonList(getHastaOperasyonListesiGoruntuleForAnket(dto.getId(), conn, -1));
			dto.setHastaAnketList(getHastaAnketList(dto.getId(), conn));
		
			boolean kalanMiktarVarmi=false;
			if(dto.getHastaOperasyonList().size()==0) kalanMiktarVarmi=true;
			for (int i = 0; i < dto.getHastaOperasyonList().size(); i++) {
				TIslemDTO  islemDTO= dto.getHastaOperasyonList().get(i);
				if(islemDTO.getKalanMiktar()!=0 && islemDTO.getMiktar()>0){
					kalanMiktarVarmi=true;
				}
			}
			if (dto.getEklenmeTarihi() != null)
				dto.setEklenmeTarihiStr(sdf.format(dto.getEklenmeTarihi()));
			
			if(!kalanMiktarVarmi)
			list.add(dto);
		}
		return list;
		
	}

	public List<THastaRandevuDTO> getRandevuListesi( Connection conn, int subeId, int doktorId)
			throws SQLException {

		String sql = " SELECT r.*,h.*,d.*, t.* , tp.ad tpad, tp.id tpid "
				+ " FROM t_hasta_randevu r, t_hasta h, t_doktor d, t_islem t , t_islem_tip tp "
				+ " where r.hasta_id=h.id "
				+ " and r.doktor_id= d.d_id "
				+ " and t.id=r.islem_id "
				+ " and tp.id=t.islem_tipi "
				+ " and r.durum='A' ";
		
				if(doktorId!=-1){
					sql +=" and d_id ="+ doktorId;
				}
				
				sql += " and h.sube_id=?";
		
		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("randevuListesi=" + sql);

		List<THastaRandevuDTO> list = new ArrayList<THastaRandevuDTO>();
		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			
			THastaRandevuDTO dto = new THastaRandevuDTO();
			THastaDTO hasta = new THastaDTO();
			
			TDoktorDTO doktorDTO= new TDoktorDTO();
			
			TIslemDTO islemDTO = new  TIslemDTO();
			
			TIslemTipDTO islemTipDTO= new TIslemTipDTO();
			
			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setRandevuTarihiBaslangic(rs.getString("randevu_tarihi_baslangic"));
			dto.setRandevuTarihiBitis(rs.getString("randevu_tarihi_bitis"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDurum(rs.getString("durum"));
			dto.setIslemId(rs.getInt("islem_id"));
			dto.setRandevuyaGelinmedi(rs.getString("randevu_gelmedi"));

			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			hasta.setProtokolNo(rs.getString("protokol_no"));
			hasta.setTel(rs.getString("tel"));

			dto.setHasta(hasta);
			
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdId(rs.getInt("d_id"));

			//dto.setDoktorAd(rs.getString("d_ad"));
			//dto.setDoktorSoyad(rs.getString("d_soyad"));
			
			//dto.setIslemAd(rs.getString("islemAd"));
			
			islemTipDTO.setAd(rs.getString("tpad"));
			islemTipDTO.setId(rs.getInt("tpid"));
			
			
			dto.setDoktor(doktorDTO);
			dto.setIslemTipDto(islemTipDTO);
			
			islemDTO.setId(rs.getInt("islem_id"));
			islemDTO.setHastaId(rs.getInt("hasta_id"));
			islemDTO.setMiktar(rs.getDouble("ucret"));
			islemDTO.setAciklama(rs.getString("aciklama"));
			islemDTO.setDoktorId(rs.getInt("doktor_id"));
			islemDTO.setIslemTipi(rs.getInt("islem_tipi"));
			islemDTO.setIslemTarihi(rs.getDate("islem_tarihi"));
			islemDTO.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			islemDTO.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			islemDTO.setDurumu(rs.getString("durum"));
			islemDTO.setDisAdet(rs.getInt("dis_say"));
			islemDTO.setDisNo(rs.getString("dis_no"));
			islemDTO.setIliskiliIslemId(rs.getInt("iliskili_islem_id"));
			
			
			dto.setIslemDto(islemDTO);


			list.add(dto);
		}
		return list;
	}
	
	public List<THastaRandevuDTO> getDoktorRandevuListesi( Connection conn, int subeId)
			throws SQLException {
		
		String sql = " SELECT r.*,h.*,d.*, t.ad as islemAd, t.id as islemId, t.ad islem_ad  "
				+ " FROM t_hasta_randevu r, t_hasta h, t_doktor d, t_islem_tip t "
				+ " where r.hasta_id=h.id "
				+ " and r.doktor_id= d.d_id "
				+ " and r.islem=t.id"
				+ " and r.durum='A' "
				+ " and h.sube_id=?";
		
		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("randevuListesi=" + sql);
		
		List<THastaRandevuDTO> list = new ArrayList<THastaRandevuDTO>();
		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();
		
		while (rs.next()) {
			
			THastaRandevuDTO dto = new THastaRandevuDTO();
			THastaDTO hasta = new THastaDTO();
			
			TDoktorDTO doktorDTO= new TDoktorDTO();
			
			TIslemTipDTO islemDTO= new TIslemTipDTO();
			
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setRandevuTarihiBaslangic(rs.getString("randevu_tarihi_baslangic"));
			dto.setRandevuTarihiBitis(rs.getString("randevu_tarihi_bitis"));
			//dto.setIslem(rs.getInt("islem"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDurum(rs.getString("durum"));
			
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			hasta.setProtokolNo(rs.getString("protokol_no"));
			
			dto.setHasta(hasta);
			
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			
			//dto.setDoktorAd(rs.getString("d_ad"));
			//dto.setDoktorSoyad(rs.getString("d_soyad"));
			
			//dto.setIslemAd(rs.getString("islemAd"));
			
			islemDTO.setAd(rs.getString("islem_ad"));
			islemDTO.setId(rs.getInt("islemId"));
			
			//dto.setIslem(rs.getInt("islemId"));
			
			dto.setDoktor(doktorDTO);
			dto.setIslemTipDto(islemDTO);
			
			list.add(dto);
		}
		return list;
	}
	
	

	public List<THastaOdemeDTO> getHastaOdemeListesi(int islemId,
			Connection conn, String basTar, String bitTar) throws SQLException {

		String sql = "SELECT * FROM t_hasta_gelir g " + " where  "
				+ "  g.durumu <> 'P' and g.odeme_turu <> 1 "
				+ " and g.islem_id= ? ";

		if (basTar != null && !basTar.equals("") && bitTar != null
				&& !bitTar.equals("")) {

			sql += "	and g.tarih between date_format('" + basTar
					+ "','%Y-%m-%d') and date_format('" + bitTar
					+ "','%Y-%m-%d')";

		}
		sql += " order by g.id desc";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("getHastaOdemeListesi=" + sql);

		List<THastaOdemeDTO> list = new ArrayList<THastaOdemeDTO>();
		stm.setInt(1, islemId);

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			THastaOdemeDTO dto = new THastaOdemeDTO();

			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setId(rs.getInt("id"));
			dto.setOdemeTarihi(rs.getDate("tarih"));
			if(dto.getOdemeTarihi()!=null)
			dto.setOdemeTarihiStr(sdf.format(dto.getOdemeTarihi()));
			dto.setOdemeTuru(rs.getInt("odeme_turu"));
			dto.setMiktar(rs.getDouble("miktar"));
			dto.setKalanMiktar(rs.getDouble("kalan_miktar"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDurumu(rs.getString("durumu"));
			dto.setIslemId(rs.getInt("islem_id"));
			list.add(dto);
		}
		return list;
	}

	public THastaOdemeDTO getHastaOdeme(int odemeId, Connection conn)
			throws SQLException {

		String sql = "SELECT * FROM t_hasta_gelir g "
				+ " where g.durumu <> 'P' " + " and g.id= ?";
		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("odeme=" + sql);

		stm.setInt(1, odemeId);

		ResultSet rs = stm.executeQuery();
		THastaOdemeDTO dto = null;

		while (rs.next()) {
			dto = new THastaOdemeDTO();
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setId(rs.getInt("id"));
			dto.setOdemeTarihi(rs.getDate("tarih"));
			SimpleDateFormat sdff = new SimpleDateFormat("yyyy.MM.dd");
			String tarih = sdff.format(dto.getOdemeTarihi());

			dto.setOdemeTarihiStr(tarih);
			dto.setOdemeTuru(rs.getInt("odeme_turu"));
			dto.setMiktar(rs.getDouble("miktar"));
			dto.setKalanMiktar(rs.getDouble("kalan_miktar"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDurumu(rs.getString("durumu"));
			dto.setIslemId(rs.getInt("islem_id"));

		}
		return dto;
	}

	public THastaDTO getHasta(int hastaId, Connection conn, int subeId)
			throws SQLException {

		String sql = "SELECT * FROM t_hasta  " + " where durum <> 'P' "
				+ " and id= ? and sube_id=?";
		PreparedStatement stm = conn.prepareStatement(sql);

		logger.info("get Hasta=" + sql);
		stm.setInt(1, hastaId);

		stm.setInt(2, subeId);
		ResultSet rs = stm.executeQuery();

		THastaDTO hasta = new THastaDTO();

		while (rs.next()) {
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			hasta.setProtokolNo(rs.getString("protokol_no"));
			hasta.setTel(rs.getString("tel"));
			hasta.setId(rs.getInt("id"));
			hasta.setDurum(rs.getString("durum"));
			
			hasta.setEklenmeTarihi(rs.getDate("eklenmeTarihi"));
			
			
			List<TIslemDTO> list= getHastaOperasyonListesiGoruntuleForAnket(hasta.getId(), conn,subeId);
			
			List<TAnketDTO> anketList= getHastaAnketList(hasta.getId(), conn);
			
			hasta.setHastaAnketList(anketList);
			
			// imlant varmi
			
			for (int j = 0; j < list.size(); j++) {
				TIslemDTO tIslemDTO= list.get(j);
				
				if(tIslemDTO.getIslemTipi()==GenelDegiskenler.OperasyonTipleri.IMPLANT){
					
					for (int i = 0; i < list.size(); i++) {
						TIslemDTO implantCerrah= list.get(i);
						if(implantCerrah.getIliskiliIslemId()==tIslemDTO.getId()){
							tIslemDTO.setImplantCerrahDoktor(implantCerrah.getDoktor());
							
							for (int k = 0; k < list.size(); k++) {
								TIslemDTO implantDestek= list.get(k);
								if(implantDestek.getIliskiliIslemId()==implantCerrah.getId()){
									tIslemDTO.setImplantDestekDoktor(implantDestek.getDoktor());
									list.remove(k);
									break;
								}
							}
							list.remove(i);
							break;
						}
					}
				}
			}
			
			hasta.setHastaOperasyonList(list);

			if (hasta.getEklenmeTarihi() != null)
				hasta.setEklenmeTarihiStr(sdf.format(hasta.getEklenmeTarihi()));
		}
		return hasta;
	}
	public List<THastaDTO> getHastaList(Connection conn, int subeId,String ad)
			throws SQLException {
		
		String sql = "SELECT * FROM t_hasta  " + " where durum <> 'P' ";
		
		if (ad != null && ad != "") {

			sql += " and ad like '" + ad + "%'";
		}
		
			sql += " and sube_id=?";
			
		PreparedStatement stm = conn.prepareStatement(sql);
		
		
		logger.info("get HastaList=" + sql);
		
		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();
		
		List<THastaDTO> list = new ArrayList<THastaDTO>();
		
		while (rs.next()) {
		
			THastaDTO hasta = new THastaDTO();
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			hasta.setProtokolNo(rs.getString("protokol_no"));
			hasta.setTel(rs.getString("tel"));
			hasta.setId(rs.getInt("id"));
			list.add(hasta);
		}
		return list;
	}

	public List<TIslemDTO> getHastaOperasyonListesiGoruntuleForAnket(int hastaId,
			Connection conn,int subeId) throws SQLException {

		
		String sql = " select i.*,d.*, tp.id as tipId , tp.ad tipAd from t_islem i, t_doktor d, t_islem_tip tp "
				+ " where i.hasta_id=? "
				+ " and i.doktor_id=d.d_id  and i.durum not in ('P')  "
				+ " and i.islem_tipi= tp.id ";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("getHastaOperasyonListesiGoruntuleForAnket :" + sql);

		List<TIslemDTO> list = new ArrayList<TIslemDTO>();
		stm.setInt(1, hastaId);
		ResultSet rs = stm.executeQuery();
		
		Commons commons= new Commons();

		while (rs.next()) {
			TIslemDTO dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDurumu(rs.getString("durum"));
			dto.setDisAdet(rs.getInt("dis_say"));
			dto.setDisNo(rs.getString("dis_no"));
			dto.setOdemeList(getHastaOdemeListesi(dto.getId(), conn, null, null));
			dto.setIliskiliIslemId(rs.getInt("iliskili_islem_id"));

			dto.setKalanMiktar(dto.getMiktar()-commons.getToplamOdemeMiktari(dto.getOdemeList()));
			
			dto.setAramaKayitListesi(getOperasyonHastaAramaList(dto.getId(), conn));

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("tipAd"));
			islemTip.setId(rs.getInt("tipId"));
			dto.setIslemTip(islemTip);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			doktorDTO.setdId(rs.getInt("d_id"));
//			if(subeId > 0)
//			doktorDTO.setDoktorRandevuList(getRandevuListesi(conn, subeId, doktorDTO.getdId()));
			dto.setDoktor(doktorDTO);

			list.add(dto);
		}
		return list;
	}
	
	
	public List<TAnketDTO> getHastaAnketList(int hastaId,
			Connection conn) throws SQLException {

		
		String sql = " select * from t_anket an where an.hasta_id=? and an.durum='A' ";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("getHastaAnketList :" + sql);

		List<TAnketDTO> list = new ArrayList<TAnketDTO>();
		stm.setInt(1, hastaId);
		ResultSet rs = stm.executeQuery();
		

		while (rs.next()) {
			TAnketDTO dto= new TAnketDTO();
			dto.setAciklama(rs.getString("aciklama"));
			dto.setTarih(rs.getDate("tarih"));
			dto.setSaat(rs.getString("saat"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setId(rs.getInt("id"));
			dto.setId(rs.getInt("id"));
			
			list.add(dto);
		}
		return list;
	}
	
	public List<TAnketDTO> getHastaAramaList(int hastaId,
			Connection conn) throws SQLException {
		
		
		String sql = " select * from t_arama_kaydi an where an.hasta_id=? and an.durum='A' ";
		
		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("arama kaydi list :" + sql);
		
		List<TAnketDTO> list = new ArrayList<TAnketDTO>();
		stm.setInt(1, hastaId);
		ResultSet rs = stm.executeQuery();
		
		
		while (rs.next()) {
			TAnketDTO dto= new TAnketDTO();
			dto.setAciklama(rs.getString("aciklama"));
			dto.setTarih(rs.getDate("tarih"));
			dto.setSaat(rs.getString("saat"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setId(rs.getInt("id"));
			dto.setId(rs.getInt("id"));
			
			list.add(dto);
		}
		return list;
	}
	public List<TAramaKaydiDTO> getOperasyonHastaAramaList(int islemId,
			Connection conn) throws SQLException {
		
		
		String sql = " select * from t_arama_kaydi an where an.islem_id=? and an.durum='A' ";
		
		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("arama kaydi list :" + sql);
		
		List<TAramaKaydiDTO> list = new ArrayList<TAramaKaydiDTO>();
		stm.setInt(1, islemId);
		ResultSet rs = stm.executeQuery();
		
		
		while (rs.next()) {
			TAramaKaydiDTO dto= new TAramaKaydiDTO();
			dto.setAciklama(rs.getString("aciklama"));
			dto.setAramaTarih(rs.getDate("arama_tarih"));
			dto.setAramaSaat(rs.getString("arama_saat"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setIslemId(rs.getInt("islem_id"));
			dto.setId(rs.getInt("id"));
			dto.setDurum(rs.getString("durum"));
			
			list.add(dto);
		}
		return list;
	}


	public TIslemDTO getOperasyonuKesinlesmemisHasta(int id, Connection conn)
			throws SQLException {

		String sql = " select * from t_islem i, t_doktor d, t_islem_tip tp "
				+ " where i.id=? "
				+ " and i.doktor_id=d.d_id and i.durum = 'K'   "
				+ " and i.islem_tipi= tp.id ";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info(" operasyon  " + sql);
		stm.setInt(1, id);
		ResultSet rs = stm.executeQuery();
		TIslemDTO dto = null;
		while (rs.next()) {
			dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			SimpleDateFormat sdff = new SimpleDateFormat("yyyy.MM.dd");
			String gunlukTarih = sdff.format(dto.getIslemTarihi());
			dto.setIslemTarihiStr(gunlukTarih);

			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDurumu(rs.getString("durum"));

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("ad"));
			dto.setIslemTip(islemTip);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			dto.setDoktor(doktorDTO);

		}
		return dto;
	}

	public TIslemDTO getHastaOperasyon(int islemId, Connection conn)
			throws SQLException {

		String sql = " select * from t_islem i, t_doktor d, t_islem_tip tp "
				+ " where i.id=? "
				+ " and i.doktor_id=d.d_id and i.durum not in ('P','K')   "
				+ " and i.islem_tipi= tp.id ";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info(" operasyon  " + sql);
		stm.setInt(1, islemId);
		ResultSet rs = stm.executeQuery();
		TIslemDTO dto = null;
		while (rs.next()) {
			dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			dto.setDisAdet(rs.getInt("dis_say"));
			SimpleDateFormat dFormat = new SimpleDateFormat("yyyy.MM.dd");
			if (dto.getIslemBitisTarihi() != null) {

				String bitisTarih = dFormat.format(dto.getIslemBitisTarihi());
				dto.setIslemBitisTarihiStr(bitisTarih);
			}
			String gunlukTarih = dFormat.format(dto.getIslemTarihi());
			dto.setIslemTarihiStr(gunlukTarih);

			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDurumu(rs.getString("durum"));

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("ad"));
			dto.setIslemTip(islemTip);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			dto.setDoktor(doktorDTO);

		}
		return dto;
	}

	public List<TIslemDTO> getHastaOperasyonListesi(int hastaId, int islemId,
			Connection conn) throws SQLException {

		List<TIslemDTO> list = new ArrayList<TIslemDTO>();

		String sql = " select  i.*, d.*, tp.*" + " from  t_islem i  "
				+ " , t_doktor d, t_islem_tip tp " + " where  "
				+ "  i.doktor_id=d.d_id and i.durum not in ('P','K') "
				+ " and i.islem_tipi= tp.id ";
		if (hastaId != 0) {
			sql += " and i.hasta_id=" + hastaId;
		}
		if (islemId != 0) {
			sql += " and i.id=" + islemId;
		}

		sql += " order by i.id desc";
		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info(" operasyon listesi " + sql);

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TIslemDTO dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDurumu(rs.getString("durum"));
			dto.setDisAdet(rs.getInt("dis_say"));
			dto.setOdemeList(getHastaOdemeListesi(dto.getId(), conn, null, null));

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("ad"));
			dto.setIslemTip(islemTip);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			dto.setDoktor(doktorDTO);

			if (dto.getIslemTipi() == GenelDegiskenler.OperasyonTipleri.IMPLANT) {
				// dto.setImplantUcret(rs.getDouble("impl_prot_ucret"));
				// dto.setImplantProtezUcret(rs.getDouble("impl_ucret"));
				// dto.setImplantCerrahId(rs.getInt("impl_cerrah_id"));
				// TDoktorDTO impDoktor= new TDoktorDTO();
				//
				// impDoktor.setdAd(rs.getString("dAd"));
				// impDoktor.setdSoyad(rs.getString("dSoyad"));
				// impDoktor.setdMemberId(rs.getInt("dId"));
				//
				// impDoktor.setdId(rs.getInt("impl_cerrah_id"));
				// dto.setImplantDoktor(impDoktor);

			}

			list.add(dto);
		}
		return list;
	}

	public List<TIslemDTO> getHastaOperasyonOdemeListesi(int id, Connection conn)
			throws SQLException {

		String sql = " select * from t_islem i, t_doktor d, t_islem_tip tp, t_hasta_gelir gel "
				+ " where i.hasta_id=? "
				+ " and i.doktor_id=d.d_id and i.durum not in ('P','K') "
				+ " and i.islem_tipi= tp.id "
				+ " and i.id= gel.islem_id "
				+ " and gel.odeme_turu =1 and gel.durumu = 'A'  order by i.id desc";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info(" operasyon listesi " + sql);

		List<TIslemDTO> list = new ArrayList<TIslemDTO>();
		stm.setInt(1, id);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TIslemDTO dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDurumu(rs.getString("durum"));
			dto.setDisAdet(rs.getInt("dis_say"));

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("ad"));
			dto.setIslemTip(islemTip);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			dto.setDoktor(doktorDTO);

			List<THastaOdemeDTO> odemeList = getHastaOdemeListesi(dto.getId(),
					conn, null, null);
			dto.setOdemeList(odemeList);

			list.add(dto);
		}
		return list;
	}

	public List<TIslemDTO> getDoktorOperasyonLisesi(int id, String hastaAd,
			String hastaSoyad, String durum, int islemTip, Connection conn,
			int subeId, String basTar, String bitTar) throws SQLException {

		String sql = " select h.ad, h.soyad,h.protokol_no, h.tckimlik,h.tel,i.*, t.ad islemAd "
				+ " from t_hasta h, t_islem i, t_islem_tip t "
				+ " where "
				+ " h.id= i.hasta_id and h.durum='A'  "
				+ " and i.islem_tipi= t.id and i.durum in ('A','B') and i.doktor_id=? ";

		if (basTar != null) {
			sql += " and i.islem_tarihi >= '" + basTar + "'";
		}
		if (bitTar != null) {
			sql += " and i.islem_tarihi <= '" + bitTar + "'";
		}

		if (hastaAd != null && !hastaAd.equals("")) {
			sql = sql + " and  h.ad like '" + hastaAd + "%'";
		}
		if (hastaSoyad != null && !hastaSoyad.equals("")) {
			sql = sql + " and h.soyad like '" + hastaSoyad + "%'";

		}
		if (durum != null && !durum.equals("-1")) {
			sql = sql + " and i.durum ='" + durum.toString() + "'";
		}
		if (islemTip != -1
				&& islemTip != GenelDegiskenler.ImplantliOperasyon._VAR) {
			sql = sql + " and t.id =" + islemTip;
		}
		if (islemTip == GenelDegiskenler.ImplantliOperasyon._VAR) {
			sql = sql + " and t.id in("
					+ GenelDegiskenler.OperasyonTipleri.IMPLANT_CERRAH + ","
					+ GenelDegiskenler.OperasyonTipleri.IMPLANT_DESTEK + ")";
		}

		sql = sql + " and h.sube_id=?  order by i.islem_tarihi";
		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info(" operasyon listesi for doktor " + sql);

		List<TIslemDTO> list = new ArrayList<TIslemDTO>();
		stm.setInt(1, id);
		stm.setInt(2, subeId);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TIslemDTO dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));

			if(dto.getIslemTarihi()!=null)
			dto.setIslemTarihiStr(sdf.format(dto.getIslemTarihi()));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDurumu(rs.getString("durum"));
			dto.setDisAdet(rs.getInt("dis_say"));

			THastaDTO hasta = new THastaDTO();
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			hasta.setProtokolNo(rs.getString("protokol_no"));

			TIslemTipDTO islemTipi = new TIslemTipDTO();
			islemTipi.setAd(rs.getString("islemAd"));
			dto.setIslemTip(islemTipi);
			dto.setHasta(hasta);

			list.add(dto);
		}
		return list;
	}

	public TDoktorDTO getDoktor(int memberId, int id, Connection conn, boolean randevuAktif, int subeId) throws SQLException {

		String sql = " select * from t_doktor where ";
			if(memberId!=-1)
				sql +=	" d_member_id= "+memberId ;
			if(id!=-1)
				sql +=	" d_id="+ id ;
				
			sql += " and d_durum='A' ";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info(" getDoktor " + sql);

		//stm.setInt(1, id);
		ResultSet rs = stm.executeQuery();

		TDoktorDTO doktorDTO = null;
		while (rs.next()) {
			doktorDTO = new TDoktorDTO();
			doktorDTO.setdId(rs.getInt("d_id"));
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			doktorDTO.setdMemberId(rs.getInt("d_member_id"));
			doktorDTO.setDoktorSubeList(getDoktorSubeList(conn,	doktorDTO.getdId()));
			
			if(randevuAktif)
			doktorDTO.setDoktorRandevuList(getRandevuListesi(conn, subeId, doktorDTO.getdId()));
		}
		return doktorDTO;
	}

	/**
	 * doktor id doktora ozel sorgulama icin gonderiliyor. session bilgilerine
	 * bakilarak doktor id dolu ise buraya "-1" disinda deger gelir. doktorId =
	 * tablodaki d_member_id sidir.
	 * 
	 * @param conn
	 * @param operasyonDurumu
	 * @param doktorId
	 * @param subeId
	 * @return
	 * @throws SQLException
	 */
	public List<THastaOdemeDTO> hastaBazliToplamOdemeListesi(Connection conn,
			String operasyonDurumu, int doktorId, int subeId, String basTar,
			String bitTar, String ad, String soyad, String protokolNo)
			throws SQLException {

		String sql = "	select i.islem_tipi, i.dis_say, h.protokol_no, h.tel, IFNULL(g.guncellenme_tarihi,g.eklenme_tarihi) eklenme_tarihi,"
				+ " d.d_ad,d.d_soyad,i.islem_tarihi,i.islem_bitis_tarihi,"
				+ " t.ad islemTip, h.ad,h.soyad,g.hasta_id, i.id islemId, 	"
				+ "	i.ucret ucret, group_concat( g.miktar ) miktarlar , group_concat(g.eklenme_tarihi ) odeme_tarihleri,sum(miktar) odenen , ucret-sum(miktar) kalan	"
				+ "	from t_hasta_gelir g, t_hasta h, t_islem i, t_islem_tip t, t_doktor d	"
				+ "	where g.hasta_id=h.id	"
				+ "	and g.islem_id =i.id	"
				+ "	and i.hasta_id=g.hasta_id	"
				+ "	and i.islem_tipi=t.id	"
				+ "	and i.durum in ('A','B')	"
				+ "	and g.odeme_turu not in (1)	"
				+ "	and g.durumu='A'	"
				+ "	and h.durum='A'	" + "	and d.d_id=i.doktor_id	";
		if (doktorId != -1)
			sql = sql + " and d.d_member_id=" + doktorId;

		if (basTar != null && bitTar != null && !basTar.equals("")
				&& !bitTar.equals("")) {
			sql += " and IFNULL(g.guncellenme_tarihi,g.tarih) between date_format('"
					+ basTar
					+ "','%Y-%m-%d') and date_format('"
					+ bitTar
					+ "','%Y-%m-%d')";
		}

		if (ad != null && !ad.equals("")) {
			sql = sql + " and h.ad like '%" + ad + "%'";
		}
		if (soyad != null && !soyad.equals("")) {
			sql = sql + " and h.soyad like '%" + soyad + "%'";
		}
		if (protokolNo != null && !protokolNo.equals("")) {
			sql = sql + " and h.protokol_no like '%" + protokolNo + "%'";
		}

		sql = sql
				+ " and h.sube_id=?	group by g.hasta_id , i.id	order by h.protokol_no";

		PreparedStatement stm = conn.prepareStatement(sql);
		// stm.setString(1, operasyonDurumu);
		stm.setInt(1, subeId);
		logger.info("SQL hastaBazliToplamOdemeListesi --> ' " + sql);

		ResultSet rs = stm.executeQuery();

		ArrayList<THastaOdemeDTO> list = new ArrayList<THastaOdemeDTO>();

		double cerrahBirimFiyat = getImplantCerrahBirimFiyat(conn);
		double birimFiyat = getImplantDestekBirimFiyat(conn);
		double doktorHesapKatsayi = getIslemBirimFiyat(conn);

		while (rs.next()) {

			THastaOdemeDTO odeme = new THastaOdemeDTO();
			odeme.setUcret(rs.getDouble("ucret"));
			odeme.setMiktar(rs.getDouble("odenen"));
			odeme.setKalanMiktar(rs.getDouble("kalan"));
			odeme.setHastaId(rs.getInt("hasta_id"));

			odeme.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			
			if(odeme.getEklenmeTarihi()!=null)
			odeme.setEklenmeTarihiStr(sdf.format(odeme.getEklenmeTarihi()));

			TIslemDTO islem = new TIslemDTO();

			islem.setIslemTarihi(rs.getDate("islem_tarihi"));
			islem.setId(rs.getInt("islemId"));
			islem.setDisAdet(rs.getInt("dis_say"));
			islem.setIslemTipi(rs.getInt("islem_tipi"));

			if(islem.getIslemTarihi()!=null)
			islem.setIslemTarihiStr(sdf.format(islem.getIslemTarihi()));

			islem.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			String islemBitisTarihiStr = null;
			if (islem.getIslemBitisTarihi() != null)
				islemBitisTarihiStr = sdf.format(islem.getIslemBitisTarihi());
			islem.setIslemBitisTarihiStr(islemBitisTarihiStr);

			String m= rs.getString("miktarlar");
			String ot= rs.getString("odeme_tarihleri");
			if(!m.equals("")){
				String[] miktars=m.split(",");
				for (int i = 0; i < miktars.length; i++) {
					islem.getOdemeListStr().add(miktars[i]);
				}
				
			}
			if(!ot.equals("")){
				String[] ots=ot.split(",");
				for (int i = 0; i < ots.length; i++) {
					islem.getOdemeTarihListStr().add(ots[i]);
				}
				
			}
			
		//	islem.setOdemeList(getHastaOdemeListesi(islem.getId(), conn, basTar, bitTar));
			odeme.setIslem(islem);

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("islemTip"));
			odeme.setIslemTip(islemTip);

			TDoktorDTO doktor = new TDoktorDTO();
			doktor.setdAd(rs.getString("d_ad"));
			doktor.setdSoyad(rs.getString("d_soyad"));
			odeme.setDoktor(doktor);

			THastaDTO hasta = new THastaDTO();
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTel(rs.getString("tel"));
			hasta.setProtokolNo(rs.getString("protokol_no"));

			odeme.setHasta(hasta);

			if (odeme.getIslem().getIslemTipi() == GenelDegiskenler.OperasyonTipleri.IMPLANT) {

				double doktorHesap = odeme.getIslem().getDisAdet()
						* cerrahBirimFiyat;

				odeme.setDoktorHesap(doktorHesap);
				odeme.setSirketHesap(odeme.getMiktar() - odeme.getDoktorHesap());
			} else if (odeme.getIslem().getIslemTipi() == GenelDegiskenler.OperasyonTipleri.IMPLANT_DESTEK) {

				double doktorHesap = odeme.getIslem().getDisAdet() * birimFiyat;

				odeme.setDoktorHesap(doktorHesap);
				odeme.setSirketHesap(odeme.getMiktar() - odeme.getDoktorHesap());
			} else {

				odeme.setDoktorHesap(odeme.getMiktar() * doktorHesapKatsayi
						/ 100);
				odeme.setSirketHesap(odeme.getMiktar() - odeme.getDoktorHesap());
			}
			odeme.setDoktorId(doktorId);

			list.add(odeme);
		}
		return list;
	}

	public List<TAramaKaydiDTO> hastaAramaKaydiListesiGetir(
			Connection conn, int doktorId, int subeId, String tip,
			String protokolNo, String ad, String soyad, String basTar,
			String bitTar, String operasyonTip) throws SQLException {

		String sql = " select a.*, i.*,h.*,d.*, t.ad islemAd from t_arama_kaydi a, t_islem i, t_hasta h, t_doktor d , t_islem_tip t "
				+ "	where a.islem_id=i.id and a.durum ='A' and	"
				+ "	i.hasta_id= h.id and h.durum not in ('P') "
				+ "	and i.doktor_id=d.d_id"
				+ "	and i.islem_tipi= t.id  and h.sube_id=? ";

		if (ad != null && ad != "") {

			sql += " and h.ad like '" + ad + "%'";
		}

		if (operasyonTip != null && !operasyonTip.equals("-1")) {

			sql += " and i.islem_tipi=" + operasyonTip;
		}
		if (soyad != null && soyad != "") {

			sql += " and h.soyad like '" + soyad + "%'";
		}
		if (protokolNo != null && protokolNo != "") {
			sql += " and h.protokol_no like '" + protokolNo + "%'";
		}
		
		
		if (doktorId != -1)
			sql = sql + " and d.d_member_id=" + doktorId;
		if (basTar != null && bitTar != null && !basTar.equals("")
				&& !bitTar.equals("")) {

			sql += " and a.arama_tarih between date_format('" + basTar
					+ "','%Y-%m-%d') " + "and date_format('" + bitTar
					+ "','%Y-%m-%d')";
		}
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		logger.info(" arama kayit listesi " + sql);

		List<TAramaKaydiDTO> list = new ArrayList<TAramaKaydiDTO>();

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			
			TAramaKaydiDTO aramaKaydiDTO= new TAramaKaydiDTO();
			aramaKaydiDTO.setId(rs.getInt("id"));
			aramaKaydiDTO.setAciklama(rs.getString("aciklama"));
			aramaKaydiDTO.setAramaTarih(rs.getDate("arama_tarih"));
			aramaKaydiDTO.setAramaSaat(rs.getString("arama_saat"));
			
			
			TIslemDTO dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDisAdet(rs.getInt("dis_say"));


			if(dto.getIslemTarihi()!=null)
			dto.setIslemTarihiStr(sdf.format(dto.getIslemTarihi()));
			dto.setDurumu(rs.getString("durum"));

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("islemAd"));
			dto.setIslemTip(islemTip);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			dto.setDoktor(doktorDTO);

			THastaDTO hasta = new THastaDTO();
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTel(rs.getString("tel"));
			hasta.setProtokolNo(rs.getString("protokol_no"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			dto.setHasta(hasta);

			aramaKaydiDTO.setIslem(dto);
			list.add(aramaKaydiDTO);
		}
		return list;
	}

	public List<TIslemDTO> getOperasyonuKesinlesmemisHastaListesi(
			Connection conn, int doktorId, int subeId, String tip,
			String protokolNo, String ad, String soyad, String basTar,
			String bitTar, String operasyonTip , String tel, int doktor)  {
		
		List<TIslemDTO> list =null;

		try{
		String sql = " select i.*,h.*,d.*, t.ad islemAd from t_islem i, t_hasta h, t_doktor d , t_islem_tip t "
				+ "	where 	"
				+ "	i.hasta_id= h.id and h.durum not in ('P')  "
				+ "	and i.doktor_id=d.d_id"
				+ "	and i.islem_tipi= t.id  and h.sube_id=? ";
		if (tip.equals(GenelDegiskenler.OP_KESINLESMEMIS) || tip.equals(GenelDegiskenler.OP_KESINLESMEMIS_ARAMA_KAYDI))
			sql += " and i.durum='K' ";
		else if (tip.equals(GenelDegiskenler.OP_KESINLESMIS))
			sql += " and i.durum not in ('K','P') ";

		if (ad != null && ad != "") {

			sql += " and h.ad like '" + ad + "%'";
		}
		if (tel != null && tel != "") {
			
			sql += " and h.tel like '" + tel + "%'";
		}

		if (operasyonTip != null && !operasyonTip.equals("-1")) {

			sql += " and i.islem_tipi=" + operasyonTip;
		}
		if ( doktor !=-1 && doktor !=0  ) {
			
			sql += " and i.doktor_id=" + doktor;
		}
		if (soyad != null && soyad != "") {

			sql += " and h.soyad like '" + soyad + "%'";
		}
		if (protokolNo != null && protokolNo != "") {
			sql += " and h.protokol_no like '" + protokolNo + "%'";
		}
		if (doktorId != -1)
			sql = sql + " and d.d_member_id=" + doktorId;
		if (basTar != null && bitTar != null && !basTar.equals("")
				&& !bitTar.equals("")) {

			sql += " and h.eklenmeTarihi between date_format('" + basTar
					+ "','%Y-%m-%d') " + "and date_format('" + bitTar
					+ "','%Y-%m-%d')";
		}
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		logger.info(" kesinlesmemis operasyon listesi " + sql);

		list= new ArrayList<TIslemDTO>();

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TIslemDTO dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDisAdet(rs.getInt("dis_say"));

			if(dto.getIslemTarihi()!=null){
			String islemTarihiStr = sdf.format(dto.getIslemTarihi());
			dto.setIslemTarihiStr(islemTarihiStr);
			}
			
			dto.setDurumu(rs.getString("durum"));

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("islemAd"));
			dto.setIslemTip(islemTip);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			dto.setDoktor(doktorDTO);

			THastaDTO hasta = new THastaDTO();
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTel(rs.getString("tel"));
			hasta.setProtokolNo(rs.getString("protokol_no"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			dto.setHasta(hasta);

			list.add(dto);
		}
		}
		catch (Exception e) {
				e.printStackTrace();
		}
		finally{
			try {
				conn.close();
				conn=null;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		return list;
	}
	public Boolean kesinlesmemisOperasyonVarmi(int id, Connection conn)
			throws SQLException {

		String sql = " select * from t_islem i " + " where i.hasta_id=? "
				+ " and i.durum in ('K')";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info(" operasyon listesi " + sql);

		// List<TIslemDTO> list = new ArrayList<TIslemDTO>();
		stm.setInt(1, id);
		ResultSet rs = stm.executeQuery();

		Boolean var = false;

		if (rs.next()) {
			var = true;
		}
		return var;
	}

	public Integer getHastaSayisi(Connection conn, int subeId)
			throws SQLException {

		Integer hastaSayisi = null;

		String sql = " select count(*) sayi from t_hasta h " + " where  "
				+ " h.durum ='A' and h.sube_id=?";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);

		logger.info("getHastaSayisi :" + sql.toString());

		ResultSet rs = stm.executeQuery();

		if (rs.next()) {
			hastaSayisi = rs.getInt("sayi");

		}
		return hastaSayisi;
	}

	public List<Object[]> getDoktorIslemSayisi(Connection conn, int subeId)
			throws SQLException {

		List<Object[]> list = new ArrayList<Object[]>();
		String sql = "  select d.d_ad , d.d_soyad, t.ad, count(*) sayi from t_islem i, t_islem_tip t, t_hasta h , t_doktor d "
				+ " where  i.islem_tipi=t.id   and h.id=i.hasta_id and i.doktor_id=d.d_id and i.durum not in ('P, K')  and "
				+ " h.sube_id=?		group by d.d_ad,d.d_soyad,t.ad order by sayi desc limit 15; ";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);

		logger.info("getDoktorIslemSayisi :" + sql.toString());

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {

			Object[] holder = new Object[4];
			holder[0] = rs.getString("d_ad");
			holder[1] = rs.getString("d_soyad");
			holder[2] = rs.getString("ad");
			holder[3] = rs.getString("sayi");
			list.add(holder);
		}
		return list;
	}

	public Integer getOperasonuKesinlesmemisHastaSayisi(Connection conn,
			int subeId) throws SQLException {

		Integer hastaSayisi = null;

		String sql = " select count(*) sayi from  t_islem i, t_hasta h where i.durum='K' and "
				+ " i.hasta_id= h.id and h.durum not in ('P') and h.sube_id=?";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);

		ResultSet rs = stm.executeQuery();

		if (rs.next()) {
			hastaSayisi = rs.getInt("sayi");

		}
		return hastaSayisi;
	}

	public List<Object[]> getTopOperations(Connection conn, int subeId)
			throws SQLException {

		List<Object[]> list = new ArrayList<Object[]>();

		String sql = " select t.ad, count(*) sayi from t_islem i, t_islem_tip t, t_hasta h  ,t_doktor d " +
				"where "
				+ " i.islem_tipi=t.id"
				+ "   and h.id=i.hasta_id"
				+ "  and i.durum not in ('P, K')"
				+ "  and h.sube_id=? and i.doktor_id=d.d_id "
				+ "		group by t.ad order by sayi desc limit 10";

		PreparedStatement stm = conn.prepareStatement(sql);

		stm.setInt(1, subeId);

		ResultSet rs = stm.executeQuery();
		logger.info("getTopOperations"+" : " +sql.toString());

		while (rs.next()) {
			Object[] holder = new Object[2];
			holder[0] = rs.getString("ad");
			holder[1] = rs.getString("sayi");
			list.add(holder);

		}
		return list;
	}

	public List<Object[]> getTopGider(Connection conn, int subeId)
			throws SQLException {

		List<Object[]> list = new ArrayList<Object[]>();

		String sql = " 	select t.tur_ad ad, count(*) sayi, sum(g.miktar) toplam from t_gelir_gider g, t_tur_kod t where g.tip=2 "
				+ " and g.tur=t.tur_kod  and t.tur_durum='A' and tur_tip=1 and g.SUBE_ID=?  group by t.tur_ad order by toplam desc limit 5";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);

		ResultSet rs = stm.executeQuery();
		logger.info("getTopGider :" + sql.toString());

		while (rs.next()) {
			Object[] holder = new Object[3];
			holder[0] = rs.getString("ad");
			holder[1] = rs.getString("sayi");
			holder[2] = rs.getString("toplam");
			list.add(holder);

		}
		return list;
	}

	public List<SubeForm> getKullaniciSubeList(Connection conn, int ku_Id)
			throws SQLException {

		List<SubeForm> subeList = new ArrayList<SubeForm>();

		String sql = " select * from t_kullanici_sube k, t_sube s "
				+ " where k.ku_id=? "
				+ " and k.sube_id=s.sb_id and s.sb_durum='A' and k.durum='A' order by k.id ";

		PreparedStatement stm = conn.prepareStatement(sql);

		stm.setInt(1, ku_Id);
		ResultSet rs = stm.executeQuery();

		logger.info("getKullaniciSubeList" + " : " + sql.toString());

		while (rs.next()) {

			SubeForm dto = new SubeForm();

			dto.setKullaniciSubeId(rs.getInt("id"));
			dto.setsId(rs.getInt("sb_id"));
			dto.setsAd(rs.getString("sb_ad"));
			dto.setsAdres(rs.getString("sb_adres"));
			dto.setsTel(rs.getString("sb_tel"));

			subeList.add(dto);

		}
		return subeList;
	}

	public TSubeDTO getSubeBilgi(Connection connection, int subeId)
			throws SQLException {
		TSubeDTO dto = null;

		String sql = " select * from t_sube where sb_id=? ";

		PreparedStatement stm;

		stm = connection.prepareStatement(sql);
		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();

		logger.info("getSubeBilgi" + " : " + sql.toString());

		if (rs.next()) {
			dto = new TSubeDTO();
			dto.setsId(rs.getInt("sb_id"));
			dto.setsAd(rs.getString("sb_ad"));
			dto.setsAdres(rs.getString("sb_adres"));
			dto.setsTel(rs.getString("sb_tel"));
		}

		return dto;
	}

	public List<TDoktorDTO> getDoktorList(Connection connection, int subeId, boolean getRandevu)
			throws SQLException {

		List<TDoktorDTO> doktorList = new ArrayList<TDoktorDTO>();
		String sql = " select * from t_doktor d , t_doktor_sube s"
				+ " where s.sb_id=? and s.d_id=d.d_id and d.d_durum='A' and d.d_aktif='A'";

		PreparedStatement stm;

		stm = connection.prepareStatement(sql);
		stm.setInt(1, subeId);
		ResultSet rs = stm.executeQuery();
		logger.info(sql);

		while (rs.next()) {
			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdId(rs.getInt("d_id"));
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			doktorDTO.setdDurum(rs.getString("d_durum"));
			doktorDTO.setdAktif(rs.getString("d_aktif"));
		
			if(getRandevu){
				doktorDTO.setDoktorRandevuList(getRandevuListesi(connection,subeId,doktorDTO.getdId()));
			}
			
			doktorList.add(doktorDTO);
		}

		return doktorList;
	}

	public List<DoktorForm> getDoktorList(Connection connection, String dAd)
			throws SQLException {

		List<DoktorForm> doktorList = new ArrayList<DoktorForm>();
		String sql = " select  * from    `t_doktor` `d`,    `t_kullanici_login` `l`,"
				+ " t_kullanici_bilgi b where    `d`.`d_member_id` = `l`.`ku_id` "
				+ " and `d_durum` = 'A'  and `l`.`durum` = 'A'    "
				+ " and l.ku_id=b.ku_login_id ";

		if (dAd != null && dAd != "") {

			sql += " and d.d_ad like '" + dAd + "%'";
		}

		PreparedStatement stm;

		stm = connection.prepareStatement(sql);

		ResultSet rs = stm.executeQuery();
		logger.info(sql);

		while (rs.next()) {
			DoktorForm doktorDTO = new DoktorForm();
			doktorDTO.setdId(rs.getInt("d_id"));
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			doktorDTO.setDmemberId(rs.getInt("d_member_id"));

			doktorDTO.setUserName(rs.getString("ku_mail"));
			doktorDTO.setAd(rs.getString("ad"));
			doktorDTO.setSoyad(rs.getString("soyad"));
			doktorDTO.setGiderKodu(rs.getString("gider_kodu"));
			doktorDTO.setKuSubeList(getDoktorSubeList(connection,
					doktorDTO.getdId()));
			doktorList.add(doktorDTO);
		}

		return doktorList;
	}

	private List<SubeForm> getDoktorSubeList(Connection conn, int dId)
			throws SQLException {

		List<SubeForm> subeList = new ArrayList<SubeForm>();

		String sql = " select * from t_doktor_sube d, t_sube s "
				+ " where d.d_id=? "
				+ " and d.sb_id=s.sb_id and s.sb_durum='A' and d.durum='A' ";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info(sql);
		stm.setInt(1, dId);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {

			SubeForm dto = new SubeForm();

			dto.setDoktorSubeId(rs.getInt("id"));
			dto.setsId(rs.getInt("sb_id"));
			dto.setsAd(rs.getString("sb_ad"));
			dto.setsAdres(rs.getString("sb_adres"));
			dto.setsTel(rs.getString("sb_tel"));

			subeList.add(dto);

		}
		return subeList;
	}

	public List<TSubeDTO> getSubeList(Connection connection, String subeAd)
			throws SQLException {

		List<TSubeDTO> subeList = new ArrayList<TSubeDTO>();
		String sql = " select * from t_sube where 1=1 and sb_durum ='A' ";
		if (subeAd != null && !subeAd.equals(""))
			sql += "and sb_ad like '" + subeAd + "%'";

		PreparedStatement stm;

		stm = connection.prepareStatement(sql);

		ResultSet rs = stm.executeQuery();
		logger.info(sql);

		while (rs.next()) {
			TSubeDTO subeDTO = new TSubeDTO();
			subeDTO.setsAd(rs.getString("sb_ad"));
			subeDTO.setsId(rs.getInt("sb_id"));
			subeList.add(subeDTO);

		}

		return subeList;
	}

	public List<LoginForm> getKullaniciList(Connection conn, String kuAd)
			throws SQLException {

		List<LoginForm> list = new ArrayList<LoginForm>();
		String sql = " SELECT * FROM "
				+ " t_kullanici_login l, t_kullanici_bilgi b "
				+ " where l.ku_id= b.ku_login_id "
				+ " and l.durum='A' and l.ku_tur <>1 ";

		if (kuAd != null && !kuAd.equals("")) {
			sql += " and l.ku_mail like '" + kuAd + "%'";
		}
		sql += " order by  l.ku_mail ";

		PreparedStatement stm;

		stm = conn.prepareStatement(sql);

		ResultSet rs = stm.executeQuery();
		logger.info(sql);

		while (rs.next()) {
			LoginForm frm = new LoginForm();
			frm.setUserName(rs.getString("KU_MAIL"));
			frm.setPassword(rs.getString("KU_SIFRE"));
			frm.setKuTur(rs.getString("KU_TUR"));
			frm.setAd(rs.getString("AD"));
			frm.setSoyad(rs.getString("SOYAD"));
			frm.setTel(rs.getString("TELEFON"));
			frm.setAdres(rs.getString("ADRES"));
			frm.setKuBilgiId(rs.getInt("KU_ID"));
			frm.setKuloginId(rs.getInt("KU_LOGIN_ID"));
			frm.setGiderKodu(rs.getString("GIDER_KODU"));
			frm.setKuSubeList(getKullaniciSubeList(conn, frm.getKuloginId()));
			list.add(frm);
		}

		return list;

	}

	public LoginForm getKullanici(Connection conn, int kuloginId)
			throws SQLException {
		String sql = " SELECT * FROM "
				+ " t_kullanici_login l, t_kullanici_bilgi b "
				+ " where l.ku_id= b.ku_login_id "
				+ " and l.durum='A' and l.ku_id= " + kuloginId;

		PreparedStatement stm;

		stm = conn.prepareStatement(sql);

		ResultSet rs = stm.executeQuery();
		logger.info(sql);

		LoginForm frm = null;
		while (rs.next()) {
			frm = new LoginForm();
			frm.setUserName(rs.getString("KU_MAIL"));
			frm.setPassword(rs.getString("KU_SIFRE"));
			frm.setKuTur(rs.getString("KU_TUR"));
			frm.setAd(rs.getString("AD"));
			frm.setSoyad(rs.getString("SOYAD"));
			frm.setTel(rs.getString("TELEFON"));
			frm.setAdres(rs.getString("ADRES"));
			frm.setKuBilgiId(rs.getInt("KU_ID"));
			frm.setKuloginId(rs.getInt("KU_LOGIN_ID"));
			frm.setGiderKodu(rs.getString("GIDER_KODU"));

		}
		return frm;
	}

	public List<TTurKodDTO> getGiderTurList(Connection connection, int subeId)
			throws SQLException {

		List<TTurKodDTO> giderTurList = new ArrayList<TTurKodDTO>();
		String sql = " select * from t_tur_kod t , t_tur_kod_sube s"
				+ " where  s.tk_id=t.TUR_ID and t.TUR_TIP=1 AND "
				+ " t.TUR_DURUM='A' ";

		if (subeId != -1) {
			sql += " and s.sube_id=? ";
		}

		sql += " order by t.TUR_AD";

		PreparedStatement stm;

		stm = connection.prepareStatement(sql);

		if (subeId != -1)
			stm.setInt(1, subeId);

		logger.info(sql);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TTurKodDTO dto = new TTurKodDTO();
			dto.setTurId(rs.getInt("TUR_ID"));
			dto.setTurAd(rs.getString("TUR_AD"));
			dto.setTurKod(rs.getInt("TUR_KOD"));
			dto.setTurTip(rs.getInt("TUR_TIP"));
			giderTurList.add(dto);
		}

		return giderTurList;

	}

	public List<TTurKodDTO> getGiderTurList(Connection connection)
			throws SQLException {

		List<TTurKodDTO> giderTurList = new ArrayList<TTurKodDTO>();
		String sql = " select * from t_tur_kod t " + " where  t.TUR_TIP=1 AND "
				+ " t.TUR_DURUM='A' order by t.TUR_ID";

		PreparedStatement stm;

		stm = connection.prepareStatement(sql);

		logger.info(sql);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TTurKodDTO dto = new TTurKodDTO();
			dto.setTurId(rs.getInt("TUR_ID"));
			dto.setTurAd(rs.getString("TUR_AD"));
			dto.setTurKod(rs.getInt("TUR_KOD"));
			dto.setTurTip(rs.getInt("TUR_TIP"));
			dto.setTurSubeList(getTurSubeList(connection, dto.getTurId()));
			giderTurList.add(dto);
		}

		return giderTurList;

	}

	private List<SubeForm> getTurSubeList(Connection connection, int turId)
			throws SQLException {
		List<SubeForm> subeList = new ArrayList<SubeForm>();

		String sql = " select * from t_tur_kod_sube k, t_sube s " +

		" where k.tk_id=? "
				+ " and k.sube_id=s.sb_id and s.sb_durum='A' and k.durum='A' ";

		PreparedStatement stm = connection.prepareStatement(sql);
		logger.info(sql);
		stm.setInt(1, turId);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {

			SubeForm dto = new SubeForm();
			dto.setGiderTuruSubeId(rs.getInt("id"));
			dto.setsId(rs.getInt("sb_id"));
			dto.setsAd(rs.getString("sb_ad"));
			dto.setsAdres(rs.getString("sb_adres"));
			dto.setsTel(rs.getString("sb_tel"));
			subeList.add(dto);

		}
		return subeList;
	}

	public TTurKodDTO getGiderTur(Connection connection, String turId)
			throws SQLException {
		TTurKodDTO dto = null;
		String sql = " select * from t_tur_kod t " + " where  t.TUR_TIP=1 AND "
				+ " t.TUR_DURUM='A' and t.TUR_ID=? order by t.TUR_AD";
		PreparedStatement stm;
		stm = connection.prepareStatement(sql);
		stm.setInt(1, Integer.parseInt(turId));

		logger.info(sql);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			dto = new TTurKodDTO();
			dto.setTurId(rs.getInt("TUR_ID"));
			dto.setTurAd(rs.getString("TUR_AD"));
			dto.setTurKod(rs.getInt("TUR_KOD"));
			dto.setTurTip(rs.getInt("TUR_TIP"));
			dto.setTurSubeList(getTurSubeList(connection, dto.getTurId()));
		}
		return dto;
	}

	public List<TMenuDTO> getMenuList(Connection connection, int rol_id,
			int ust_menu_id) throws SQLException {

		List<TMenuDTO> list = new ArrayList<TMenuDTO>();

		String sql = " select * "
				+ " from t_menu m, t_rol_menu r "
				+ " where r.rol_id=? and m.id=r.menu_id and m.durum='A' AND r.durum='A' ";
		if (ust_menu_id != -1) {
			sql += " and m.ust_menu_id =" + ust_menu_id;
		}
		sql = sql + " ORDER BY sira ";

		PreparedStatement stm = connection.prepareStatement(sql);
		logger.info(sql);
		stm.setInt(1, rol_id);
		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TMenuDTO dto = new TMenuDTO();
			dto.setId(rs.getInt("id"));
			dto.setUstMenuId(rs.getInt("ust_menu_id"));
			dto.setMenuAd(rs.getString("menu_ad"));
			dto.setMenuPath(rs.getString("menu_path"));
			dto.setMenuPage(rs.getString("menu_page"));
			dto.setDataTarget(rs.getString("data_target"));
			dto.setDataToggle(rs.getString("data_toggle"));
			list.add(dto);
		}
		return list;
	}

	public Double getImplantDestekBirimFiyat(Connection connection)
			throws SQLException {

		Double miktar = null;

		String sql = " select * "
				+ " from t_kodlar r"
				+ " where r.TABLO='GENEL' and r.kod='IMP_BIRIM_FIYAT' AND r.durum='A'  ";

		PreparedStatement stm = connection.prepareStatement(sql);
		logger.info(sql);

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {

			miktar = new Double(rs.getString("deger"));
		}
		return miktar;

	}

	public Double getImplantCerrahBirimFiyat(Connection connection)
			throws SQLException {

		Double miktar = null;

		String sql = " select * "
				+ " from t_kodlar r"
				+ " where r.TABLO='GENEL' and r.kod='IMP_CERRAH_BIRIM_FIYAT' AND r.durum='A'  ";

		PreparedStatement stm = connection.prepareStatement(sql);
		logger.info(sql);

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {

			miktar = new Double(rs.getString("deger"));
		}
		return miktar;

	}

	public Double getIslemBirimFiyat(Connection connection) throws SQLException {

		Double miktar = null;

		String sql = " select * "
				+ " from t_kodlar r"
				+ " where r.TABLO='GENEL' and r.kod='GENEL_ISLEM_KATSAYI' AND r.durum='A'  ";

		PreparedStatement stm = connection.prepareStatement(sql);
		logger.info(sql);

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {

			miktar = new Double(rs.getString("deger"));
		}
		return miktar;

	}

	public TLabrotuvarDTO getLabratuvarIslem(Connection conn, int labIslemId)
			throws SQLException {

		String sql = "SELECT  isl.dis_say, sube.sb_ad, has.ad, has.soyad,has.protokol_no, dok.d_ad, dok.d_soyad ,tip.ad islemAd, "
				+ " lab.*"
				+ " FROM "
				+ " t_labratuvar lab, "
				+ " t_islem isl, "
				+ " t_islem_tip tip, "
				+ " t_hasta has, "
				+ " t_sube sube, "
				+ " t_doktor dok "
				+ " WHERE isl.id=lab.islem_id "
				+ " and isl.islem_tipi=tip.id "
				+ " and isl.hasta_id=has.id "
				+ " and sube.sb_id=has.sube_id "
				+ " and isl.doktor_id= dok.d_id and lab.durum <>'P'  ";

		if (labIslemId != -1)
			sql += " and lab.id=" + labIslemId;

		sql += " order by lab.klinik_cikis_tar";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("getLabratuvarIslem SQL = " + sql);

		ResultSet rs = stm.executeQuery();
		TLabrotuvarDTO dto = null;

		while (rs.next()) {
			dto = new TLabrotuvarDTO();

			TSubeDTO subeDTO = new TSubeDTO();
			subeDTO.setsAd(rs.getString("sb_ad"));
			dto.setSubeDTO(subeDTO);

			THastaDTO hastaDTO = new THastaDTO();
			hastaDTO.setAd(rs.getString("ad"));
			hastaDTO.setSoyad(rs.getString("soyad"));
			hastaDTO.setProtokolNo(rs.getString("protokol_no"));
			dto.setHastaDTO(hastaDTO);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			dto.setDoktorDTO(doktorDTO);

			TIslemTipDTO islemTipDTO = new TIslemTipDTO();
			islemTipDTO.setAd(rs.getString("islemAd"));
			dto.setIslemTipDTO(islemTipDTO);

			dto.setKlinikCikisTar(rs.getDate("klinik_cikis_tar"));
			dto.setDurum(rs.getString("durum"));
			dto.setIslemId(rs.getInt("islem_id"));
			dto.setId(rs.getInt("id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setLabCikisTar(rs.getDate("lab_cikis_tar"));
			dto.setLabAciklama(rs.getString("lab_aciklama"));
			dto.setLabIslemTipId(rs.getInt("lab_islem_tip_id"));
			dto.setLabIslemTipAd(getLabIslemTipAd(conn, dto.getLabIslemTipId()));
			dto.setLaboratuvarIslemDurum(getLabratuvarIslemDurum(dto.getDurum()));
			dto.setDisSay(rs.getInt("dis_say"));
			dto.setPuan(rs.getString("puan"));
			dto.setKlinikDegerlendirmeTar(rs
					.getDate("klinik_degerlendirme_tar"));

			dto.setProvaList(getLabratuvarProvaList(conn, dto.getId()));

		}
		return dto;
	}

	public List<TLabrotuvarProvaDTO> getLabratuvarProvaList(Connection conn,
			int labIslemId) throws SQLException {

		String sql = "SELECT p.* FROM t_labratuvar lab, t_labratuvar_prova p "
				+ " where p.lab_islem_id=lab.id and p.durum <>'P'  ";

		if (labIslemId != -1)
			sql += " and p.lab_islem_id=" + labIslemId;

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("getLabratuvarProvaList SQL = " + sql);

		List<TLabrotuvarProvaDTO> list = new ArrayList<TLabrotuvarProvaDTO>();

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TLabrotuvarProvaDTO dto = new TLabrotuvarProvaDTO();
			dto.setId(rs.getInt("id"));
			dto.setLabIslemId(rs.getInt("lab_islem_id"));
			dto.setProvaTip(rs.getInt("prova_tip"));
			dto.setProvaTar(rs.getDate("prova_tar"));
			ProvaTip provaTip = null;

			for (ProvaTip tip : ProvaTip.values()) {
				if (tip.getVal() == dto.getProvaTip())
					provaTip = tip;
			}
			dto.setProvaTipEnm(provaTip);
			dto.setDurum(rs.getString("durum"));
			list.add(dto);
		}
		return list;
	}

	public List<TLabrotuvarDTO> getLabratuvarIslemList(Connection conn,
			ActionForm form) throws SQLException, ParseException {

		LabrotuvarForm labrotuvarForm = (LabrotuvarForm) form;
		Integer subeId = -1;
		if (!labrotuvarForm.getSube().equals("-1"))
			subeId = Integer.parseInt(labrotuvarForm.getSube());
		String durum = labrotuvarForm.getDurum();

		int labIslemTip = labrotuvarForm.getLabIslemTipId();

		String hastaAd = labrotuvarForm.getHastaAd();
		String hastaSOyad = labrotuvarForm.getHastaSoyad();
		String protokolNo = labrotuvarForm.getHastaProtokolNo();
		String klinikCikisTarBas = labrotuvarForm.getKlinikCikisTarBas();
		String klinikCikisTarBit = labrotuvarForm.getKlinikCikisTarBit();

		String sql = "SELECT isl.dis_say, sube.sb_ad, has.ad, has.soyad,has.protokol_no, dok.d_ad, dok.d_soyad ,tip.ad islemAd, "
				+ " lab.*"
				+ " FROM "
				+ " t_labratuvar lab, "
				+ " t_islem isl, "
				+ " t_islem_tip tip, "
				+ " t_hasta has, "
				+ " t_sube sube, "
				+ " t_doktor dok "
				+ " WHERE isl.id=lab.islem_id "
				+ " and isl.islem_tipi=tip.id "
				+ " and isl.hasta_id=has.id "
				+ " and sube.sb_id=has.sube_id "
				+ " and isl.doktor_id= dok.d_id and lab.durum <>'P' and has.durum <> 'P' and isl.durum <>'P' ";

		if (subeId != null && subeId.intValue() != -1)
			sql += " and has.sube_id=" + subeId.intValue();

		if (durum != null && !durum.equals("-1"))
			sql += " and lab.durum='" + durum + "'";

		if (labIslemTip != -1)
			sql += " and lab.lab_islem_tip_id='" + labIslemTip + "'";

		if (hastaAd != null && !hastaAd.equals(""))
			sql += " and has.ad like '" + hastaAd + "%'";

		if (hastaSOyad != null && !hastaSOyad.equals(""))
			sql += " and has.soyad like '" + hastaSOyad + "%'";

		if (protokolNo != null && !protokolNo.equals(""))
			sql += " and has.protokol_no like'" + protokolNo + "%'";

		if (klinikCikisTarBas != null && klinikCikisTarBit != null
				&& !klinikCikisTarBas.equals("")
				&& !klinikCikisTarBit.equals("")) {
			Date klinikCikisTrhBas = Commons
					.convertStringToDate(klinikCikisTarBas);
			Date klinikCikisTrhBit = Commons
					.convertStringToDate(klinikCikisTarBit);
			sql += "	and lab.klinik_cikis_tar between date_format('"
					+ klinikCikisTarBas + "','%Y-%m-%d') and date_format('"
					+ klinikCikisTarBit + "','%Y-%m-%d')";

		}
		sql += " order by lab.klinik_cikis_tar ";
		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("getLabratuvarIslemList SQL = " + sql);

		List<TLabrotuvarDTO> list = new ArrayList<TLabrotuvarDTO>();

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TLabrotuvarDTO dto = new TLabrotuvarDTO();

			TSubeDTO subeDTO = new TSubeDTO();
			subeDTO.setsAd(rs.getString("sb_ad"));
			dto.setSubeDTO(subeDTO);

			THastaDTO hastaDTO = new THastaDTO();
			hastaDTO.setAd(rs.getString("ad"));
			hastaDTO.setSoyad(rs.getString("soyad"));
			hastaDTO.setProtokolNo(rs.getString("protokol_no"));
			dto.setHastaDTO(hastaDTO);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			dto.setDoktorDTO(doktorDTO);

			TIslemTipDTO islemTipDTO = new TIslemTipDTO();
			islemTipDTO.setAd(rs.getString("islemAd"));
			dto.setIslemTipDTO(islemTipDTO);

			dto.setKlinikCikisTar(rs.getDate("klinik_cikis_tar"));
			dto.setDurum(rs.getString("durum"));
			dto.setIslemId(rs.getInt("islem_id"));
			dto.setId(rs.getInt("id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setLabAciklama(rs.getString("lab_aciklama"));
			dto.setLabIslemTipId(rs.getInt("lab_islem_tip_id"));
			dto.setLabCikisTar(rs.getDate("lab_cikis_tar"));
			dto.setLabIslemTipAd(getLabIslemTipAd(conn, dto.getLabIslemTipId()));
			dto.setLaboratuvarIslemDurum(getLabratuvarIslemDurum(dto.getDurum()));
			dto.setDisSay(rs.getInt("dis_say"));
			dto.setPuan(rs.getString("puan"));
			dto.setKlinikDegerlendirmeTar(rs
					.getDate("klinik_degerlendirme_tar"));

			dto.setProvaList(getLabratuvarProvaList(conn, dto.getId()));

			list.add(dto);
		}
		return list;
	}

	private LaboratuvarIslemDurum getLabratuvarIslemDurum(String durum) {
		LaboratuvarIslemDurum islemDurum = null;

		for (LaboratuvarIslemDurum dur : LaboratuvarIslemDurum.values()) {

			if (dur.getState().toString().equals(durum))
				islemDurum = dur;
		}
		return islemDurum;
	}

	public List<TLabrotuvarDTO> getOperasyonLabratuvarIslemList(
			Connection conn, int operasyonId) throws SQLException {

		String sql = "SELECT isl.dis_say,  sube.sb_ad, has.ad, has.soyad,has.protokol_no, dok.d_ad, dok.d_soyad ,tip.ad islemAd, "
				+ " lab.* "
				+ " FROM "
				+ " t_labratuvar lab, "
				+ " t_islem isl, "
				+ " t_islem_tip tip, "
				+ " t_hasta has, "
				+ " t_sube sube, "
				+ " t_doktor dok "
				+ " WHERE isl.id=lab.islem_id "
				+ " and isl.islem_tipi=tip.id "
				+ " and isl.hasta_id=has.id "
				+ " and sube.sb_id=has.sube_id "
				+ " and isl.doktor_id= dok.d_id and lab.durum not in ('D','P')  ";

		if (operasyonId != -1)
			sql += " and lab.islem_id=" + operasyonId;

		sql += " order by lab.klinik_cikis_tar";

		PreparedStatement stm = conn.prepareStatement(sql);
		logger.info("getLabratuvarOperasyonIslemList SQL = " + sql);

		ResultSet rs = stm.executeQuery();
		List<TLabrotuvarDTO> list = new ArrayList<TLabrotuvarDTO>();

		while (rs.next()) {
			TLabrotuvarDTO dto = new TLabrotuvarDTO();

			TSubeDTO subeDTO = new TSubeDTO();
			subeDTO.setsAd(rs.getString("sb_ad"));
			dto.setSubeDTO(subeDTO);

			THastaDTO hastaDTO = new THastaDTO();
			hastaDTO.setAd(rs.getString("ad"));
			hastaDTO.setSoyad(rs.getString("soyad"));
			hastaDTO.setProtokolNo(rs.getString("protokol_no"));
			dto.setHastaDTO(hastaDTO);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			dto.setDoktorDTO(doktorDTO);

			TIslemTipDTO islemTipDTO = new TIslemTipDTO();
			islemTipDTO.setAd(rs.getString("islemAd"));
			dto.setIslemTipDTO(islemTipDTO);

			dto.setKlinikCikisTar(rs.getDate("klinik_cikis_tar"));
			dto.setDurum(rs.getString("durum"));
			dto.setIslemId(rs.getInt("islem_id"));
			dto.setId(rs.getInt("id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setLabCikisTar(rs.getDate("lab_cikis_tar"));
			dto.setLabAciklama(rs.getString("lab_aciklama"));
			dto.setLabIslemTipId(rs.getInt("lab_islem_tip_id"));
			dto.setLabIslemTipAd(getLabIslemTipAd(conn, dto.getLabIslemTipId()));
			dto.setLaboratuvarIslemDurum(getLabratuvarIslemDurum(dto.getDurum()));
			dto.setDisSay(rs.getInt("dis_say"));
			dto.setPuan(rs.getString("puan"));
			dto.setKlinikDegerlendirmeTar(rs
					.getDate("klinik_degerlendirme_tar"));

			dto.setLaboratuvarIslemDurum(getLabratuvarIslemDurum(dto.getDurum()));

			dto.setProvaList(getLabratuvarProvaList(conn, dto.getId()));
			list.add(dto);

		}
		return list;
	}

	private String getLabIslemTipAd(Connection conn, int labIslemTipId)
			throws SQLException {

		String sql = "SELECT * from t_labratuvar_islem_tip where id="
				+ labIslemTipId;

		PreparedStatement stm = conn.prepareStatement(sql);

		ResultSet rs = stm.executeQuery();
		String ad = null;

		while (rs.next()) {
			ad = rs.getString("ad");
		}
		return ad;
	}
	
	
	public List<TIslemDTO> getHastaListesiForArama(
			Connection conn, int doktorId, int subeId, String tip,
			String protokolNo, String ad, String soyad, String basTar,
			String bitTar, String operasyonTip) throws SQLException {

		String sql = " select i.*,h.*,d.*, t.ad islemAd from t_islem i, t_hasta h, t_doktor d , t_islem_tip t "
				+ "	where 	"
				+ "	i.hasta_id= h.id and h.durum not in ('P')  "
				+ "	and i.doktor_id=d.d_id"
				+ "	and i.islem_tipi= t.id  and h.sube_id=? ";
//kesinlesmemis hasta listesi
		sql += " and i.durum='K' ";
		

		if (ad != null && ad != "") {

			sql += " and h.ad like '" + ad + "%'";
		}

		if (operasyonTip != null && !operasyonTip.equals("-1")) {

			sql += " and i.islem_tipi=" + operasyonTip;
		}
		if (soyad != null && soyad != "") {

			sql += " and h.soyad like '" + soyad + "%'";
		}
		if (protokolNo != null && protokolNo != "") {
			sql += " and h.protokol_no like '" + protokolNo + "%'";
		}
		if (doktorId != -1)
			sql = sql + " and d.d_member_id=" + doktorId;
		if (basTar != null && bitTar != null && !basTar.equals("")
				&& !bitTar.equals("")) {

			sql += " and h.eklenmeTarihi between date_format('" + basTar
					+ "','%Y-%m-%d') " + "and date_format('" + bitTar
					+ "','%Y-%m-%d')";
		}
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		logger.info(" getHastaListesiForArama " + sql);

		List<TIslemDTO> list = new ArrayList<TIslemDTO>();

		ResultSet rs = stm.executeQuery();

		while (rs.next()) {
			TIslemDTO dto = new TIslemDTO();

			dto.setId(rs.getInt("id"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setAciklama(rs.getString("aciklama"));
			dto.setDoktorId(rs.getInt("doktor_id"));
			dto.setMiktar(rs.getDouble("ucret"));
			dto.setIslemTipi(rs.getInt("islem_tipi"));
			dto.setIslemTarihi(rs.getDate("islem_tarihi"));
			dto.setIslemBitisTarihi(rs.getDate("islem_bitis_tarihi"));
			dto.setEklenmeTarihi(rs.getDate("eklenme_tarihi"));
			dto.setDisAdet(rs.getInt("dis_say"));

			if(dto.getIslemTarihi()!=null){
			dto.setIslemTarihiStr( sdf.format(dto.getIslemTarihi()));
			}
			
			dto.setDurumu(rs.getString("durum"));

			TIslemTipDTO islemTip = new TIslemTipDTO();
			islemTip.setAd(rs.getString("islemAd"));
			dto.setIslemTip(islemTip);

			TDoktorDTO doktorDTO = new TDoktorDTO();
			doktorDTO.setdAd(rs.getString("d_ad"));
			doktorDTO.setdSoyad(rs.getString("d_soyad"));
			doktorDTO.setdBrans(rs.getString("d_brans"));
			dto.setDoktor(doktorDTO);

			THastaDTO hasta = new THastaDTO();
			hasta.setAd(rs.getString("ad"));
			hasta.setSoyad(rs.getString("soyad"));
			hasta.setTel(rs.getString("tel"));
			hasta.setProtokolNo(rs.getString("protokol_no"));
			hasta.setTckimlik(rs.getString("tckimlik"));
			dto.setHasta(hasta);
			
			dto.setHastaAranmaSayisi(getIslemHastaAranmaSay(dto.getId()));

			list.add(dto);
		}
		return list;
	}

	private int getIslemHastaAranmaSay(int id) {
		
		// TODO Auto-generated method stub
		return 0;
	}

	public List<TAnketDTO> hastaAnketListesiGetir(Connection conn,
			int subeId, String protokolNo, String ad, String soyad,
			String basTar, String bitTar) throws SQLException {
		
		String sql = " select a.* , h.* from t_hasta h, t_anket a where a.hasta_id=h.id and h.durum='A' and a.durum='A' ";
				if (ad != null && ad != "") {

					sql += " and h.ad like '" + ad + "%'";
				}
				if (soyad != null && soyad != "") {

					sql += " and h.soyad like '" + soyad + "%'";
				}
				if (protokolNo != null && protokolNo != "") {
					sql += " and h.protokol_no like '" + protokolNo + "%'";
				}
				if (basTar != null && bitTar != null && !basTar.equals("")
						&& !bitTar.equals("")) {

					sql += " and a.tarih between date_format('" + basTar
							+ "','%Y-%m-%d') and date_format('" + bitTar
							+ "','%Y-%m-%d')";

				}

				sql += " and sube_id=? ";

		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		logger.info("getHastaAnketList :" + sql);

		List<TAnketDTO> list = new ArrayList<TAnketDTO>();
		ResultSet rs = stm.executeQuery();
		

		while (rs.next()) {
			TAnketDTO dto= new TAnketDTO();
			dto.setAciklama(rs.getString("aciklama"));
			dto.setTarih(rs.getDate("tarih"));
			dto.setSaat(rs.getString("saat"));
			dto.setHastaId(rs.getInt("hasta_id"));
			dto.setMemnuniyetDerecesi(rs.getString("memnuniyet_der"));
			dto.setId(rs.getInt("id"));
			
			THastaDTO hastaDTO= new THastaDTO();
			hastaDTO.setAd(rs.getString("ad"));
			hastaDTO.setSoyad(rs.getString("soyad"));
			hastaDTO.setTel(rs.getString("tel"));
			hastaDTO.setProtokolNo(rs.getString("protokol_no"));
			dto.setHasta(hastaDTO);
			
			
			list.add(dto);
		}
		return list;
	
	}
	
	public long getLastProtokolNo(Connection conn, int subeId) throws SQLException{
		
		String sql=" SELECT * FROM dfdiscom_db.t_hasta where sube_id=? order by id desc LIMIT 1";
		PreparedStatement stm = conn.prepareStatement(sql);
		stm.setInt(1, subeId);
		
		ResultSet rs = stm.executeQuery();
		
		int lastprotokolNo=0;
		String lastprotokolNoStr="";
		
		if (rs.next()) {
			lastprotokolNoStr=rs.getString("protokol_no");
		}
		
		lastprotokolNo= Integer.parseInt(lastprotokolNoStr);
		return lastprotokolNo;
		
	}
	
	public List<THastaIslemBorcTakipDTO> hastaBorcOdemeListesiGetir(Connection conn,
		  IslemBorcOdemeTakipForm form ) throws SQLException {
		
		String sql="SELECT brc.*, hasta.protokol_no, hasta.tel,  hasta.ad, hasta.soyad,  itip.ad islem_tip,  islem.ucret , sum(gel.miktar) toplam_odenen "+
				" FROM "+
				" dfdiscom_db.t_hasta_islem_borc_takip brc , "+
				" t_islem islem, t_islem_tip itip , "+
				" t_hasta hasta, t_hasta_gelir gel"+
				" where "+
				" brc.islem_id= islem.id"+
				" and islem.hasta_id= hasta.id"+
				" and islem.id= gel.islem_id"+
				" and  gel.odeme_turu not in(1) "+
				" and gel.durumu='A'"+
				" and brc.durum='A'"+
				" and islem.islem_tipi=itip.id"+
				" and islem.durum not in('P')";
				
				if(form.getSoyad()!= null && !form.getSoyad().equals(""))
				{
					sql=sql+" and hasta.soyad like '"+form.getSoyad()+"%' ";
				}
				if(form.getAd()!= null && !form.getAd().equals(""))
				{
					sql=sql+" and hasta.ad like '"+form.getAd()+"%' ";
				}
				if(form.getProtokolNo()!= null && !form.getProtokolNo().equals(""))
				{
					sql=sql+" and hasta.protokol_no like '"+form.getProtokolNo()+"%' ";
				}
				if (form.getBorcOdemeTarihiBaslamaStr() != null && form.getBorcOdemeTarihiBitisStr()  != null 
						&& !form.getBorcOdemeTarihiBaslamaStr().equals("")  && !form.getBorcOdemeTarihiBitisStr().equals("") )
				{
					sql += " and brc.borc_odeme_tarihi between date_format('" + form.getBorcOdemeTarihiBaslamaStr() 
							+ "','%Y-%m-%d') and date_format('" + form.getBorcOdemeTarihiBitisStr()
							+ "','%Y-%m-%d')";

				}

				
				sql=sql+" group by gel.islem_id ";
		
		PreparedStatement stm = conn.prepareStatement(sql);
		
		logger.info("getBorcOdemeList :" + sql);
		
		List<THastaIslemBorcTakipDTO> list = new ArrayList<THastaIslemBorcTakipDTO>();
		ResultSet rs = stm.executeQuery();
		
		
		while (rs.next()) {
			THastaIslemBorcTakipDTO dto= new THastaIslemBorcTakipDTO();
			dto.setAciklama(rs.getString("aciklama"));
			dto.setMiktar(rs.getDouble("miktar"));
			dto.setBorcOdemeTarihi(rs.getDate("borc_odeme_tarihi"));
			dto.setId(rs.getInt("id"));
			
		
			THastaDTO hastaDTO= new THastaDTO();
			hastaDTO.setAd(rs.getString("ad"));
			hastaDTO.setSoyad(rs.getString("soyad"));
			hastaDTO.setTel(rs.getString("tel"));
			hastaDTO.setProtokolNo(rs.getString("protokol_no"));
			
			TIslemDTO islemDTO = new  TIslemDTO();
			
			islemDTO.setHasta(hastaDTO);
			
			TIslemTipDTO islemTipDTO= new TIslemTipDTO();
			islemTipDTO.setAd(rs.getString("islem_tip"));
			islemDTO.setIslemTip(islemTipDTO);
			
			islemDTO.setMiktar(rs.getDouble("ucret"));
			islemDTO.setToplamOdenenMiktar(rs.getDouble("toplam_odenen"));
			islemDTO.setKalanMiktar(islemDTO.getMiktar()-islemDTO.getToplamOdenenMiktar());
			
			dto.setIslemDTO(islemDTO);
			
			list.add(dto);
		}
		return list;
		
	}

	
}
