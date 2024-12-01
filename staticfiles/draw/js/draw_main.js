let currentIndex = 0;
let slideWidth = 1140; // 每张图片的宽度为 1140px
let slides = document.querySelectorAll(".carousel-slide img");
let dots = document.querySelectorAll(".dot");

// 动态设置轮播图宽度为图片数量 * 图片宽度
document.querySelector(".carousel-slide").style.width = `${slides.length * slideWidth}px`;

function showSlide(index) {
    currentIndex = (index + slides.length) % slides.length; // 循环轮播
    document.querySelector(".carousel-slide").style.transform = `translateX(-${currentIndex * slideWidth}px)`;

    dots.forEach(dot => dot.classList.remove("active"));
    dots[currentIndex].classList.add("active");
}

function changeSlide(step) {
    showSlide(currentIndex + step);
}

function currentSlide(index) {
    showSlide(index - 1);
}

// 自动轮播
setInterval(() => {
    changeSlide(1);
}, 5000);



let newCurrentIndex = 0;
const newSlides = document.querySelectorAll(".new-carousel-slide img");
const newDots = document.querySelectorAll(".new-carousel-dots .new-dot");

// 初始化显示第一张图片
showNewSlide(newCurrentIndex);

function showNewSlide(index) {
    if (index >= newSlides.length) newCurrentIndex = 0;
    if (index < 0) newCurrentIndex = newSlides.length - 1;

    document.querySelector(".new-carousel-slide").style.transform = `translateX(-${newCurrentIndex * 400}px)`;

    // 更新小圆点
    newDots.forEach(dot => dot.classList.remove("active"));
    newDots[newCurrentIndex].classList.add("active");
}

function newChangeSlide(step) {
    newCurrentIndex += step;
    showNewSlide(newCurrentIndex);
}

// 页码点的控制
function newCurrentSlide(index) {
    newCurrentIndex = index;
    showNewSlide(newCurrentIndex);
}

// 自动轮播
const newCarouselInterval = setInterval(() => {
    newCurrentIndex++;
    showNewSlide(newCurrentIndex);
}, 5000);
