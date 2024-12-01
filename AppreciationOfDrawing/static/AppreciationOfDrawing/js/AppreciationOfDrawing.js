// 获取 CSRF Token
const csrfToken = '{{ csrf_token }}';

// 获取用户图标和弹窗相关元素
const userIcon = document.getElementById('user-icon');
const modal = document.getElementById('user-modal');
const closeModal = document.getElementById('close-modal');
const shortAccount = document.getElementById('short_account');
const fullAccount = "{{ full_account }}"; // 完整账号从后端传入

// 点击用户图标显示弹窗
if (userIcon && modal && closeModal) {
    userIcon.addEventListener('click', () => {
        modal.classList.toggle('show');
    });

    // 关闭弹窗
    closeModal.addEventListener('click', () => {
        modal.classList.remove('show');
    });

    // 悬停显示完整账号
    shortAccount.addEventListener('mouseover', () => {
        shortAccount.textContent = fullAccount;
    });

    shortAccount.addEventListener('mouseout', () => {
        shortAccount.textContent = fullAccount.slice(0, 4) + "****";
    });
}

// 切换用户按钮
const switchUserBtn = document.getElementById('switch-user');
if (switchUserBtn) {
    switchUserBtn.addEventListener('click', () => {
        window.location.href = "{% url 'accounts/register' %}"; // 替换为你的注册页面URL名称
    });
}

// 加载图片到画板页面
function loadToCanvas(imageUrl) {
    if (imageUrl) {
        window.location.href = `/draw/draw_banner/?image_url=` + encodeURIComponent(imageUrl);
    }
}

// 上传弹窗逻辑
const uploadBtn = document.getElementById('upload-btn');
const popup = document.getElementById('upload-popup');
const cancelBtn = document.getElementById('cancel-btn');

if (uploadBtn && popup && cancelBtn) {
    // 显示弹窗
    uploadBtn.addEventListener('click', () => {
        popup.style.display = 'flex';
    });

    // 关闭弹窗
    cancelBtn.addEventListener('click', () => {
        popup.style.display = 'none';
    });

    // 点击弹窗外部关闭弹窗
    window.addEventListener('click', (event) => {
        if (event.target === popup) {
            popup.style.display = 'none';
        }
    });
}




// 获取 CSRF Token
function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

// 收藏或取消收藏
function toggleFavorite(drawingId) {
    const csrfToken = getCookie('csrftoken');
    if (drawingId) {
        fetch(`/Drawing/toggle_favorite/${drawingId}/`, {
            method: 'POST',
            headers: {
                'X-CSRFToken': csrfToken,
                'Content-Type': 'application/json',
            },
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    alert(data.message);
                } else {
                    console.error('Failed to toggle favorite:', data.error);
                }
            })
            .catch(error => console.error('Error:', error));
    } else {
        console.error('Invalid drawingId');
    }
}

// 加载用户收藏
function loadFavorites() {
    fetch('/Drawing/user_favorites/', {
        method: 'GET',
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
        },
    })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                const artBox = document.querySelector('.art-box');
                if (artBox) {
                    artBox.innerHTML = ''; // 清空当前区域

                    data.favorites.forEach(drawing => {
                        const card = document.createElement('div');
                        card.className = 'art-card';
                        card.innerHTML = `
                            <a href="/Drawing/drawing/${drawing.id}/" class="art-link">
                                <div class="art-image-wrapper">
                                    <img src="${drawing.picture_url}" alt="${drawing.name}" class="art-image">
                                </div>
                                <div class="art-info">
                                    <h3>${drawing.name}</h3>
                                    <p><span class="iconfont icon-liulanliang"></span>点赞数: ${drawing.likes}</p>
                                    <p><span class="iconfont icon-dianzan_kuai"></span>浏览量: ${drawing.views}</p>
                                </div>
                            </a>
                            
                        `;
                        artBox.appendChild(card);
                    });
                }
            } else {
                alert('加载收藏画作失败！');
            }
        })
        .catch(error => {
            console.error('Error fetching favorites:', error);
        });
}

// 加载推荐画作
let isRequestInProgress = false;  // 防止重复请求

function loadRecommendations() {
    fetch('/Drawing/recommendations/', {
        method: 'GET',
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
        },
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            const artBox = document.querySelector('.art-box');
            artBox.innerHTML = ''; // 清空当前展示区域

            data.recommendations.forEach(drawing => {
                const card = document.createElement('div');
                card.className = 'art-card';
                card.innerHTML = `
                    <a href="/Drawing/drawing/${drawing.id}/" class="art-link">
                        <div class="art-image-wrapper">
                            <img src="${drawing.picture_url}" alt="${drawing.name}" class="art-image">
                        </div>
                        <div class="art-info">
                            <h3>${drawing.name}</h3>
                            <p><span class="iconfont icon-liulanliang"></span> 浏览量: <span id="views_${drawing.id}">${drawing.views}</span></p>
                            <p><span class="iconfont icon-dianzan_kuai"></span> 点赞数: <span id="likes_${drawing.id}">${drawing.likes}</span></p>
                        </div>
                    </a>
                    <button class="art-button like-button" onclick="updateCount('likes', ${drawing.id})">
                        <span class="iconfont icon-dianzan"></span> 点赞
                    </button>
                        <button class="art-button favorite-button" onclick="toggleFavorite(${drawing.id})">
                            <span class="iconfont icon-shoucang1"></span>收藏
                        </button>
                `;
                artBox.appendChild(card);
            });
        } else {
            console.error('推荐内容加载失败：', data.message);
        }
    })
    .catch(error => console.error('加载推荐内容时出错：', error));
}



// 按钮点击事件绑定
document.querySelector('.middle-li.button-hover').addEventListener('click', loadRecommendations);


// 更新计数（点赞、浏览等）
function updateCount(action, drawingId) {
    fetch(`/Drawing/update_count/${action}/${drawingId}/`, {
        method: 'POST',
        headers: {
            'X-CSRFToken': getCookie('csrftoken'), // 确保正确传递 CSRF token
            'Content-Type': 'application/json',
        },
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // 更新点赞数
            document.querySelector(`#likes_${drawingId}`).innerText = data.count;

            // 如果需要全局刷新，可以重新加载猜你喜欢或画作列表
            // loadRecommendations(); // 如果需要刷新推荐内容，取消此注释
        } else {
            console.error('点赞失败：', data.error);
        }
    })
    .catch(error => console.error('点赞请求失败：', error));
}

// 在浏览器返回时重新加载推荐内容
window.addEventListener('pageshow', function (event) {
    if (event.persisted) { // 确保是从缓存返回时触发
        loadRecommendations();
    }
});

