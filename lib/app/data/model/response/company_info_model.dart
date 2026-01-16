class CompanyInfo {
  Data? data;

  CompanyInfo({this.data});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  String? companyWebsite;
  String? companyCity;
  String? companyState;
  String? companyCountryCode;
  String? companyZipCode;
  String? companyAddress;

  Data(
      {this.companyName,
      this.companyEmail,
      this.companyPhone,
      this.companyWebsite,
      this.companyCity,
      this.companyState,
      this.companyCountryCode,
      this.companyZipCode,
      this.companyAddress});

  Data.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    companyWebsite = json['company_website'];
    companyCity = json['company_city'];
    companyState = json['company_state'];
    companyCountryCode = json['company_country_code'];
    companyZipCode = json['company_zip_code'];
    companyAddress = json['company_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['company_email'] = this.companyEmail;
    data['company_phone'] = this.companyPhone;
    data['company_website'] = this.companyWebsite;
    data['company_city'] = this.companyCity;
    data['company_state'] = this.companyState;
    data['company_country_code'] = this.companyCountryCode;
    data['company_zip_code'] = this.companyZipCode;
    data['company_address'] = this.companyAddress;
    return data;
  }
}