__precompile__(true)
module Bioformat_To_Tiff_Converter
    # module exports
    export mrxs2tiff

    """
        Convert all .mrxs files in a folder to tiff files. 
        Since mrxs files come along with a folder of data, at the moment recursive image search down the file tree is not supported.

        Arguments:
        - folder::String             -- path to folder with .mrxs files
        
        Optional Arguments:
        - dir_out::String            -- path to output directory (default: folder)
        - opt_bioformats2raw::String -- runtime options for bioformats2raw conversion (default: "")
        - opt_raw2ometiff::String    -- runtime options for raw2ometiff conversion (default: "")
    """
    function mrxs2tiff(folder::String; dir_out::String=folder, opt_bioformats2raw::String="", opt_raw2ometiff::String="")
        # check if output directory exists
        isdir(dir_out) ? nothing : mkpath(dir_out)

        # go through directory converting all .mrxs files
        for file in readdir(folder)
            path = folder * "/" * file
            if ismrxs(path)
                fname = replace(file, ".mrxs" => "")
                mrxs2tiff(path, fname, dir_out, 
                          opt_bioformats2raw=opt_bioformats2raw, 
                          opt_raw2ometiff=opt_raw2ometiff)
            end
        end
    end

    """
        Convert single .mrxs file to tiff file. 

        Arguments:
        - path::String               -- path to .mrxs file (including .mrxs file ending)
        - fname::String              -- name of the .mrxs file (without .mrxs file ending)
        - dir_out::String            -- path to output directory 
    
        Optional Arguments:
        - opt_bioformats2raw::String -- runtime options for bioformats2raw conversion (default: "")
        - opt_raw2ometiff::String    -- runtime options for raw2ometiff conversion (default: "")
    """
    function mrxs2tiff(path::String, fname::String, dir_out::String; opt_bioformats2raw::String="", opt_raw2ometiff::String="")
        # convert mrxs to pyramid file
        run_windows(`bioformats2raw $(opt_bioformats2raw) $(path) $(dir_out)/zarr-pyramid`)
        # convert pyramid to tiff
        run_windows(`raw2ometiff $(opt_raw2ometiff) $(dir_out)/zarr-pyramid $(dir_out)/$(fname).ome.tiff`)
        # remove temporary files
        run_windows(`rm -r $(dir_out)/zarr-pyramid`)
    end

    "Check whether or not a path corresponds to an .mrxs file"
    function ismrxs(path::String)::Bool
        isfile(path) ? endswith(path, ".mrxs") : false
    end

    "Update to run function to also work on windows."
    function run_windows(command::Cmd; shell::Union{String, Cmd} = `cmd`)
        try 
            run(command)
        catch e
             run(`$shell /c $command`)
        end
    end
end