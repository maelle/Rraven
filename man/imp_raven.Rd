% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/imp_raven.R
\name{imp_raven}
\alias{imp_raven}
\title{Import 'Raven' selections}
\usage{
imp_raven(path = NULL, warbler.format = FALSE,  all.data = FALSE, files = NULL,
only.spectro.view = TRUE, recursive = FALSE, name.from.file = FALSE,
ext.case = NULL, freq.cols = TRUE, waveform = FALSE, parallel = 1, pb = TRUE,
unread = FALSE, rm.dup = FALSE,  sound.file.col = NULL)
}
\arguments{
\item{path}{A character string indicating the path of the directory in which to look for the 'Raven' selection (text) files.
If not provided (default) the function searches into the current working directory.}

\item{warbler.format}{Logical. If \code{TRUE} columns are renamed using the standard names for a selection table as in the package 'warbleR', frequency limit columns (high and low frequency) in 'Hz' are converted to 'kHz' (as in warbleR selection tables) and only the spectrogram view measurements are kept. Default is \code{FALSE}.}

\item{all.data}{Logical. If \code{TRUE} all columns in the selection files are returned,
keeping the name columns as in the 'Raven' files. Default is \code{FALSE}. Columns absent in some selection files will
be filled with NA's. This argument WILL BE DEPRECATED as it is being replaced by 'warbler.format'.}

\item{files}{Character vector indicating the name of selection files (in .txt format) to be imported. Optional. Default is \code{NULL}.}

\item{only.spectro.view}{Logical. If \code{TRUE} (default) only the measurements in the Raven spectrogram view ('View' column) are returned. Ignored if \code{warbler.format == TRUE} (only spectrogram view measurements are kept).}

\item{recursive}{Logical. If \code{TRUE} the listing recurses into sub-directories.}

\item{name.from.file}{Logical. If \code{TRUE} the sound file names are extracted from the selection text file name.
It assumes that selections files contained the suffix "Table.1.selections.txt", "selections.txt" or ".txt" (in that order).
Note that by default it will assume that the extension file name is ".wav". This can be control using the
argument 'ext.case'. Default is \code{FALSE}). Ignored if sound.file.col' is provided and/or all.data is \code{TRUE}). Note that
the time information for selection tables with multiple sound files won't be corrected if \code{name.from.file = TRUE}.}

\item{ext.case}{Character string of length 1 to specify whether sound file extensions are in upper or lower case. This should match the extension of the
of the .wav files from which the selection were made. It must be either 'upper' or 'lower'. Only needed when 'name.from.file' is \code{TRUE}.}

\item{freq.cols}{Logical. If \code{TRUE} 'Low Freq' and 'High Freq' columns are also imported. Ignored if all.data is \code{TRUE}.}

\item{waveform}{Logical to control if waveform view data should be included (this data is typically duplicated in spectrogram view data).  Default is \code{FALSE} (not to include it). This argument WILL BE DEPRECATED as it is being replaced by 'only.spectro.view'.}

\item{parallel}{Numeric. Controls whether parallel computing is applied.
It specifies the number of cores to be used. Default is 1 (i.e. no parallel computing).}

\item{pb}{Logical argument to control progress bar. Default is \code{TRUE}.}

\item{unread}{Logical. If \code{TRUE} a list (instead of a data frame). The first element of the list contains the selections
whole data. The second and third elements are character vectors with the names of sound files that could not be read or that contain multiple sound files but no 'File Offset' column and could not be imported. Default is \code{FALSE}.}

\item{rm.dup}{Logical. If \code{TRUE} duplicated rows and columns are removed. Useful when
selection files have been duplicated. Default is \code{FALSE}.}

\item{sound.file.col}{A character string with the name of the column containing the sound files in
the selection text files. Default is \code{NULL}. Ignored if 'name.from.file' is \code{TRUE} and/or all.data is \code{TRUE}. This argument WILL BE DEPRECATED as the function now searches for columns containing the sound file names.}
}
\value{
A single data frame with information of the selection files. If \code{unread = TRUE} the function returns a list  with
 the selection data frame and 1 vector with the names of files that could not be read (see 'unread' argument).
 If 'warbler.format' argument is set to \code{TRUE} the data frame contains the following columns: sound.files, selec, channel,start, end, top.freq, bottom.freq and selec.file. If all.data is set to \code{TRUE} then all columns in the 'Raven' selection files are returned.
 If individual selection files contain information about multiple sound files the function will import the file and correct the time
 parameters (start and end) only if 1) the 'File Offset (s)' is found in the selection table.
}
\description{
\code{imp_raven} imports several 'Raven' selection files simultaneously. Files must be in '.txt' format.
}
\details{
The function import 'Raven' selection data from many files simultaneously. All selection files in the working directory or 'path' supplied will be imported (unless 'files' argument is also supplied). It has been created using Raven Pro 1.5 and tested on Raven 1.6. Selection tables created with other versions might not be read properly. Files must be in '.txt' format. Selection
files including data from multiple recordings can also be imported although they must contained a 'File Offset (s)' column. Selections that span across multiple sound files are not recommended as they will be assigned to the first sound file, which would produce errors for downstream analyses as those from the 'warbleR' package. Empty '.txt' files are ignored.
}
\examples{

# load data
data(selection_files)

# save 'Raven' selection tables in the temporary directory
out <- lapply(1:2, function(x)
writeLines(selection_files[[x]], con = file.path(tempdir(), names(selection_files)[x])))

\donttest{
# providing the name of the column with the sound file names
rvn.dat <- imp_raven(sound.file.col = "Begin.File", all.data = FALSE, path = tempdir())

# View(rvn.dat)
}

}
\seealso{
\code{\link{imp_syrinx}}
}
\author{
Marcelo Araya-Salas (\email{marcelo.araya@ucr.ac.cr})
}
