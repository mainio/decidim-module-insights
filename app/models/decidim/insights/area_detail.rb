# frozen_string_literal: true

module Decidim
  module Insights
    AreaDetailStruct = Struct.new("AreaDetail", :area_key, :type, :group, :title, :data, :source)

    class AreaDetail < AreaDetailStruct
      include StructModel

      class << self
        def data
          @data ||= [].tap do |final|
            # Feed all areas with same dummy data
            %w(southeastern northern northeastern easternosternsundom western central southern).each do |key|
              area_data[:southern].each do |ad|
                final << {
                  area_key: key,
                  **ad
                }
              end
            end
          end
        end

        def area_data
          @area_data ||= {
            southern: [
              # Demographic data
              {
                type: "column_comparison",
                group: "demographic",
                title: {
                  fi: "Kuinka moni asuu täällä?"
                },
                source: {
                  fi: "Lorem ipsum dolor sit amet"
                },
                data: {
                  labels: [nil, { fi: "Koko kaupunki" }],
                  groups: [
                    {
                      group: "0-6",
                      values: [7_392, 44_722]
                    },
                    {
                      group: "7-15",
                      values: [8_259, 54_887]
                    },
                    {
                      group: "16-29",
                      values: [26_572, 126_508]
                    },
                    {
                      group: "30-44",
                      values: [32_121, 163_810]
                    },
                    {
                      group: "45-64",
                      values: [26_425, 152_687]
                    },
                    {
                      group: "65-74",
                      values: [11_266, 63_660]
                    },
                    {
                      group: "75+",
                      values: [9_259, 50_646]
                    }
                  ]
                }
              },
              {
                type: "donut",
                group: "demographic",
                title: {
                  fi: "Minkälaisessa elämänvaiheessa asukkaat ovat?"
                },
                source: {
                  fi: "Lorem ipsum dolor sit amet"
                },
                data: {
                  icon: "traveler",
                  slices: [
                    {
                      label: { fi: "Työikäisiä" },
                      value: 70_498
                    },
                    {
                      label: { fi: "Eläkeläiset ja muut" },
                      value: 26_550
                    },
                    {
                      label: { fi: "0-14 -vuotiaat" },
                      value: 14_886
                    },
                    {
                      label: { fi: "Opiskelijat, varus- ja siviilipalvelu" },
                      value: 9_392
                    }
                  ]
                }
              },
              {
                type: "donut",
                group: "demographic",
                title: {
                  fi: "Miten täällä asutaan?"
                },
                source: {
                  fi: "Lorem ipsum dolor sit amet"
                },
                data: {
                  icon: "home-smoke",
                  slices: [
                    {
                      label: { fi: "1 henkilö per asuinkunta" },
                      value: 34_587
                    },
                    {
                      label: { fi: "2 hlö" },
                      value: 21_722
                    },
                    {
                      label: { fi: "3 hlö" },
                      value: 6_113
                    },
                    {
                      label: { fi: "4+ hlö" },
                      value: 5_582
                    }
                  ]
                }
              },
              {
                type: "table",
                group: "demographic",
                title: {
                  fi: "Mitä kieliä puhutaan?"
                },
                source: {
                  fi: "Lorem ipsum dolor sit amet"
                },
                data: [
                  {
                    label: { fi: "Suomi" },
                    value: 95_377
                  },
                  {
                    label: { fi: "Ruotsi" },
                    value: 13_919
                  },
                  {
                    label: { fi: "Muu/tuntematon" },
                    value: 2_310
                  },
                  {
                    label: { fi: "Venäjä" },
                    value: 2_066
                  },
                  {
                    label: { fi: "Englanti" },
                    value: 1_969
                  },
                  {
                    label: { fi: "Espanja" },
                    value: 745
                  },
                  {
                    label: { fi: "Viro" },
                    value: 735
                  },
                  {
                    label: { fi: "Kiina" },
                    value: 628
                  },
                  {
                    label: { fi: "Saksa" },
                    value: 557
                  },
                  {
                    label: { fi: "Ranska" },
                    value: 434
                  },
                  {
                    label: { fi: "Arabia" },
                    value: 361
                  }
                ]
              },
              {
                type: "iconslist",
                group: "demographic",
                title: {
                  fi: "Seitsemän löytöä alueelta"
                },
                data: [
                  {
                    icon: "bicycle",
                    label: {
                      fi: "53 km pyöräteitä rannassa"
                    }
                  },
                  {
                    icon: "binoculars",
                    label: {
                      fi: "Korkeasaaren eläintarha"
                    }
                  },
                  {
                    icon: "map",
                    label: {
                      fi: "13 luonnonsuojelualuetta"
                    }
                  },
                  {
                    icon: "home",
                    label: {
                      fi: "24 kartanoa ja huvilaa"
                    }
                  },
                  {
                    icon: "leaf",
                    label: {
                      fi: "Roihuvuoren Kirsikkapuisto"
                    }
                  }
                ]
              },
              # Theme data
              {
                type: "column",
                group: "theme",
                title: {
                  fi: "Vähintään tunnin päivässä liikkuvat"
                },
                source: {
                  fi: "PKS-hyvinvointikysely 2022"
                },
                data: {
                  scale: 100,
                  items: [
                    {
                      label: {
                        fi: "4.-5. -luokka"
                      },
                      value: 39
                    },
                    {
                      label: {
                        fi: "8.-9. -luokka"
                      },
                      value: 23
                    },
                    {
                      label: {
                        fi: "2. aste"
                      },
                      value: 19
                    }
                  ]
                }
              },
              {
                type: "bar",
                group: "theme",
                title: {
                  fi: "Nuorten harrastaminen"
                },
                source: {
                  fi: "THL/Kouluterveyskysely 2021, Helsinki"
                },
                data: {
                  scale: 100,
                  items: [
                    {
                      label: {
                        fi: "Tietää asuinalueen harrastusmahdollisuuksista"
                      },
                      value: 52
                    },
                    {
                      label: {
                        fi: "Kokee harrastuspaikkojen sijaitsevan liian kaukana"
                      },
                      value: 22
                    },
                    {
                      label: {
                        fi: "Kokee kiinnostavat harrastukset liian kalliiksi"
                      },
                      value: 20
                    }
                  ]
                }
              },
              {
                type: "info",
                group: "theme",
                title: {
                  fi: "Mitä nuoret haluaisivat parantaa omalla alueellaan?"
                },
                source: {
                  fi: "Nuorten budjetti -kysely 2022"
                },
                data: {
                  fi: "Eniten nuoria puhuttavat siisteys, liikuntamahdollisuudet ja viihtyisyys."
                }
              },
              {
                type: "comment",
                group: "theme",
                source: {
                  fi: "Nuorten budjetti -kysely 2022"
                },
                data: {
                  fi: "Herttoniemen alueella nuoret arvostavat kavereita ja kaveruutta korkealle."
                }
              },
              {
                type: "numberedlist",
                group: "theme",
                title: {
                  fi: "Mikä tekee kaduista viihtyisiä?"
                },
                source: {
                  fi: "Yhteiskuntatekniset palvelut, kyselytutkimus 2022"
                },
                data: [
                  { fi: "Talviajan hiekan poistaminen nopeammin" },
                  { fi: "Reuna-alueiden ja istutusten kunnostus" },
                  { fi: "Pölyämisen esto pesemällä katuja" }
                ]
              }
            ]
          }
        end
      end

      def display_cell
        case type
        when "column_comparison", "bar", "column", "donut"
          "decidim/insights/details/charts/#{type}"
        else
          "decidim/insights/details/#{type}"
        end
      end
    end
  end
end
