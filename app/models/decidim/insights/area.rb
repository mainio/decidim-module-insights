# frozen_string_literal: true

module Decidim
  module Insights
    AreaStruct = Struct.new("Area", :position, :key, :image, :name, :title, :summary, :description)

    # Static area records that can be used to display the area data.
    class Area < AreaStruct
      include StructModel

      class << self
        private

        def data
          @data ||= [
            {
              position: 0,
              key: "southeastern",
              image: "media/images/helsinki-subdivision-southeastern.svg",
              name: {
                fi: "Kaakkoinen",
                sv: "Sydöstra",
                en: "Southeastern"
              },
              title: {
                fi: "Kaakkoinen Helsinki",
                sv: "Sydöstra Helsinfors",
                en: "Southeastern Helsinki"
              },
              summary: {
                fi: "Esim. Kulosaari, Herttoniemi, Laajasalo, Tammisalo, Vartiosaari, Villinki",
                sv: "T.ex. Brändö, Hertonäs, Degerö, Tammelund, Vårdö, Villinge",
                en: "E.g. Kulosaari, Herttoniemi, Laajasalo, Tammisalo, Vartiosaari, Villinki"
              }
            },
            {
              position: 1,
              key: "northern",
              image: "media/images/helsinki-subdivision-northern.svg",
              name: {
                fi: "Pohjoinen",
                sv: "Norra",
                en: "Northern"
              },
              title: {
                fi: "Pohjoinen Helsinki",
                sv: "Norra Helsingfors",
                en: "Northern Helsinki"
              },
              summary: {
                fi: "Esim. Maunula, Länsi-Pakila, Tuomarinkylä, Oulunkylä, Itä-Pakila",
                sv: "T.ex. Månsas, Västra Baggböle, Domarby, Åggelby, Östra Baggböle)",
                en: "E.g. Maunula, Länsi-Pakila, Tuomarinkylä, Oulunkylä, Itä-Pakila"
              }
            },
            {
              position: 2,
              key: "northeastern",
              image: "media/images/helsinki-subdivision-northeastern.svg",
              name: {
                fi: "Koillinen",
                sv: "Nordöstra",
                en: "Northeastern"
              },
              title: {
                fi: "Koillinen Helsinki",
                sv: "Nordöstra Helsingfors",
                en: "Northeastern Helsinki"
              },
              summary: {
                fi: "Esim. Latokartano, Malmi, Suutarila, Puistola, Jakomäki",
                sv: "T.ex. ",
                en: "E.g. Latokartano, Malmi, Suutarila, Puistola, Jakomäki"
              }
            },
            {
              position: 3,
              key: "easternosternsundom",
              image: "media/images/helsinki-subdivision-easternostersundom.svg",
              name: {
                fi: "Itäinen ja Östersundom",
                sv: "Östra och Östersundom",
                en: "Eastern and Östersundom"
              },
              title: {
                fi: "Itäinen Helsinki ja Östersundom",
                sv: "Östra Helsingfors och Östersundom",
                en: "Eastern Helsinki and Östersundom"
              },
              summary: {
                fi: "Esim. Vartiokylä, Mellunkylä, Vuosaari, Östersundom",
                sv: "T.ex. Botby, Mellungsby, Nordsjö, Östersundom",
                en: "E.g. Vartiokylä, Mellunkylä, Vuosaari, Östersundom"
              }
            },
            {
              position: 4,
              key: "western",
              image: "media/images/helsinki-subdivision-western.svg",
              name: {
                fi: "Läntinen",
                sv: "Västra",
                en: "Western"
              },
              title: {
                fi: "Läntinen Helsinki",
                sv: "Västra Helsingfors",
                en: "Western Helsinki"
              },
              summary: {
                fi: "Esim. Reijola, Munkkiniemi, Haaga, Pitäjänmäki, Kaarela",
                sv: "T.ex. Grejus, Munksnäs, Haga, Sockenbacka, Kårböle",
                en: "E.g. Reijola, Munkkiniemi, Haaga, Pitäjänmäki, Kaarela"
              }
            },
            {
              position: 5,
              key: "central",
              image: "media/images/helsinki-subdivision-central.svg",
              name: {
                fi: "Keskinen",
                sv: "Mellersta",
                en: "Central"
              },
              title: {
                fi: "Keskinen Helsinki",
                sv: "Mellersta Helsingfors",
                en: "Central Helsinki"
              },
              summary: {
                fi: "Esim. Alppiharju, Kallio, Pasila, Vallila, Vanhakaupunki",
                sv: "T.ex. Åshöjden, Berghäll, Böle, Vallgård, Gammelstaden",
                en: "E.g. Alppiharju, Kallio, Pasila, Vallila, Vanhakaupunki"
              }
            },
            {
              position: 6,
              key: "southern",
              image: "media/images/helsinki-subdivision-southern.svg",
              name: {
                fi: "Eteläinen",
                sv: "Södra",
                en: "Southern"
              },
              title: {
                fi: "Eteläinen Helsinki",
                sv: "Södra Helsingfors",
                en: "Southern Helsinki"
              },
              summary: {
                fi: "Esim. Vironniemi, Ullanlinna, Kampinmalmi, Lauttasaari",
                sv: "T.ex. Estnäs, Ulrikasborg, Kampmalmen, Drumsö",
                en: "E.g. Vironniemi, Ullanlinna, Kampinmalmi, Lauttasaari"
              }
            }
          ]
        end
      end

      def details
        AreaDetail.where(area_key: key)
      end
    end
  end
end
