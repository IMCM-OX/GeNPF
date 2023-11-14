#' Unzip content of a file or folder containing zipped files
#'
#' @param file A link to Google bucket folder or file to be unzipped
#' @param dest_folder destination folder for unzipped contents
#' @return A folder with contents
#' @export
#'
#' @examples
unzip_contents <- function(file = NULL, dest_folder = "unzipped_files"){

  #  create destination folder in the current working directory
  if (!file.exists(xfun::relative_path(here::here({{dest_folder}})))) {
    dir.create(xfun::relative_path(here::here({{dest_folder}})), recursive = TRUE)}

  # step 2: copy the file/folder into the destination folder
  system(command = stringr::str_glue("gsutil -m cp gs://{file}/* {dest_folder}/"))

  # step 3: unzip all the files in the folder
}







