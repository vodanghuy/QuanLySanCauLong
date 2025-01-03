import 'package:flutter/material.dart';
import 'package:quan_ly_san_cau_long/services/auth_service.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
{
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sdtController = TextEditingController();
  final TextEditingController _hoVaTenController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? selectedValue;
  String _message = "";
  bool _isUsernameValid = true;

  // Hàm kiểm tra tên đăng nhập
  Future<void> _checkUsernameExistence(String username) async {
    bool isUsernameTaken = await _authService.checkUserName(username);
    setState(() {
      _isUsernameValid = !isUsernameTaken;  // Cập nhật trạng thái hợp lệ của tên đăng nhập
    });
  }

  void _register() async{

    setState(() {
      _isLoading = true;
      FocusScope.of(context).unfocus(); //Đóng bàn phím
    });
    if (_formKey.currentState?.validate() ?? false) {
      try {
        String message = await _authService.register(
          _usernameController.text,
          _passwordController.text,
          _hoVaTenController.text,
          _sdtController.text,
          _emailController.text ?? "",
          selectedValue ?? "",
        );

        if (message == "Đăng ký thành công") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng ký thành công!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng ký thất bại: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_add, size: 100, color: Colors.blue),
                    _gap(),
                    Text(
                      "ĐĂNG KÝ",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Tạo tài khoản mới.",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    _gap(),
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tên đăng nhập không được để trống.';
                        }
                        if (!_isUsernameValid)
                          {
                            return 'Tên đăng nhập đã tồn tại.';
                          }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Tên đăng nhập',
                        hintText: 'Nhập tên đăng nhập',
                        prefixIcon: Icon(Icons.person_2_outlined),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _checkUsernameExistence(value);  // Kiểm tra tên đăng nhập khi người dùng thay đổi
                        }
                      },
                    ),
                    _gap(),
                    TextFormField(
                      controller: _hoVaTenController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Họ và tên không được để trống.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Họ và tên',
                        hintText: 'Nhập họ và tên',
                        prefixIcon: Icon(Icons.face_2_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    DropdownButtonFormField<String>(
                      value: selectedValue,
                      hint: Text('Chọn giới tính'),
                      decoration: InputDecoration(
                        labelText: 'Giới tính',
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.male, color: Colors.blue),

                            Icon(Icons.female, color: Colors.pink),
                          ],
                        ),
                        border: OutlineInputBorder(),
                      ),
                      items: ['Nam', 'Nữ'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng chọn một giá trị';  // Thông báo lỗi nếu chưa chọn
                        }
                        return null;  // Không có lỗi nếu đã chọn
                      },
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),
                    _gap(),
                    TextFormField(
                      controller: _sdtController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Số điện thoại không được để trống.';
                        }
                        if (!RegExp(r"^(0[1-9])[0-9]{8}$").hasMatch(value)) {
                          return 'Số điện thoại không hợp lệ.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                        hintText: 'Nhập Số điện thoại',
                        prefixIcon: Icon(Icons.phone_android_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Email không hợp lệ.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email (không bắt buộc)',
                        hintText: 'Nhập email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mật khẩu không được để trống.';
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu phải từ 6 ký tự trở lên.';
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        hintText: 'Nhập mật khẩu',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: _isPasswordVisible ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Xác nhận mật khẩu không được để trống.';
                        }
                        if (value != _passwordController.text) {
                          return 'Mật khẩu không khớp.';
                        }
                        return null;
                      },
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Xác nhận mật khẩu',
                        hintText: 'Nhập lại mật khẩu',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: _isConfirmPasswordVisible ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    _gap(),
                    if (_errorMessage != null) ...[
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      _gap(),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: _isLoading ? null : _register,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _gap(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Text('Đã có tài khoản? Đăng nhập'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _gap() => const SizedBox(height: 16);
}