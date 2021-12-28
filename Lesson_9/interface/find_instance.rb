module FindInstance
  def find_instance(array_of_instances, instance_name)
    array_of_instances.find { |object| object.name == instance_name }
  end
end
