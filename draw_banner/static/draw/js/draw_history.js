// 获取元素
const userIcon = document.getElementById('user-icon');
const modal = document.getElementById('user-modal');
const closeModal = document.getElementById('close-modal');
const shortAccount = document.getElementById('short_account');
const fullAccount = "{{ full_account }}";  // 完整账号从后端传入

// 点击用户图标显示弹窗
userIcon.addEventListener('click', () => {
    modal.classList.toggle('show');
});

// 关闭弹窗
closeModal.addEventListener('click', () => {
    modal.classList.remove('show');
});

// 悬停显示完整账号，离开时显示部分账号
shortAccount.addEventListener('mouseover', () => {
    shortAccount.textContent = fullAccount;
});
shortAccount.addEventListener('mouseout', () => {
    shortAccount.textContent = fullAccount.slice(0, 4) + "****";
});

// 切换用户按钮，跳转到登录页面
document.getElementById('switch-user').addEventListener('click', () => {
    window.location.href = "{% url 'accounts/register/' %}";  // 替换为你的登录页面URL名称
});



function loadToCanvas(imageUrl) {
        // 重定向到画板页面，并附加图片 URL 参数
        window.location.href = `/draw/draw_banner/?image_url=` + encodeURIComponent(imageUrl);
    }





     // 获取按钮和弹窗元素
    const uploadBtn = document.getElementById('upload-btn');
    const popup = document.getElementById('upload-popup');
    const cancelBtn = document.getElementById('cancel-btn');

    // 点击上传按钮显示弹窗
    uploadBtn.addEventListener('click', () => {
        popup.style.display = 'block';
    });

    // 点击取消按钮关闭弹窗
    cancelBtn.addEventListener('click', () => {
        popup.style.display = 'none';
    });

    // 点击弹窗外部区域关闭弹窗
    window.addEventListener('click', (event) => {
        if (event.target === popup) {
            popup.style.display = 'none';
        }
    });

    function closePopup() {
    const popup = document.getElementById('upload-popup');
    popup.style.display = 'none';
}

// 显示弹窗
function openPopup() {
    const popup = document.getElementById('upload-popup');
    popup.style.display = 'flex'; // 使用 flex 居中对齐
}

// 隐藏弹窗
function closePopup() {
    const popup = document.getElementById('upload-popup');
    popup.style.display = 'none';
}
