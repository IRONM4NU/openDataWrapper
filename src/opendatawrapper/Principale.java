package opendatawrapper;

import java.util.InputMismatchException;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

public class Principale {

	public static Map<Integer, DataSource> listeDataSource;

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		// TODO
		/*
		 * This will be the front door of the application The wrapper will know
		 * what data it is supposed to transform what method it will use if he
		 * can contact the API or must use a file
		 */

		LoadRessources lr = new LoadRessources();
		listeDataSource = lr.extractData();
		System.out.println("loading...");

		Scanner in = new Scanner(System.in);
		try {
			int result = 0;
			while (result >= 0) {

				System.out.println("################################\n"
						+ "welcome in the openData Wrapper!\n"
						+ " What do you want to do?\n"
						+ "[1] List datasources\n"
						+ "[2] Convert one data into turtle\n"
						+ "[3] Convert all data into turtle\n"
						+ "[4] Convert one data into RDF/XML\n"
						+ "[5] Convert all data into RDF/XML\n" + "[6] Quit\n");
				result = in.nextInt();

				switch (result) {
				case 1:
					listDatasources();
					break;
				case 2:
					conversionTtlOne();
					break;
				case 3:
					conversionTtlAll();
					break;
				case 4:
					conversionXmlOne();
					break;
				case 5:
					conversionXmlAll();
					break;
				default:
					// on quitte
					result = -1;
					break;
				}
			}
			System.out.println("Exiting...");
		} catch (InputMismatchException e) {
			System.err.println("la saisie effectué n'est pas un nombre!");
		}
	}

	private static void listDatasources() {
		// TODO Auto-generated method stub
		Set<Integer> nomData = listeDataSource.keySet();
		Iterator<Integer> it = nomData.iterator();
		System.out.println("Liste des dataset:");
		while (it.hasNext()) {
			Integer courant = it.next();
			System.out.println("[" + courant + "] "
					+ listeDataSource.get(courant).getNom());
		}
	}

	/*
	 * conversion processing
	 * 
	 * @param DataSource dts, the DataSource ressource you want to convert
	 */
	private static void conversionTtl(DataSource dts) {
		if (dts.getFormat().equals("XML")) {
			ConvertXML cxml = new ConvertXML(dts.getXsltFile(),
					dts.getOutputTtl());
			if (dts.isApi()) {
				cxml.convertFromApi(dts.getApiUrl());
			} else {
				cxml.convertfromFile(dts.getFilePath());
			}
		} else {
			if (dts.getFormat().equals("CSV")) {
				ConvertCSV ccsv = new ConvertCSV(dts.getXsltFile(),
						dts.getOutputTtl());
				ccsv.convertfromFile(dts.getFilePath());
			} else {
				System.err.println("the format " + dts.getFormat()
						+ " is not supported yet!");
			}
		}
	}

	/*
	 * Select the dataset to convert by asking the user
	 */
	private static void conversionTtlOne() {
		System.out.println("Which dataset?");
		listDatasources();
		Scanner in = new Scanner(System.in);
		try {
			int result = in.nextInt();
			DataSource dts = listeDataSource.get(result);
			if (dts.getFormat().equals("XML")) {
				conversionTtl(dts);
				System.out.println("conversion ok!");
			} else {
				System.err
						.println("le format de fichier n'est pas supporté pour le moment!");
			}
		} catch (InputMismatchException e) {
			System.err.println("la saisie effectué n'est pas un nombre!");
		}
	}

	/*
	 * Convert all dataset listed in listeDataSource accordingly to
	 * dataSources.xml
	 */
	private static void conversionTtlAll() {
		Set<Integer> listeData = listeDataSource.keySet();

		Iterator<Integer> it = listeData.iterator();
		int courant;
		DataSource dts = null;
		while (it.hasNext()) {
			courant = it.next();
			dts = listeDataSource.get(courant);
			if (dts.getFormat().equals("XML")) {
				conversionTtl(dts);
			}
		}
	}

	private static void conversionXmlOne() {
		System.out.println("Which dataset?");
		listDatasources();
		Scanner in = new Scanner(System.in);
		try {
			int result = in.nextInt();
			DataSource dts = listeDataSource.get(result);
			if (dts.getFormat().equals("XML")) {
				conversionTtl(dts);
				conversionXmlRdf(dts);
				System.out.println("conversion ok!");
			} else {
				System.err
						.println("le format de fichier n'est pas supporté pour le moment!");
			}
		} catch (InputMismatchException e) {
			System.err.println("la saisie effectué n'est pas un nombre!");
		}
	}

	private static void conversionXmlAll() {
		Set<Integer> listeData = listeDataSource.keySet();

		Iterator<Integer> it = listeData.iterator();
		int courant;
		DataSource dts = null;
		while (it.hasNext()) {
			courant = it.next();
			dts = listeDataSource.get(courant);
			if (dts.getFormat().equals("XML")) {
				conversionTtl(dts);
				conversionXmlRdf(dts);
			}
		}
	}

	private static void conversionXmlRdf(DataSource dts) {
		ConvertTtl cttl = new ConvertTtl(dts.getOutputTtl(), dts.getOutputRdf());
		cttl.convert();
	}
}
