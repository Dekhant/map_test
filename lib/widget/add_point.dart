import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:map_task/gen/assets.gen.dart';
import 'package:map_task/gen/colors.dart';
import 'package:map_task/widget/custom_text_button.dart';
import 'package:map_task/widget/textfield_with_title.dart';

class AddPoint extends StatefulWidget {
  const AddPoint({super.key});

  @override
  State<AddPoint> createState() => _AddPointState();
}

class _AddPointState extends State<AddPoint> {
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _firstAddressController = TextEditingController();
  final TextEditingController _secondAddressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _hasEmailError = false;
  bool _hasAddressNameError = false;
  bool _hasFirstNameError = false;
  bool _hasLastNameError = false;
  bool _hasCompanyNameError = false;
  bool _hasFirstAddressError = false;
  bool _hasCountryError = false;
  bool _hasCityError = false;
  bool _hasStateError = false;
  bool _hasZipError = false;
  bool _hasPhoneError = false;

  @override
  void dispose() {
    _addressNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyNameController.dispose();
    _firstAddressController.dispose();
    _secondAddressController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = PhoneInputFormatter();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 92),
                child: Image.asset(Assets.images.logo.path),
              ),
              const SizedBox(height: 14),
              AppBar(
                backgroundColor: AppColors.primaryRed,
                title: const Row(
                  children: [
                    Spacer(),
                    Text(
                      'Add New Ship From Address',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.32,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                leading: const BackButton(color: Colors.white),
              ),
              const SizedBox(height: 29),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Color(0xFFD31818),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: ' — Fields obligatory for filling',
                            style: TextStyle(
                              color: Color(0xFF020202),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TextFieldWithTitle(
                          controller: _addressNameController,
                          text: 'Address Name',
                          isRequired: true,
                          errorMessage: 'Address must be filled',
                          haveError: _hasAddressNameError,
                          onChange: (value) => setState(() {
                            if (value.isEmpty) {
                              _hasAddressNameError = true;
                            } else {
                              _hasAddressNameError = false;
                            }
                          }),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.50, color: const Color(0xFF808C94)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          children: [
                            StatefulBuilder(
                              builder: (context, setState) {
                                return TextFieldWithTitle(
                                  text: 'First Name',
                                  controller: _firstNameController,
                                  isRequired: true,
                                  haveError: _hasFirstNameError,
                                  errorMessage: 'First Name must be filled',
                                  onChange: (value) => setState(() {
                                    if (value.isEmpty) {
                                      _hasFirstNameError = true;
                                    } else {
                                      _hasFirstNameError = false;
                                    }
                                  }),
                                );
                              },
                            ),
                            const SizedBox(height: 14),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return TextFieldWithTitle(
                                  text: 'Last Name',
                                  controller: _lastNameController,
                                  isRequired: true,
                                  haveError: _hasLastNameError,
                                  errorMessage: 'Last Name must be filled',
                                  onChange: (value) => setState(() {
                                    if (value.isEmpty) {
                                      _hasLastNameError = true;
                                    } else {
                                      _hasLastNameError = false;
                                    }
                                  }),
                                );
                              },
                            ),
                            const SizedBox(height: 14),
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    height: 0.5,
                                    thickness: 0.5,
                                    color: Color(0xFFD4D4D4),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'OR',
                                  style: TextStyle(
                                    color: Color(0xFF020202),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.32,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Color(0xFFD4D4D4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return TextFieldWithTitle(
                                  text: 'Company Name',
                                  controller: _companyNameController,
                                  isRequired: true,
                                  haveError: _hasCompanyNameError,
                                  errorMessage: 'Company name must be filled',
                                  onChange: (value) => setState(() {
                                    if (value.isEmpty) {
                                      _hasCompanyNameError = true;
                                    } else {
                                      _hasCompanyNameError = false;
                                    }
                                  }),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TextFieldWithTitle(
                          text: 'Address 1',
                          controller: _firstAddressController,
                          isRequired: true,
                          haveError: _hasFirstAddressError,
                          errorMessage: 'Wrong Address',
                          onChange: (value) => setState(() {
                            if (value.isEmpty) {
                              _hasFirstAddressError = true;
                            } else {
                              _hasFirstAddressError = false;
                            }
                          }),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFieldWithTitle(
                      text: 'Address 2',
                      controller: _secondAddressController,
                    ),
                    const SizedBox(height: 14),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TextFieldWithTitle(
                          text: 'Country',
                          controller: _countryController,
                          isRequired: true,
                          haveError: _hasCountryError,
                          errorMessage: 'Wrong Country',
                          onChange: (value) => setState(() {
                            if (value.isEmpty) {
                              _hasCountryError = true;
                            } else {
                              _hasCountryError = false;
                            }
                          }),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 128,
                              child: TextFieldWithTitle(
                                text: 'City',
                                controller: _cityController,
                                isRequired: true,
                                haveError: _hasCityError,
                                errorMessage: 'Wrong City',
                                onChange: (value) => setState(() {
                                  if (value.isEmpty) {
                                    _hasCityError = true;
                                  } else {
                                    _hasCityError = false;
                                  }
                                }),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 80,
                              child: TextFieldWithTitle(
                                text: 'State',
                                controller: _stateController,
                                isRequired: true,
                                haveError: _hasStateError,
                                errorMessage: 'Wrong State',
                                onChange: (value) => setState(() {
                                  if (value.isEmpty) {
                                    _hasStateError = true;
                                  } else {
                                    _hasStateError = false;
                                  }
                                }),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 80,
                              child: TextFieldWithTitle(
                                text: 'Zip',
                                controller: _zipController,
                                isRequired: true,
                                haveError: _hasZipError,
                                keyboardType: TextInputType.number,
                                errorMessage: 'Wrong Zip',
                                onChange: (value) => setState(() {
                                  if (value.isEmpty) {
                                    _hasZipError = true;
                                  } else {
                                    _hasZipError = false;
                                  }
                                }),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TextFieldWithTitle(
                          text: 'Phone',
                          controller: _phoneController,
                          isRequired: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [formatter],
                          haveError: _hasPhoneError,
                          onChange: (value) => setState(() {
                            if (value.isEmpty) {
                              _hasPhoneError = true;
                            } else {
                              _hasPhoneError = false;
                            }
                          }),
                          errorMessage: 'Phone must be filled',
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return TextFieldWithTitle(
                          text: 'Email',
                          controller: _emailController,
                          isRequired: true,
                          keyboardType: TextInputType.emailAddress,
                          onChange: (value) => setState(
                            () => _hasEmailError = !EmailValidator.validate(value),
                          ),
                          errorMessage: 'Wrong email',
                          haveError: _hasEmailError,
                        );
                      },
                    ),
                    const SizedBox(height: 48),
                    CustomTextButton(
                      text: 'Create Address',
                      onPressed: _checkData,
                    ),
                    const SizedBox(height: 29),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _checkData() {
    if (_addressNameController.text.isEmpty) {
      _hasAddressNameError = true;
    }
    if (_firstAddressController.text.isEmpty) {
      _hasFirstAddressError = true;
    }
    if (!((_firstNameController.text.isNotEmpty && _lastNameController.text.isNotEmpty) ||
        _companyNameController.text.isNotEmpty)) {
      if (_firstNameController.text.isEmpty) {
        _hasFirstNameError = true;
      } else {
        _hasFirstNameError = false;
      }
      if (_lastNameController.text.isEmpty) {
        _hasLastNameError = true;
      } else {
        _hasLastNameError = false;
      }
      if (_companyNameController.text.isEmpty) {
        _hasCompanyNameError = true;
      }
    } else {
      _hasFirstNameError = false;
      _hasLastNameError = false;
      _hasCompanyNameError = false;
    }
    if (_countryController.text.isEmpty) {
      _hasCountryError = true;
    }
    if (_cityController.text.isEmpty) {
      _hasCityError = true;
    }
    if (_stateController.text.isEmpty) {
      _hasStateError = true;
    }
    if (_stateController.text.isEmpty) {
      _hasStateError = true;
    }
    if (_zipController.text.isEmpty) {
      _hasZipError = true;
    }
    if (_emailController.text.isEmpty) {
      _hasEmailError = true;
    }
    if (_phoneController.text.isEmpty || !_phoneController.text.startsWith('+')) {
      _hasPhoneError = true;
    }
    setState(() {});
  }
}
