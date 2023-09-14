const performSearch = (url, search) => {
  const params = new URLSearchParams(search);

  window.Rails.ajax({
    url: url,
    type: "GET",
    data: params.toString(),
    success: (_data) => {},
    error: (_data) => {}
  })
};

const eachFilter = (element, iterator) => {
  element.querySelectorAll("select").forEach(iterator);
};

const filtersToParams = (element) => {
  const params = {};

  eachFilter(element, (filter) => {
    params[filter.getAttribute("name")] = filter.value;
  });

  return params;
};

document.addEventListener("DOMContentLoaded", () => {
  const filterSection = document.querySelector("[data-details-filter]");
  if (!filterSection) {
    return;
  }

  // Submit button not needed with JS
  const submitButton = filterSection.querySelector("button[type='submit']");
  if (submitButton) {
    submitButton.remove();
  }

  const filterUrl = filterSection.dataset.detailsFilter;

  eachFilter(filterSection, (filter) => {
    filter.addEventListener("change", () => {
      performSearch(filterUrl, filtersToParams(filterSection));
    });
  })
});
