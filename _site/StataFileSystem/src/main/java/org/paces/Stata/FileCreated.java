package org.paces.Stata;

import org.paces.Stata.Utilities.StataXTTS;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.BasicFileAttributes;
import java.nio.file.attribute.DosFileAttributes;
import java.nio.file.attribute.FileTime;
import java.nio.file.attribute.PosixFileAttributes;

/**
 * @author Billy Buchanan
 * @version 0.0.0
 */
public class FileCreated {

	/***
	 * A Path object used to define the location of the file
	 */
	private Path filepath;

	/***
	 * A file object based on the user provided filepath
	 */
	private File thefile;

	/***
	 * An object wrapping the file attributes
	 */
	private BasicFileAttributes fileAttributes;

	/***
	 * An object used to store the date the file was created
	 */
	private FileTime createdDate;

	/***
	 * An object used to store the date the file was modified
	 */
	private FileTime modifiedDate;

	/***
	 * An object used to store the date the file was last accessed
	 */
	private FileTime lastAccessDate;

	/***
	 * Indicator for whether or not the file referenced is a symbolic link
	 */
	private Boolean symlink;

	/***
	 * Indicator for whether or not the file referenced is a regular file
	 */
	private Boolean regfile;

	/***
	 * Indicates if file has executable property set
	 */
	private Boolean executable;

	/***
	 * Indicates if file is accessible for reading
	 */
	private Boolean readable;

	/***
	 * Indicates if file is accessible for reading
	 */
	private Boolean writable;

	/***
	 * Returns the absolute path to the file
	 */
	private String absolutepath;

	/***
	 * Like absolute path, but format is platform dependent
	 */
	private String canonicalpath;

	/***
	 * Returns the filename of the file
	 */
	private String fileName;

	/***
	 * Returns the parent of the file
	 */
	private String parent;

	/***
	 * Indicates if file is hidden
	 */
	private Boolean hidden;

	/***
	 * Value of the size of the referenced file
	 */
	private Long filesize;

	/***
	 * Class constructor method
	 * @param args A string array with at least two elements:
	 *             First element = File path
	 *             Second Element = Windoze indicator
	 * @throws IOException Thrown if there is an error reading/writing to the
	 * location
	 */
	FileCreated(String[] args) throws IOException {

		setPath(args[0]);

		setFile();

		if (args[1].equals("POSIX")) {
			setPosixAttributes();
		} else {
			setDosAttributes();
		}

		setCreationDate();
		setModifiedDate();
		setLastAccessDate();
		setSymlink();
		setRegfile();
		setFilesize();

		this.executable = this.thefile.canExecute();

		this.readable = this.thefile.canRead();

		this.writable = this.thefile.canWrite();

		this.absolutepath = this.thefile.getAbsolutePath();
		this.canonicalpath = this.thefile.getCanonicalPath();
		this.fileName = this.thefile.getName();
		this.parent = this.thefile.getParent();
		this.hidden = this.thefile.isHidden();

	}

	/***
	 * Method used to set the Path object from the first element of the
	 * arguments passed to the class constructor
	 * @param args The file path from which to create the Path object
	 */
	public void setPath(String args) {
		this.filepath = Paths.get(args).normalize();
	}

	/***
	 * Method used to set the File object from the previously set path element
	 */
	public void setFile() {
		this.thefile = this.filepath.toFile();
	}

	/***
	 * Sets the BasicFileAttributes element to be Windoze based if OS is Windoze
	 * @throws IOException Thrown if there is an error reading the file
	 */
	public void setDosAttributes() throws IOException {
		this.fileAttributes = Files.readAttributes(this.thefile.toPath(),
				DosFileAttributes.class);
	}

	/***
	 * Sets the BasicFileAttributes element to be POSIX based if OS is
	 * not Windoze
	 * @throws IOException Thrown if there is an error reading the file
	 */
	public void setPosixAttributes() throws IOException {
		this.fileAttributes = Files.readAttributes(this.thefile.toPath(),
				PosixFileAttributes.class);
	}

	/***
	 * Sets the file creation date attribute
	 */
	public void setCreationDate() {
		this.createdDate = this.fileAttributes.creationTime();
	}

	/***
	 * Sets the file modified date attribute
	 */
	public void setModifiedDate() {
		this.modifiedDate = this.fileAttributes.lastModifiedTime();
	}

	/***
	 * Sets the last accessed date attribute
	 */
	public void setLastAccessDate() {
		this.lastAccessDate = this.fileAttributes.lastAccessTime();
	}

	/***
	 * Method to indicate if the file is/isn't a symbolic link
	 */
	public void setSymlink() {
		this.symlink = this.fileAttributes.isSymbolicLink();
	}

	/***
	 * Method to indicate if file is a regular file
	 */
	public void setRegfile() {
		this.regfile = this.fileAttributes.isRegularFile();
	}

	/***
	 * Method to collect the size of the file
	 */
	public void setFilesize() {
		this.filesize = this.fileAttributes.size();
	}

