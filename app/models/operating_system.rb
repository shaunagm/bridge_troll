class OperatingSystem < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {
      id: 3,
      name: 'WINDOWS',
      type: :windows,
      title: 'Windows'
    },
    {
      id: 2,
      name: 'MAC',
      type: :osx,
      title: 'Mac OS X'
    },
    {
      id: 1,
      name: 'LINUX',
      type: :linux,
      title: 'Linux (Ubuntu, Debian, etc)'
    }
  ]

  enum_accessor :name
end
