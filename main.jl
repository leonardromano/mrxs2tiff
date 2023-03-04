include("src/mrxs2tiff.jl")
using .Bioformat_To_Tiff_Converter

#= Method 1: Convert all .mrxs files in a folder to tiff files. 
Since mrxs files come along with a folder of data, at the moment recursive image search down the file tree is not supported.

Arguments:
- folder::String             -- path to folder with .mrxs files
        
Optional Arguments:
- tmp::String                -- path to temporary directory for pyramid files. Will be deleted in the end. (default: "tmp")
- dir_out::String            -- path to output directory (default: folder)
- opt_bioformats2raw::String -- runtime options for bioformats2raw conversion (default: "")
- opt_raw2ometiff::String    -- runtime options for raw2ometiff conversion (default: "")

see example below
=#
folder             = "sample_data/folder"         # in sample data/folder there are 2 mrxs files ("1" & "2")
tmp                = "temporary_folder"           # name does not matter. Only requirement is, that you can write to it and that it does not exist
dir_out            = "sample_data/tiffs"          # folder to which results are written
opt_bioformats2raw = "--resolutions=8"             # add options just like with bioformats2raw in the command line 
opt_raw2ometiff    = "--compression=”JPEG” --rgb" # add options just like with raw2ometiff in the command line

# Optional arguments don't need to be specified, possible call signatures are given below
mrxs2tiff(folder, tmp=tmp, dir_out=dir_out, opt_bioformats2raw=opt_bioformats2raw, opt_raw2ometiff=opt_raw2ometiff)
#mrxs2tiff(folder) # minimum call signature (one string argument): only folder provided, other arguments assume default
#mrxs2tiff(folder, opt_bioformats2raw=opt_bioformats2raw, opt_raw2ometiff=opt_raw2ometiff) # only folder and convert options are provided, other arguments assume default

#= Method 2: Convert single .mrxs file to tiff file.

Arguments:
- path::String               -- path to .mrxs file (including .mrxs file ending)
- fname::String              -- name of the .mrxs file (without .mrxs file ending)
- dir_out::String            -- path to output directory 
    
Optional Arguments:
- tmp::String                -- path to temporary directory for pyramid files. Will be deleted in the end. (default: "tmp")
- opt_bioformats2raw::String -- runtime options for bioformats2raw conversion (default: "")
- opt_raw2ometiff::String    -- runtime options for raw2ometiff conversion (default: "")

see example below
=#
path               = "sample_data/sample_file.mrxs"
fname              = "sample_file"
dir_out            = "sample_data/tiffs"          # folder to which results are written
tmp                = "temporary_folder"           # name does not matter. Only requirement is, that you can write to it and that it does not exist
opt_bioformats2raw = "--resolutions=8"             # add options just like with bioformats2raw in the command line 
opt_raw2ometiff    = "--compression=”JPEG” --rgb" # add options just like with raw2ometiff in the command line

# Optional arguments don't need to be specified, possible call signatures are given below
mrxs2tiff(path, fname, dir_out, tmp=tmp, opt_bioformats2raw=opt_bioformats2raw, opt_raw2ometiff=opt_raw2ometiff)
#mrxs2tiff(path, fname, dir_out) # minimum call signature (three string arguments): only path to file, filename and output directory specified, other arguments assume default