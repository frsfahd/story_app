import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:story_app/core/app_routes.dart';
import 'package:story_app/features/auth/domain/login_schema.dart';
import 'package:story_app/features/auth/presentation/widgets.dart/slanted_bottom_clipper.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/shared/custom_text.dart';
import 'package:story_app/shared/loading_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> _showForgotPasswordModal() async {
  //   final resultEmail = await showModalBottomSheet<String>(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (ctx) =>
  //         ForgotPasswordSheet(initialEmail: _emailController.text.trim()),
  //   );

  //   if (!mounted) return;
  //   if (resultEmail != null) {
  //     final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //     try {
  //       await authProvider.forgotPassword(resultEmail);
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             'Pastikan email terdaftar adalah email aktif, temporary password telah dikirim ke $resultEmail',
  //           ),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //     } catch (e) {
  //       if (!mounted) return;
  //       final msg = authProvider.error ?? 'Permintaan reset gagal';
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(msg), backgroundColor: Colors.red),
  //       );
  //     }
  //   }
  // }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    final authProvider = context.read<AuthProvider>();
    try {
      final input = LoginSchema(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      await authProvider.login(input);
      // if (!mounted) return;
      // context.go(AppRoutes.home);
    } catch (e) {
      if (!mounted) return;
      // Ambil pesan error dari provider jika ada
      final errorMsg = authProvider.errorMessage;
      if (errorMsg != '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        authProvider.clearError();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.isLoading) {
              return const LoadingWidget();
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with diagonal bottom
                  Stack(
                    children: [
                      ClipPath(
                        clipper: SlantedBottomClipper(),
                        child: Container(
                          height: 220,
                          color: theme.colorScheme.primaryContainer,
                        ),
                      ),
                      Positioned(
                        left: 24,
                        top: 96,
                        right: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.loginHeader,
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              AppLocalizations.of(context)!.loginSubHeader,
                              style: TextStyle(
                                color: theme.colorScheme.onPrimaryContainer
                                    .withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email label + field
                          CustomText(
                            'Email',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.9,
                              ),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(
                                context,
                              )!.loginEmailHintText,
                              filled: true,
                              fillColor: theme.colorScheme.primaryContainer
                                  .withValues(alpha: 0.4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.loginEmailValidator;
                              }
                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ).hasMatch(value)) {
                                return AppLocalizations.of(
                                  context,
                                )!.loginEmailValidator2;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Password label + field
                          CustomText(
                            AppLocalizations.of(context)!.loginPasswordLabel,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.9,
                              ),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(
                                context,
                              )!.loginPasswordHIntText,
                              filled: true,
                              fillColor: theme.colorScheme.primaryContainer
                                  .withValues(alpha: 0.4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () => setState(() {
                                  _obscurePassword = !_obscurePassword;
                                }),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.loginPasswordValidator;
                              }
                              if (value.length < 8) {
                                return AppLocalizations.of(
                                  context,
                                )!.loginPasswordValidator2;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _handleLogin,
                              child: Text(
                                AppLocalizations.of(context)!.loginButton,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              // onPressed: _showForgotPasswordModal,
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!.loginForgetPassword,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.loginToRegisterText,
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.pushNamed(AppRoutes.registration),
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.loginToRegisterButton,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
