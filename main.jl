include("src/mrxs2tiff.jl")
using .Bioformat_To_Tiff_Converter

#= Method 1: Convert all .mrxs files in a folder to tiff files. 
Since mrxs files come along with a folder of data, at the moment recursive image search down the file tree is not supported.

Arguments:
- folder::String             -- path to folder with .mrxs files
        
Optional Arguments:
- dir_out::String            -- path to output directory (default: folder)
- bioformats2raw::Vector{String}     -- command to call bioformats2raw (default: "bioformats2raw")
- opt_bioformats2raw::Vector{String} -- runtime options for bioformats2raw conversion (default: "")
- raw2ometiff::Vector{String}        -- command to call raw2ometiff (default: "raw2ometiff")
- opt_raw2ometiff::Vector{String}    -- runtime options for raw2ometiff conversion (default: "")

see example below
=#
folder             = "mrxs2tiff_sample_files/folder"     # in sample data/folder there are 2 mrxs files ("1" & "2")
dir_out            = "tiffs"                             # folder to which results are written
bioformats2raw     = ["conda", "run", "bioformats2raw"]  # Change this to the way you call bioformats2raw on your system from the command line
opt_bioformats2raw = ["--resolutions=8"]                 # add options just like with bioformats2raw in the command line
raw2ometiff        = ["conda", "run", "bioformats2raw"]  # Change this to the way you call raw2ometiff on your system from the command line
opt_raw2ometiff    = ["--compression=\"JPEG\"", "--rgb"] # add options just like with raw2ometiff in the command line

# Optional arguments don't need to be specified, possible call signatures are given below
mrxs2tiff(folder, dir_out=dir_out, bioformats2raw=bioformats2raw, opt_bioformats2raw=opt_bioformats2raw, raw2ometiff=raw2ometiff, opt_raw2ometiff=opt_raw2ometiff)
#mrxs2tiff(folder) # minimum call signature (one string argument): only folder provided, other arguments assume default
#mrxs2tiff(folder, opt_bioformats2raw=opt_bioformats2raw, opt_raw2ometiff=opt_raw2ometiff) # only folder and convert options are provided, other arguments assume default

#= Method 2: Convert single .mrxs file to tiff file.

Arguments:
- path::String               -- path to .mrxs file (including .mrxs file ending)
- fname::String              -- name of the .mrxs file (without .mrxs file ending)
- dir_out::String            -- path to output directory 
    
Optional Arguments:
- tmp::String                -- path to temporary directory for pyramid files. Will be deleted in the end. (default: "tmp")
- bioformats2raw::Vector{String}     -- command to call bioformats2raw (default: "bioformats2raw")
- opt_bioformats2raw::Vector{String} -- runtime options for bioformats2raw conversion (default: "")
- raw2ometiff::Vector{String}        -- command to call raw2ometiff (default: "raw2ometiff")
- opt_raw2ometiff::Vector{String}    -- runtime options for raw2ometiff conversion (default: "")

see example below
=#
path               = "mrxs2tiff_sample_files/sample_file.mrxs"
fname              = "sample_file"
dir_out            = "tiffs"                              # folder to which results are written
bioformats2raw     = ["conda", "run", "bioformats2raw"]   # Change this to the way you call bioformats2raw on your system from the command line
opt_bioformats2raw = ["--resolutions=8"]                  # add options just like with bioformats2raw in the command line
raw2ometiff        = ["conda", "run", "raw2ometiff"]      # Change this to the way you call raw2ometiff on your system from the command line
opt_raw2ometiff    = ["--compression=\"JPEG\"", "--rgb"]  # add options just like with raw2ometiff in the command line

# Optional arguments don't need to be specified, possible call signatures are given below
mrxs2tiff(path, fname, dir_out, bioformats2raw=bioformats2raw, opt_bioformats2raw=opt_bioformats2raw, raw2ometiff=raw2ometiff, opt_raw2ometiff=opt_raw2ometiff)
#mrxs2tiff(path, fname, dir_out) # minimum call signature (three string arguments): only path to file, filename and output directory specified, other arguments assume default