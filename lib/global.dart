

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fresh_store_ui/network/models/address.dart';
import 'package:fresh_store_ui/utils/calculations.dart';

import 'network/models/cart.dart';
import 'network/models/category.dart';
import 'network/models/main_data.dart';
import 'network/models/product.dart';
import 'network/models/timeslot.dart';
import 'network/models/user.dart';
import 'network/models/banner.dart' as banner;

class Global {

  static User? user;

  static List<banner.Banner> banners = [];
  static List<Category> categories = [];

  static TimeSlot? timeSlot;

  static MainData?  mainData;

  static ValueNotifier<List<Cart>> myCartItems = ValueNotifier([]);
  static ValueNotifier<List<Address>> myAddress = ValueNotifier([
  ]);

  static addCartItem(Product product, noOfItems){
    List<Cart> carts = myCartItems.value;
    Cart? cart = carts.firstWhereOrNull((element) => element.product.id ==product.id);

    if(cart!=null){
      myCartItems.value.remove(cart);
      cart = cart.copyWith(
        noOfItems: double.parse(noOfItems.toString())
      );
    }else{
      cart = Cart(
        product: product, 
        amount: double.parse(Calculations.calculateDiscountedPrice(product.price[0].productPrice, product.discount)), 
        noOfItems: double.parse(noOfItems.toString()), 
        productType: product.price[0].productType
      );
    }
    myCartItems.value.add(cart);
    myCartItems.notifyListeners();
  }

  static calculateTotalItems(cartItems){
    double totalItems = 0;
    for (var data in cartItems) {
      totalItems += data.noOfItems;
    }
    return totalItems.toInt();
  }

  static calculateTotalAmount(cartItems){
    double totalPrice = 0.0;
    for (var data in cartItems) {
      totalPrice += data.amount*data.noOfItems;
    }
    return totalPrice;
  }

  static String aboutus = "<html><head><title>About SK Paper Products</title></head><body><div><p><strong>About SK Paper Products</strong></p><br><p><strong>Introduction</strong></p><br><p>Welcome to SK Paper Products! At SK Paper Products, we are committed to delivering quality products while ensuring your privacy and security. This page outlines our approach to handling your personal information and your experience when using our website and online delivery services.</p><p><strong>Our Mission</strong></p><br><p>Our mission is to provide you with exceptional products and convenient online shopping experiences. We strive to protect your personal information and provide transparency in our practices.</p><p><strong>What We Collect</strong></p><p>We collect various types of information when you interact with us:</p><ul><br><li>Your contact details, including your email address and phone number</li><li>Your shipping address for delivery purposes</li><li>Your secure payment information</li><li>Your website usage data and browsing history</li></ul><br><p><strong>Our Use of Information</strong></p><p>We utilize your information in the following ways:</p><ul><li>Processing orders efficiently and delivering products promptly</li><li>Communication regarding your orders and our offerings</li><li>Improving our website and online delivery services</li><li>Sharing promotional materials and offers</li></ul><br><p><strong>Your Privacy Matters</strong></p><p>We value your privacy and security:</p><p>We work diligently to protect your information and employ secure servers for storage. When transmitting data online, we utilize encryption methods for your protection.</p><br><p><strong>Your Rights and Choices</strong></p><p>Your control over your information:</p><p>You have the right to access, update, or request deletion of your personal information. Furthermore, you can choose to opt out of receiving marketing materials at any time.</p><br><p><strong>Contact Us</strong></p><p>If you have any questions or concerns regarding this policy, please reach out to us:</p><ul><li>Email</li><li>Phone</li></ul><br><p><strong>Stay Informed</strong></p></div></body></html>";

  static String termsAndConditions = "<html><head><title>SK Paper Products Terms and Conditions</title></head><body><div><p><strong>SK Paper Products Terms and Conditions</strong></p><br><p><strong>Agreement to Terms</strong></p><br><p>Welcome to SK Paper Products! These Terms and Conditions outline the rules and regulations for the use of our website and services. By accessing and using our website, you accept and agree to be bound by these terms. If you disagree with any part of these terms, please do not use our website.</p><p><strong>Use of Our Services</strong></p><br><p>When using our services, you agree to provide accurate and complete information. You also agree not to engage in any activity that may disrupt or interfere with our website's functionality or security.</p><p><strong>Intellectual Property</strong></p><p>The content, trademarks, and intellectual property on our website are owned by SK Paper Products. You may not use, reproduce, or distribute our content without our explicit consent.</p><br><p><strong>Privacy Policy</strong></p><p>Your privacy is important to us. Our Privacy Policy outlines how we collect, use, and protect your personal information. By using our services, you consent to our Privacy Policy.</p><br><p><strong>Limitation of Liability</strong></p><p>We do our best to provide accurate and up-to-date information, but we make no warranties or representations about the accuracy or completeness of the content on our website. We are not liable for any losses or damages that may arise from using our website.</p><br><p><strong>Indemnification</strong></p><p>You agree to indemnify and hold SK Paper Products and its affiliates harmless from any claims, actions, or demands resulting from your use of our website or violation of these terms.</p><br><p><strong>Changes to Terms</strong></p><p>We may update these terms periodically. It's your responsibility to review these terms regularly. Your continued use of our website after changes are posted indicates your acceptance of the updated terms.</p><br><p><strong>Contact Us</strong></p><p>If you have any questions or concerns about these terms, please reach out to us:</p><ul><li>Email</li><li>Phone</li></ul><br><p><strong>Effective Date</strong></p><p>These Terms and Conditions are effective as of August 2, 2023. Please check back for updates.</p></div></body></html>";

}