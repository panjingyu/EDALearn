# Generate File

write_lef_abstract pnr_out/${top_module}_pnr.lef
write_lef_library pnr_out/${top_module}_lib.lef
saveNetlist pnr_out/${top_module}_pnr.v
streamOut pnr_out/${top_module}_pnr.gds.gz

exec touch _Finished_
