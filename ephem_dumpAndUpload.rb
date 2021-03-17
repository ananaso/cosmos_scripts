# On all tables...
for i in 0..1
  # dump current ephemeris
  cmd("EPHEM DUMP_TBL with CCSDS_STREAMID 6620, CCSDS_SEQUENCE 49152, CCSDS_LENGTH 67, CCSDS_FUNCCODE 3, CCSDS_CHECKSUM 0, FILENAME /cf/ephem_extbl#{i}_down.json, ID #{i}")
  # ask for confirmation if new ephemeris should be uploaded or not
  if message_box("Upload ephemeris data to Table #{i}?", "Yes", "No", false) == "Yes"
    # load new ephemeris, updating records
    cmd("EPHEM LOAD_TBL with CCSDS_STREAMID 6620, CCSDS_SEQUENCE 49152, CCSDS_LENGTH 67, CCSDS_FUNCCODE 2, CCSDS_CHECKSUM 0, FILENAME /cf/ephem_extb#{i}.json, ID #{i}, TYPE 1")
  end
end

sleep(3)
cmd("EPHEM NOOP with CCSDS_STREAMID 6620, CCSDS_SEQUENCE 49152, CCSDS_LENGTH 1, CCSDS_FUNCCODE 0, CCSDS_CHECKSUM 0")