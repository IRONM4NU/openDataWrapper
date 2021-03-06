package opendatawrapper;

public class MappingUnit {

	public String vocabulaire;
	public String type;
	public boolean ignore;

	public MappingUnit(String vocabulaire, String type) {
		super();
		this.vocabulaire = vocabulaire;
		this.type = type;
		ignore = false;
	}

	public MappingUnit(String prop) {
		super();
		String[] splitProp = prop.split(",");
		if (splitProp.length >= 2) {
			this.vocabulaire = splitProp[0];
			this.type = splitProp[1];
		} else {
			if (prop.equals("ignore")) {
				ignore = true;
			} else {
				System.err.println("la propriété n'est pas complète " + prop);
			}
		}
	}

	public String getVocabulaire() {
		return vocabulaire;
	}

	public String getType() {
		return type;
	}
}
