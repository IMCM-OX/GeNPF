#' Wrapper function to unzip ADNI dataset
#'
#' @param dest_folder Name of destination folder for decompressed/unziped files.
#'
#' @return Side effect, files are decompressed and placed in persistent disk.
#' @export
#'
#' @examples
ADNI_unzip <- function(dest_folder = "data_unziped"){

  # 'data' should not be used as folder name
  if(dest_folder %in% c("Data", "data")) stop("Choose a different destination folder name!")

  # create folder to hold decompressed data
  if (!file.exists(xfun::relative_path(here::here({{dest_folder}})))) {
    dir.create(xfun::relative_path(here::here({{dest_folder}})), recursive = TRUE)}

  # list capture folders within ADNI
  v_adnizip <- list.files(xfun::relative_path(here::here("data", "ADNI")))

  # # decompress round 1
  # foreach::foreach(adni_folder = v_adnizip)%do%{
  #
  #   # decompress to 'data' folder
  #   system(command = str_glue("tar -xvf data/ADNI/{adni_folder} -C {dest_folder}/"))
  # }

  for (adni_folder in seq_along(v_adnizip)){
      # decompress to 'data' folder
      system(command = stringr::str_glue("tar -xvf data/ADNI/{v_adnizip[adni_folder]} -C {dest_folder}/"))
  }

  # decompress round 2

  # Some folders (specifically Biospecimen) have nested .zst files
  # we are going to decompress it

  v_biospec <- list.files(xfun::relative_path(here::here({dest_folder})),
                          recursive = T, pattern = ".zst")

  # foreach::foreach(biospec_file = v_biospec)%do%{
  #
  #   # extract folder tag for path specification
  #   path_folder <- str_split(string = biospec_file, pattern = "/")[[1]][1]
  #
  #   # decompress to 'data' folder
  #   system(command = str_glue("tar -xvf {dest_folder}/{biospec_file} -C {dest_folder}/{path_folder}"))
  # }

  for (biospec_file in seq_along(v_biospec)){
    # extract folder tag for path specification
    path_folder <- stringr::str_split(string = v_biospec[biospec_file], pattern = "/")[[1]][1]

    # decompress to 'data' folder
    system(command = stringr::str_glue("tar -xvf {dest_folder}/{v_biospec[biospec_file]} -C {dest_folder}/{path_folder}"))
  }


}





