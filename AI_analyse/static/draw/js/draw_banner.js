const canvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');
let startPos = { x: undefined, y: undefined };
let isPainting = false;
let isErasering = false;
let brushColor = '#F50C0C';
let action = 'draw';

function initCanvas() {
  canvas.width = document.documentElement.offsetWidth;
  canvas.height = document.documentElement.offsetHeight;
  enableDownload(canvas);
}
// 初始化canvas
initCanvas();

// canvas操作 - 画线
function drawLine({ startX, startY, endX, endY, color = brushColor }) {
  //开始绘制
  ctx.beginPath();
  //线宽
  ctx.lineWidth = 2;
  // 线颜色
  ctx.strokeStyle = color;
  ctx.lineCap = 'round';
  //起始位置
  ctx.moveTo(startX, startY);
  //停止位置
  ctx.lineTo(endX, endY);
  //描绘线路
  ctx.stroke();
  //结束绘制
  ctx.closePath();
}
// 监听canvas鼠标事件
// 1. mousedwn 确定起始坐标，准备绘制
canvas.addEventListener('mousedown', function (event) {
  startPos.x = event.offsetX;
  startPos.y = event.offsetY;
  isPainting = true;
});
// 2. 监听鼠标移动，绘制图形 or 擦除
canvas.addEventListener('mousemove', function (event) {
  const endX = event.offsetX;
  const endY = event.offsetY;

  if (isPainting && typeof startPos.x === 'number' && typeof startPos.y === 'number') {
    if (isErasering && action === 'eraser') {
      ctx.clearRect(endX - 5, endY - 5, 25, 25);
    } else if (!isErasering && action === 'draw') {
      drawLine({
        startX: startPos.x,
        startY: startPos.y,
        endX,
        endY,
        color: brushColor,
      });
      startPos.x = endX;
      startPos.y = endY;
    }
  }
});
// 监听鼠标抬起， 结束绘制
canvas.addEventListener('mouseup', function () {
  isPainting = false;
  startPos = {x: undefined, y: undefined };
  enableDownload(canvas);
});

function enableDownload(canvas) {
  const a = document.getElementById('download');
  a.href = canvas.toDataURL();
}

// 画笔/橡皮切换
document.getElementById('pencil').addEventListener('click', function () {
  action = 'draw';
  isErasering = false;
  isPainting = true;
  document.getElementById('canvas').className = action;
  this.classList.add('active');
  document.getElementById('eraser').classList.remove('active');
});
document.getElementById('eraser').addEventListener('click', function () {
  action = 'eraser';
  isErasering = true;
  isPainting = false;
  document.getElementById('canvas').className = action;
  this.classList.add('active');
  document.getElementById('pencil').classList.remove('active');
});

// 清除画布
document.getElementById('delete').addEventListener('click', function () {
  ctx.fillStyle = '#f0f0f0';
  ctx.fillRect(0, 0, canvas.width, canvas.height);
});

// 打开 or 关闭色板
function toggleColorPanel() {
  const colorPanel = document.getElementById('color-panel');
  if (colorPanel.className.includes('show')) {
    colorPanel.classList.remove('show');
    colorPanel.classList.add('hide');
  } else {
    colorPanel.classList.remove('hide');
    colorPanel.classList.add('show');
  }
}
document.getElementById('color').addEventListener('click', toggleColorPanel);

// 选取颜色
document.getElementById('color-panel').addEventListener('click', function (event) {
  if (event.target.nodeName.toLowerCase() === 'li') {
    toggleColorPanel();
    brushColor = event.target.dataset.color;
    document.getElementById('color').style.setProperty('--selected-color', event.target.dataset.color);
  }
});

let smallCurrentIndex = 0;
const smallSlides = document.querySelectorAll(".small-carousel .carousel-slide img");
const smallDots = document.querySelectorAll(".small-carousel-dots .dot");

// 初始化显示小轮播图的第一张图片
showSmallSlide(smallCurrentIndex);

function showSmallSlide(index) {
  const slideElement = document.getElementById(`slide-${index}`);R
    if (index >= smallSlides.length) smallCurrentIndex = 0;
    if (index < 0) smallCurrentIndex = smallSlides.length - 1;

    document.querySelector(".small-carousel .carousel-slide").style.transform = `translateX(-${smallCurrentIndex * 400}px)`;

    // 更新小圆点
    smallDots.forEach(dot => dot.classList.remove("active"));
    smallDots[smallCurrentIndex].classList.add("active");
}

function changeSmallSlide(step) {
    smallCurrentIndex += step;
    showSmallSlide(smallCurrentIndex);
}

// 页码点的控制
function currentSmallSlide(index) {
    smallCurrentIndex = index - 1;
    showSmallSlide(smallCurrentIndex);
}

// 自动轮播小轮播图
const smallCarouselInterval = setInterval(() => {
    smallCurrentIndex++;
    showSmallSlide(smallCurrentIndex);
}, 5000);



// 获取 URL 参数
    function getUrlParameter(name) {
        name = name.replace(/[\[\]]/g, '\\$&');
        const regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
        const results = regex.exec(window.location.href);
        if (!results || !results[2]) return null;
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }

    // 加载图片到画布
    window.onload = function() {
        const canvas = document.getElementById('canvas');
        const context = canvas.getContext('2d');
        const imageUrl = getUrlParameter('image_url'); // 从 URL 中获取图片路径

        if (imageUrl) {
            const img = new Image();
            img.src = imageUrl;
            img.onload = function() {
                // 调整画布大小以匹配图片大小
                canvas.width = img.width;
                canvas.height = img.height;
                // 绘制图片到画布
                context.drawImage(img, 0, 0);
            };
        }
    };