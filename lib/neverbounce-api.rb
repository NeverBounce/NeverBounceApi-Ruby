
# Main gem require. Load all libraries.
# Upon a convention, the require named same as gem does all loading job.
Dir[File.join(__dir__, "**/*.rb")].each { |fn| require fn }
