module NGramSections
  FIRST_CHAR_PATTERN = '「%s」で始まる歌'
  N_GRAM_SECTIONS = [
      {section_id: :one,
       header_title: '一枚札',
       items: [
           {id: :just_one, title: '一字決まりの歌'},
       ]
      },
      {section_id: :two,
       header_title: '二枚札',
       items: [
           {id: :u,   title: FIRST_CHAR_PATTERN % 'う'},
           {id: :tsu, title: FIRST_CHAR_PATTERN % 'つ'},
           {id: :shi, title: FIRST_CHAR_PATTERN % 'し'},
           {id: :mo,  title: FIRST_CHAR_PATTERN % 'も'},
           {id: :yu,  title: FIRST_CHAR_PATTERN % 'ゆ'},
       ]
      },
      {section_id: :three,
       header_title: '三枚札',
       items: [
           {id: :i,   title: FIRST_CHAR_PATTERN % 'い'},
           {id: :chi, title: FIRST_CHAR_PATTERN % 'ち'},
           {id: :hi,  title: FIRST_CHAR_PATTERN % 'ひ'},
           {id: :ki,  title: FIRST_CHAR_PATTERN % 'き'},
       ]
      },
      {section_id: :four,
       header_title: '四枚札',
       items: [
           {id: :ha,  title: FIRST_CHAR_PATTERN % 'は'},
           {id: :ya,  title: FIRST_CHAR_PATTERN % 'や'},
           {id: :yo,  title: FIRST_CHAR_PATTERN % 'よ'},
           {id: :ka,  title: FIRST_CHAR_PATTERN % 'か'},
       ]
      },
      {section_id: :five,
       header_title: '五枚札',
       items: [
           {id: :mi,  title: FIRST_CHAR_PATTERN % 'み'},
       ]
      },
      {section_id: :six,
       header_title: '六枚札',
       items: [
           {id: :ta,  title: FIRST_CHAR_PATTERN % 'た'},
           {id: :ko,  title: FIRST_CHAR_PATTERN % 'こ'},
       ]
      },
      {section_id: :seven,
       header_title: '七枚札',
       items: [
           {id: :o,   title: FIRST_CHAR_PATTERN % 'お'},
           {id: :wa,  title: FIRST_CHAR_PATTERN % 'わ'},
       ]
      },
      {section_id: :eight,
       header_title: '八枚札',
       items: [
           {id: :na,  title: FIRST_CHAR_PATTERN % 'な'},
       ]
      },
      {section_id: :sixteen,
       header_title: '十六枚札',
       items: [
           {id: :a,   title: FIRST_CHAR_PATTERN % 'あ'},
       ]
      },
  ]

end