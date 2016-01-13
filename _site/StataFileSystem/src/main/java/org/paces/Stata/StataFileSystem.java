package org.paces.Stata;

import com.stata.sfi.Macro;
import com.stata.sfi.SFIToolkit;

import java.io.IOException;

/**
 * @author Billy Buchanan
 * @version 0.0.0
 */
public class StataFileSystem {

	/***
	 * Method used to retrieve the created, modified, and last accessed dates
	 * for a given file
	 * @param args First element of the string array must be the filepath,
	 *             Second element identifies if the OS is Windoze or not,
	 *             Third element used to print results to Stata console
	 * @throws IOException An exception thrown due to a read/write error.
	 */
	public static int fileCreated(String[] args) {
		try {
			FileCreated x = new FileCreated(args);
			returnProperties(x);
			return 0;
		} catch (IOException e) {
			SFIToolkit.errorln(SFIToolkit.stackTraceToString(e));
			return 1;
		}
	}

	/***
	 * Method to set the executable property of the file passed
	 * @param args The file and OS information used to access the file from
	 *                the JVM
	 * @return A success/failure indicator
	 */
	public static int makeExecutable(String[] args) {
		Boolean onoff;
		Boolean global;
		try {
			FileCreated x = new FileCreated(args);
			if (Macro.getLocalSafe("global").equals("global")) global = true;
			else global = false;
			if (Macro.getLocalSafe("x").equals("on")) onoff = true;
			else onoff = false;
			x.setExecutable(onoff, global);
			x = new FileCreated(args);
			returnProperties(x);
			return 0;
		} catch (IOException e) {
			SFIToolkit.errorln(SFIToolkit.stackTraceToString(e));
			return 1;
		}
	}

	/***
	 * Method to set the executable property of the file passed
	 * @param args The file and OS information used to access the file from
	 *                the JVM
	 * @return A success/failure indicator
	 */
	public static int makeReadable(String[] args) {
		Boolean onoff;
		Boolean global;
		try {
			FileCreated x = new FileCreated(args);
			if (Macro.getLocalSafe("global").equals("global")) global = true;
			else global = false;
			if (Macro.getLocalSafe("r").equals("on")) onoff = true;
			else onoff = false;
			x.setReadable(onoff, global);
			x = new FileCreated(args);
			returnProperties(x);
			return 0;
		} catch (IOException e) {
			SFIToolkit.errorln(SFIToolkit.stackTraceToString(e));
			return 1;
		}
	}

	/***
	 * Method to set the executable property of the file passed
	 * @param args The file and OS information used to access the file from
	 *                the JVM
	 * @return A success/failure indicator
	 */
	public static int makeWritable(String[] args) {
		Boolean global;
		Boolean onoff;
		try {
			FileCreated x = new FileCreated(args);
			if (Macro.getLocalSafe("global").equals("global")) global = true;
			else global = false;
			if (Macro.getLocalSafe("w").equals("on")) onoff = true;
			else onoff = false;
			x.setWritable(onoff, global);
			x = new FileCreated(args);
			returnProperties(x);
			return 0;
		} catch (IOException e) {
			SFIToolkit.errorln(SFIToolkit.stackTraceToString(e));
			return 1;
		}
	}



	/***
	 * Method to set the executable property of the file passed
	 * @param args The file and OS information used to access the file from
	 *                the JVM
	 * @return A success/failure indicator
	 */
	public static int makeReadOnly(String[] args) {
		try {
			FileCreated x = new FileCreated(args);
			x.setReadOnly();
			x = new FileCreated(args);
			returnProperties(x);
			return 0;
		} catch (IOException e) {
			SFIToolkit.errorln(SFIToolkit.stackTraceToString(e));
			return 1;
		}
	}

	/***
	 * Convenience method used to set return values for Stata command
	 * @param stataFile The FileCreated object used to access and set file
	 *                     properties.
	 */
	public static void returnProperties(FileCreated stataFile) {
		Macro.setLocal("createdon", stataFile.getCreationDate());
		Macro.setLocal("modifiedon", stataFile.getModifiedDate());
		Macro.setLocal("accessedon", stataFile.getLastAccessedDate());
		Macro.setLocal("symlink", stataFile.getSymLink());
		Macro.setLocal("regfile", stataFile.getRegFile());
		Macro.setLocal("filesize", stataFile.getFileSize());
		Macro.setLocal("absolutepath", stataFile.getAbsolutePath());
		Macro.setLocal("canonicalpath", stataFile.getCanonicalPath());
		Macro.setLocal("executable", stataFile.getExecutable());
		Macro.setLocal("filename", stataFile.getFileName());
		Macro.setLocal("hidden", stataFile.getHidden());
		Macro.setLocal("parent", stataFile.getParent());
		Macro.setLocal("readable", stataFile.getReadable());
		Macro.setLocal("writable", stataFile.getWritable());
		Macro.setLocal("fileowner", stataFile.getFileOwner());
	} // End of Method declaration

} // End of Class declaration
