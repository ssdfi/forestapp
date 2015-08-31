#encoding: utf-8

##
# Clase que se utiliza para almacenar los datos del usuario activo
class User
  include ActiveModel::Model

  ADMIN_GROUP = "forestapp_admin"
  EDITOR_GROUP = "forestapp_editor"

  attr_accessor :name, :groups

  ##
  # Genera un usuario a partir de los datos de un objeto LDAP
  def self.from_ldap(ldap_object)
    return User.new(
      name: ldap_object[:name][0].force_encoding('UTF-8'),
      groups: ldap_object[:memberof].map { |group| group.match(/\bCN=(.*?),/)[1].force_encoding('UTF-8') }
    )
  end

  ##
  # Genera un usuario admin (Sólo para usar en desarrollo)
  def self.admin_user
    return User.new(
      name: 'Admin User',
      groups: [ADMIN_GROUP, EDITOR_GROUP]
    )
  end

  ##
  # Genera un usuario editor (Sólo para usar en desarrollo)
  def self.editor_user
    return User.new(
      name: 'Editor User',
      groups: [EDITOR_GROUP]
    )
  end

  ##
  # Genera un usuario básico (Sólo para usar en desarrollo)
  def self.basic_user
    return User.new(
      name: 'Basic User',
      groups: []
    )
  end

  def admin?
    groups.include? ADMIN_GROUP
  end

  def editor?
    groups.include? EDITOR_GROUP
  end

end