	/***
	 * Returns a Stata formatted double with the file creation date
	 * @return A double representing the time since 01jan1970 used to
	 * represent Stata dates/times
	 */
	public String getCreationDate() {
		StataXTTS x = new StataXTTS();
		String retval = x.stringArrayToStataDate(x.toStata(this.createdDate));
		x = null;
		return retval;
	}

	/***
	 * Returns a Stata formatted double with the file modification date
	 * @return A double representing the time since 01jan1970 used to
	 * represent Stata dates/times
	 */
	public String getModifiedDate() {
		StataXTTS x = new StataXTTS();
		String retval = x.stringArrayToStataDate(x.toStata(this.modifiedDate));
		x = null;
		return retval;
	}

	/***
	 * Returns a Stata formatted double with the date when the file was last
	 * accessed
	 * @return A double representing the time since 01jan1970 used to
	 * represent Stata dates/times
	 */
	public String getLastAccessedDate() {
		StataXTTS x = new StataXTTS();
		String retval = x.stringArrayToStataDate(x.toStata(this.lastAccessDate));
		x = null;
		return retval;
	}

	/***
	 * Method to return a string value indicating whether or not the file is
	 * a symbolic link
	 * @return A value of "true" if the file is a symbolic link and "false"
	 * otherwise
	 */
	public String getSymLink() {
		return String.valueOf(this.symlink);
	}

	/***
	 * Method to return a string value indicating whether or not the file is
	 * a "regular" file
	 * @return A value of "true" if the file is a "regular" file and "false"
	 * otherwise
	 */
	public String getRegFile() {
		return String.valueOf(this.regfile);
	}

	/***
	 * Method to return a string value indicating the size of the file
	 * @return A string literal containing a Long class value of the file size
	 */
	public String getFileSize() {
		return String.valueOf(this.filesize);
	}

	/***
	 * Method that returns property to set whether or not the file is executable
	 * @return A string literal of :
	 * 			"true" if the file is executable and
	 * 			"false" if the file is not executable
	 */
	public String getExecutable() {
		return String.valueOf(this.executable);
	}

	/***
	 * Method that returns property to set whether or not the file is readable
	 * @return A string literal of :
	 * 			"true" if the file is readable and
	 * 			"false" if the file is not readable
	 */
	public String getReadable() {
		return String.valueOf(this.readable);
	}

	/***
	 * Method that returns property to set whether or not the file is writable
	 * @return A string literal of :
	 * 			"true" if the file is writable and
	 * 			"false" if the file is not writable
	 */
	public String getWritable() {
		return String.valueOf(this.writable);
	}

	/***
	 * Method that returns the absolute file path.
	 * @return A string containing the absolute path to the file
	 */
	public String getAbsolutePath() {
		return this.absolutepath;
	}

	/***
	 * Method that returns the canonical file path.  This is an absolute path
	 * that is normalized to the operating system conventions (e.g., using
	 * C:\ for Windoze or /home/username for *nix-based systems).
	 * Additionally, the canonical link would return the source file when the
	 * the file passed to the class is a symbolic link rather than the
	 * address of the symbolic link.
	 * @return A string containing the canonical file path
	 */
	public String getCanonicalPath() {
		return this.canonicalpath;
	}

	/***
	 * Method that returns the name of the file
	 * @return A string containing the file name
	 */
	public String getFileName() {
		return this.fileName;
	}

	/***
	 * Method that returns the parent path of the file
	 * @return A string literal containing the parent path to the file
	 */
	public String getParent() {
		return this.parent;
	}

	/***
	 * Method that returns property to set whether or not the file is hidden
	 * @return A string literal of :
	 * 			"true" if the file is hidden and
	 * 			"false" if the file is not hidden
	 */
	public String getHidden() {
		return String.valueOf(this.hidden);
	}

	/***
	 * Method to set executable property for the owner of the file only
	 * @param onoff Boolean to set the property on or off
	 * @param ownerOnly Boolean to set property for the file owner only
	 *                     (true) or globally (false)
	 */
	public void setExecutable(Boolean onoff, Boolean ownerOnly) {
		this.thefile.setExecutable(onoff, ownerOnly);
	}

	/***
	 * Method to set readable property globally for file
	 * @param onoff Boolean to set the property on or off
	 * @param ownerOnly Boolean to set property for the file owner only
	 *                     (true) or globally (false)
	 */
	public void setReadable(Boolean onoff, Boolean ownerOnly) {
		this.thefile.setReadable(onoff, ownerOnly);
	}

	/***
	 * Method to set readonly property for the owner of the file only
	 */
	public void setReadOnly() {
		this.thefile.setReadOnly();
	}

	/***
	 * Method to set writable property globally for file
	 * @param onoff Boolean to set the property on or off
	 * @param ownerOnly Boolean to set property for the file owner only
	 *                     (true) or globally (false)
	 */
	public void setWritable(Boolean onoff, Boolean ownerOnly) {
		this.thefile.setWritable(onoff, ownerOnly);
	}

} // End Class declaration
