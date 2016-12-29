package tr.com.fdd.utils.enums;

public enum ProvaTip {

	METAL(1), ISKELET(2), ZIRKON(3), DISLI(4), DENTIN(5);

	private int val;

	private ProvaTip(int value) {

		this.val = value;
	}

	
	@Override
	public String toString() {
		if(this.ordinal()==METAL.ordinal()) return "Metal";
		else if(this.ordinal()==ISKELET.ordinal()) return "Ýskelet";
		else if(this.ordinal()==ZIRKON.ordinal()) return "Zirkon";
		else if(this.ordinal()==DISLI.ordinal()) return "Diþli";
		else if(this.ordinal()==DENTIN.ordinal()) return "Dentin";		
		
		return super.toString();
	}


	public int getVal() {
		return val;
	}


	public void setVal(int val) {
		this.val = val;
	}
}
