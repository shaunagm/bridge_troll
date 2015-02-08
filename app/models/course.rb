class Course < ActiveHash::Base
  include ActiveHash::Enum
  self.data = [
    {
      id: 1,
      name: 'OSCTCfull',
      title: 'Open Source Comes to Campus',
      description: 'Our full-day introductory workshop. Typically includes tutorials on topics like open source community norms, issue trackers, IRC and GIt; a career panel; and a contributions workshop where attendees make their first contributions to FOSS projects.',
      levels: [
        {
          level: 1,
          color: 'blue',
          title: "Totally New to Open Source",
          level_description: [
            'You\'ve heard of open source or free software, but don\'t know much about them.',
            'You\'ve never used IRC, issue trackers or Github.',
	    'You haven\'t used a command line, or you have, but you\'re not comfortable with it.',
          ]
        }, {
          level: 2,
          color: 'green',
          title: "Somewhat New to Open Source",
          level_description: [
	    'You\'re comfortable using the command line/terminal.',
            'You know what open source is, and have used open source projects and tools like Firefox, Wordpress, or Linux.',
            'You know what version control, IRC, and/or issue trackers are but aren\'t really comfortable with them.',
          ]
        }, {
          level: 3,
          color: 'gold',
          title: "Some Open Source Experience",
          level_description: [
	    'You\'re familiar with open source and have contributed or tried to contribute before.',
	    'You know your way around issue trackers and platforms like Github.',
          ]
        }
      ]
    },
    {
      id: 2,
      name: 'OSCTCsprint',
      title: 'Introduction to Open Source Contributing for Sprints, Hackathons, and other Events',
      description: 'This short introductory workshop goes over the basics of open source contributing, including commonly used tools, community norms and jargon, how to pick tasks to work on, and how to work through common obstacles.',
      levels: [
        {
          level: 1,
          color: 'blue',
          title: "Totally New to Open Source",
          level_description: [
            'You\'ve heard of open source or free software, but don\'t know much about them.',
            'You\'ve never used IRC, issue trackers or Github.',
	    'You haven\'t used a command line, or you have, but you\'re not comfortable with it.',
          ]
        }, {
          level: 2,
          color: 'green',
          title: "Somewhat New to Open Source",
          level_description: [
	    'You\'re comfortable using the command line/terminal.',
            'You know what open source is, and have used open source projects and tools like Firefox, Wordpress, or Linux.',
            'You know what version control, IRC, and/or issue trackers are but aren\'t really comfortable with them.',
          ]
        }, {
          level: 3,
          color: 'gold',
          title: "Some Open Source Experience",
          level_description: [
	    'You\'re familiar with open source and have contributed or tried to contribute before.',
	    'You know your way around issue trackers and platforms like Github.',
          ]
        }
      ]
    },	
  ]
  enum_accessor :name
end
