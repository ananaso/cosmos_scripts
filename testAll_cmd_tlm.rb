require 'json'
#require_relative 'has/decoders/cosmos_decoder/ingest_config'

cmd_log_fd = open('./cosmos_log_cmd', 'w+')

# iterate each target
System.commands.all.each do |target_name, target|
  # remove non-useful/defined commands
  if target_name == 'UNKNOWN' then
    next
  end
  puts target_name
  
  # run each available command for the target
  target.each do |packet_name, packet|
    cmd_str = "#{target_name} #{packet_name}"

    # iterate through the fields available to build command string
    packet.sorted_items.each do |item|
      # OpenSatKit sets some CCSDS fields to 0 bits; ignore those
      if item.bit_size == 0 then
        next
      end
      
      # only add parameter to command if it has a default value
      if item.default then
        param_str = ""
        # check if this is the first param to be concatenated
        if cmd_str == "#{target_name} #{packet_name}" then
          param_str = " with "
        else
          param_str = ", "
        end
        param_str += "#{item.name} #{item.default}"
        cmd_str += param_str
      end
    end
    
    cmd_log_fd.write(cmd_str)
    cmd(cmd_str)
  end
end

cmd_log_fd.close()