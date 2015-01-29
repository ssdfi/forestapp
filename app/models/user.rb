##
# Clase que se utiliza para almacenar los datos del usuario activo
class User
  include ActiveModel::Model

  attr_accessor :name, :groups

  ##
  # Genera un usuario a partir de los datos de un objeto LDAP
  def self.from_ldap(ldap_object)
    return User.new(
      name: ldap_object[:name][0],
      groups: ldap_object[:memberof].map { |group| group.match(/\bCN=(.*?),/)[1] }
    )
  end
end