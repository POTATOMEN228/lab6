import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Lab6App());
}

class Lab6App extends StatelessWidget {
  const Lab6App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A), // Slate Dark
          primary: const Color(0xFF6366F1), // Indigo
        ),
        useMaterial3: true,
      ),
      home: const ModernRegistrationScreen(),
    );
  }
}

class ModernRegistrationScreen extends StatefulWidget {
  const ModernRegistrationScreen({super.key});

  @override
  State<ModernRegistrationScreen> createState() =>
      _ModernRegistrationScreenState();
}

class _ModernRegistrationScreenState extends State<ModernRegistrationScreen> {
  // GlobalKey to manage Form State
  final _formKey = GlobalKey<FormState>();

  // Input Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  // Screen State Variables
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
  bool _termsError = false;
  String _selectedRole = 'Student';

  final List<String> _roles = ['Student', 'Teacher', 'Developer'];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();

    setState(() {
      _termsError = !_acceptedTerms;
    });

    if (isFormValid && _acceptedTerms) {
      if (kDebugMode) {
        print('Registration succsess');
        print('Full Name: ${_fullNameController.text}');
        print('Email: ${_emailController.text}');
        print('Role: $_selectedRole');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Account created for ${_fullNameController.text}!',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF10B981), // Emerald Green
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Crisp Light Slate Background
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const SizedBox(height: 12),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Please fill in your details to register.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 28),

              // Form Container Card
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      _buildInputLabel('Full Name'),
                      TextFormField(
                        controller: _fullNameController,
                        decoration: _buildInputDecoration(
                          hint: 'John Doe',
                          prefixIcon: Icons.person_outline_rounded,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Full name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // Email Field
                      _buildInputLabel('Email Address'),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _buildInputDecoration(
                          hint: 'name@narxoz.kz',
                          prefixIcon: Icons.alternate_email_rounded,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email address is required';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Enter a valid email (e.g., name@narxoz.kz)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // Password Field
                      _buildInputLabel('Password'),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: _buildInputDecoration(
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF94A3B8),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Minimum 6 characters required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // Confirm Password Field
                      _buildInputLabel('Confirm Password'),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: _buildInputDecoration(
                          hint: '••••••••',
                          prefixIcon: Icons.shield_outlined,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF94A3B8),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // User Role Selector (Chips)
                      _buildInputLabel('Select Role'),
                      Row(
                        children: _roles.map((role) {
                          final isSelected = _selectedRole == role;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedRole = role;
                                });
                              },
                              child: Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 4),
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF6366F1)
                                      : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    role,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Terms Checkbox
                      InkWell(
                        onTap: () {
                          setState(() {
                            _acceptedTerms = !_acceptedTerms;
                            if (_acceptedTerms) _termsError = false;
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _acceptedTerms,
                                activeColor: const Color(0xFF6366F1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _acceptedTerms = value ?? false;
                                    if (_acceptedTerms) _termsError = false;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'I accept the Terms and Conditions',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF334155),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_termsError)
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0, top: 6.0),
                          child: Text(
                            'You must accept terms to proceed',
                            style: TextStyle(
                              color: Color(0xFFEF4444),
                              fontSize: 12,
                            ),
                          ),
                        ),

                      const SizedBox(height: 28),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F172A),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color(0xFF475569),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF94A3B8), size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
      ),
    );
  }
}