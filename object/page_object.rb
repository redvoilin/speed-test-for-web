require 'yaml'

$object = YAML.load(File.open(File.expand_path('../page_object.yml',__FILE__))) unless $object



