package tr.com.fdd.utils.enums;

public enum LaboratuvarIslemDurum {

	LABRATUVARDA("A"), KLINIK_ONAYDA("B"), LAB_ISLEM_OK("C"), LAB_ISLEM_RED("D");

	private String state;

	private LaboratuvarIslemDurum(String state) {
		this.setState(state);
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	
	public final String getToString() {
		return toString();
	}

	
	@Override
	public String toString() {
		
		if(this==LABRATUVARDA) return "Laboratuvarda";
		else if(this==KLINIK_ONAYDA) return "Klinik Onayda";
		else if(this==LAB_ISLEM_OK) return "Laboratuvar iþlemi tamamlandý";
		else if(this==LAB_ISLEM_RED) return "Laboratuvar iþlemi reddedildi.";
		
		return super.toString();
	}
	

}
