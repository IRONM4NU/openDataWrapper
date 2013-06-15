package opendatawrapper;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.net.Authenticator;
import java.net.MalformedURLException;
import java.net.PasswordAuthentication;
import java.net.URL;
import java.net.URLConnection;
import java.util.Properties;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.jdom2.Document;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.DOMOutputter;

/*
 * Cette classe gère la conversion d'un XML à l'aide d'une feuille de style XSL (XSLT)
 * Les parametres de proxy sont à spécifier dans un fichier proxy.pwd à la racine de votre $HOME
 */
public class ConvertXML {

	public String XMLFile_;
	public String XSLFile_;
	public String outputFile;
	public String mappingPath;

	String proxyHost;
	String proxyPort;
	String authUser;
	String authPassword;
	final String PWD_File = System.getProperty("user.home") + "/proxy.pwd";

	/*
	 * Constructeur
	 * 
	 * @param XMLin le fichier à convertir
	 * 
	 * @param XSL le fichier de convertion
	 * 
	 * @param XMLout le dossier qui contiendra le fichier converti
	 */
	public ConvertXML(String XSLin, String XMLout, String mappingPath) {
		XSLFile_ = XSLin;
		outputFile = XMLout;
		this.mappingPath = mappingPath;

		try {
			Properties prop = new Properties();
			prop.load(new FileReader(PWD_File));
			proxyHost = prop.getProperty("proxyHost");
			proxyPort = prop.getProperty("proxyPort");
			authUser = prop.getProperty("authUser");
			authPassword = prop.getProperty("authPassword");
		} catch (Exception e) {
		}

	}

	/*
	 * Convert the local XML file into Turtle
	 */
	public void convertfromFile(String XMLFile_, Properties p) {
		SAXBuilder sxb = new SAXBuilder();
		try {
			constructXSL(p, sxb.build(new File(XMLFile_)));
			TransformerFactory tFactory = TransformerFactory.newInstance();
			Transformer transformer = tFactory.newTransformer(new StreamSource(
					new File(XSLFile_)));
			transformer.transform(new StreamSource(new File(XMLFile_)),
					new StreamResult(new File(outputFile)));
		} catch (TransformerConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JDOMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	 * convert an XML file from a remote call into turtle. It uses the global
	 * paramters XSLFile_ and outputFile of the class ConvertXML
	 * 
	 * @param url, the URL of the remote API *
	 */
	public void convertFromApi(String url, Properties p) {
		Document document = getRemoteXML(url);
		if (document != null) {
			if (constructXSL(p, document)) {
				DOMOutputter domOutputter = new DOMOutputter();
				org.w3c.dom.Document w3cDoc;

				try {
					// on convertit le doc de jdom en doc de dom
					w3cDoc = domOutputter.output(document);

					// on prepare le transformer
					TransformerFactory tFactory = TransformerFactory
							.newInstance();
					Transformer transformer = tFactory
							.newTransformer(new StreamSource(new File(XSLFile_)));

					// on convertit la source et la sortie
					Source source = new DOMSource(w3cDoc);
					Result output = new StreamResult(outputFile);

					transformer.transform(source, output);

				} catch (JDOMException e1) {
					// TODO Auto-generated catch block
					System.err
							.println("Unable to parse the incoming XML file. It could be a network issue, or the file isn't an XML file. "
									+ e1.getMessage());
					return;
				} catch (TransformerException e) {
					// TODO Auto-generated catch block
					System.err
							.println("Erreur lors de la transformation du XML"
									+ e.getMessageAndLocation());
					return;
				}
			} else {
				return;
			}
		} else {
			System.err
					.println("erreur lors de la récupération des données distantes. Le fichier est nul");
			return;
		}

	}

	/*
	 * This method contact the remote API, download and parse the XML received
	 * First, it needs to be configured to use proxy (if needed).
	 * 
	 * @param url, the url of the remote API.
	 */
	public Document getRemoteXML(String url) {
		InputStream stream = null;
		URL url_;

		try {
			if (proxyHost != null) {
				// on ne charge le proxy que si besoin est => si un proxyhost a
				// été défini
				System.setProperty("proxySet", "true");
				System.setProperty("http.proxyHost", proxyHost);
				System.setProperty("http.proxyPort", proxyPort);
				if (authUser != null) {
					// le proxy est détecté comme sécurisé par identification si
					// le authuser est défini
					System.setProperty("http.auth.preference", "Basic");
					Authenticator.setDefault(new Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {

							return new PasswordAuthentication(authUser,
									authPassword.toCharArray());
						}
					});
				}
			}
			System.out.println("connecting to " + url + "...");
			url_ = new URL(url);
			URLConnection connection = url_.openConnection();
			stream = connection.getInputStream();
			System.out.println("data received!");
			return new SAXBuilder().build(stream);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			System.err.println("l'URL demandée n'est pas correcte! "
					+ e.getMessage());
			return null;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err
					.println("probleme de gestion du stream de donnée! Etes-vous connecté à internet? ("
							+ e.getMessage() + ")");
			System.err
					.println("Vérifiez que vous n'etes pas derriere un proxy. Dans le cas positif, vérifez vos paramètres proxy! ");
			return null;
		} catch (JDOMException e) {
			// TODO Auto-generated catch block
			System.err
					.println("erreur lors de l'intéprétation de l'XML reçu! ("
							+ e.getMessage() + ")");
			return null;
		}
	}

	public boolean constructXSL(Properties p, Document document) {
		XSLConstructor xslc = new XSLConstructor(XSLFile_, document, p);
		return xslc.construct(mappingPath);

	}
}
