const express = require('express');
const session = require('express-session');
const passport = require('passport');
const DiscordStrategy = require('passport-discord').Strategy;
const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const app = express();
const PORT = 3000;

// === CẤU HÌNH DISCORD OAUTH2 ===
// Thay thông tin của bạn từ Discord Developer Portal vào đây
const CLIENT_ID = '1549389202217508914';
const CLIENT_SECRET = 'WDBWZ5MdzieXWzfDn-05la5JtIZvtzl6';
const CALLBACK_URL = 'http://localhost:3000/auth/discord/callback';

// === KẾT NỐI CƠ SỞ DỮ LIỆU SQLITE ===
const db = new sqlite3.Database(path.join(__dirname, 'whitelist.db'), (err) => {
    if (err) console.error('Lỗi kết nối Database:', err.message);
    else console.log('Đã kết nối với SQLite Database.');
});

// Tạo bảng lưu HWID nếu chưa có
db.run(`CREATE TABLE IF NOT EXISTS whitelist (
    discord_id TEXT PRIMARY KEY,
    username TEXT,
    hwid TEXT
)`);

// === CẤU HÌNH PASSPORT DISCORD ===
passport.serializeUser((user, done) => done(null, user));
passport.deserializeUser((obj, done) => done(null, obj));

passport.use(new DiscordStrategy({
    clientID: CLIENT_ID,
    clientSecret: CLIENT_SECRET,
    callbackURL: CALLBACK_URL,
    scope: ['identify']
}, (accessToken, refreshToken, profile, done) => {
    return done(null, profile);
}));

app.use(express.urlencoded({ extended: true }));
app.use(session({
    secret: 'chuoi_bi_mat_cua_ban',
    resave: false,
    saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());

// Đặt EJS làm template engine để hiển thị trang web
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// === CÁC ĐƯỜNG DẪN (ROUTES) ===

// 1. Trang chủ
app.get('/', (req, res) => {
    res.send(`
        <h2>Hệ thống Quản lý Whitelist HWID</h2>
        ${req.isAuthenticated() ? 
            `<p>Xin chào, <b>${req.user.username}</b>!</p>
             <a href="/dashboard">Vào trang quản lý HWID</a> | 
             <a href="/logout">Đăng xuất</a>` : 
            `<a href="/auth/discord">Đăng nhập bằng Discord</a>`}
    `);
});

// 2. Bắt đầu đăng nhập Discord
app.get('/auth/discord', passport.authenticate('discord'));

// 3. Callback sau khi đăng nhập Discord thành công
app.get('/auth/discord/callback', 
    passport.authenticate('discord', { failureRedirect: '/' }),
    (req, res) => res.redirect('/dashboard')
);

// 4. Trang Dashboard nhập HWID
app.get('/dashboard', (req, res) => {
    if (!req.isAuthenticated()) return res.redirect('/');
    
    db.get(`SELECT hwid FROM whitelist WHERE discord_id = ?`, [req.user.id], (err, row) => {
        const currentHwid = row ? row.hwid : 'Chưa có';
        res.send(`
            <h2>Trang Quản lý Whitelist</h2>
            <p>Tài khoản: ${req.user.username}</p>
            <p>HWID hiện tại của bạn: <b>${currentHwid}</b></p>
            <form action="/save-hwid" method="POST">
                <label>Nhập mã HWID mới của máy bạn:</label><br>
                <input type="text" name="hwid" required style="width: 300px; padding: 5px;"><br><br>
                <button type="submit" style="padding: 5px 10px;">Lưu / Cập nhật HWID</button>
            </form>
            <br><a href="/">Quay lại trang chủ</a>
        `);
    });
});

// 5. Xử lý lưu HWID vào Database
app.post('/save-hwid', (req, res) => {
    if (!req.isAuthenticated()) return res.redirect('/');
    const { hwid } = req.body;
    const discordId = req.user.id;
    const username = req.user.username;

    db.run(`INSERT INTO whitelist (discord_id, username, hwid) VALUES (?, ?, ?) 
            ON CONFLICT(discord_id) DO UPDATE SET hwid = ?`, 
            [discordId, username, hwid, hwid], (err) => {
        if (err) {
            console.error(err);
            return res.send('Lỗi lưu cơ sở dữ liệu!');
        }
        res.send(`<h3>Cập nhật HWID thành công!</h3><a href="/dashboard">Quay lại</a>`);
    });
});

// 6. Đăng xuất
app.get('/logout', (req, res) => {
    req.logout(() => {
        res.redirect('/');
    });
});

// Khởi chạy server
app.listen(PORT, () => {
    console.log(`Server đang chạy tại: http://localhost:${PORT}`);
});
