$(function () {


  // =====================================
  // Profit
  // =====================================
  var profit = {
    series: [
      {
        name: "Profit",
        data: [18, 7, 15, 29, 18, 18, 7, 15, 29, 18, 12, 9],
      },
      {
        name: "Expenses",
        data: [-13, -18, -9, -14, -15, -13, -18, -9, -14, -5, -17, -15],
      },
    ],
    colors: ["var(--bs-primary)", "#fb977d"],
    chart: {
      type: "bar",
      fontFamily: "Plus Jakarta Sans', sans-serif",
      foreColor: "#adb0bb",
      width: "100%",
      height: 350,
      stacked: true,
      toolbar: {
        show: !1,
      },
    },
  
    plotOptions: {
      bar: {
        horizontal: false,
        columnWidth: "35%",
        borderRadius: [6],
        borderRadiusApplication: 'end',
        borderRadiusWhenStacked: 'all'
      },
    },
    dataLabels: {
      enabled: false,
    },
    stroke: {
      curve: "smooth",
      width: 6,
      colors: ["transparent"],
    },
  
    grid: {
      borderColor: "transparent",
      padding: { top: 0, bottom: -8, left: 20, right: 20 },
    },
    tooltip: {
      theme: "dark",
    },
    toolbar: {
      show: false,
    },
    xaxis: {
      categories: ["Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
      axisBorder: {
        show: false,
      },
      axisTicks: {
        show: false,
      },
    },
    legend: {
      show: false,
    },
    fill: {
      opacity: 1,
    },
  };
  
  var chart = new ApexCharts(document.querySelector("#profit"), profit);
  chart.render();


  // =====================================
  // Breakup
  // =====================================
  var grade = {
    series: [5368, 3500, 4106],
    labels: ["5368", "Refferal Traffic", "Oragnic Traffic"],
    chart: {
      height: 170,
      type: "donut",
      fontFamily: "Plus Jakarta Sans', sans-serif",
      foreColor: "#c6d1e9",
    },
  
    tooltip: {
      theme: "dark",
      fillSeriesColor: false,
    },
  
    colors: ["#e7ecf0", "#fb977d", "var(--bs-primary)"],
    dataLabels: {
      enabled: false,
    },
  
    legend: {
      show: false,
    },
  
    stroke: {
      show: false,
    },
    responsive: [
      {
        breakpoint: 991,
        options: {
          chart: {
            width: 150,
          },
        },
      },
    ],
    plotOptions: {
      pie: {
        donut: {
          size: '80%',
          background: "none",
          labels: {
            show: true,
            name: {
              show: true,
              fontSize: "12px",
              color: undefined,
              offsetY: 5,
            },
            value: {
              show: false,
              color: "#98aab4",
            },
          },
        },
      },
    },
  };
  
  var chart = new ApexCharts(document.querySelector("#grade"), grade);
  chart.render();
  



  // =====================================
  // Earning
  // =====================================
  var earning = {
    chart: {
      id: "sparkline3",
      type: "area",
      height: 60,
      sparkline: {
        enabled: true,
      },
      group: "sparklines",
      fontFamily: "Plus Jakarta Sans', sans-serif",
      foreColor: "#adb0bb",
    },
    series: [
      {
        name: "Earnings",
        color: "#8763da",
        data: [25, 66, 20, 40, 12, 58, 20],
      },
    ],
    stroke: {
      curve: "smooth",
      width: 2,
    },
    fill: {
      colors: ["#f3feff"],
      type: "solid",
      opacity: 0.05,
    },

    markers: {
      size: 0,
    },
    tooltip: {
      theme: "dark",
      fixed: {
        enabled: true,
        position: "right",
      },
      x: {
        show: false,
      },
    },
  };
  new ApexCharts(document.querySelector("#earning"), earning).render();
})