package com.example.myapplication

import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.animation.ObjectAnimator
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.View
import android.view.animation.AccelerateDecelerateInterpolator
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.animation.doOnEnd

class SplashActivity : AppCompatActivity() {
    
    private lateinit var logoImageView: ImageView
    private lateinit var appNameTextView: TextView
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
        
        logoImageView = findViewById(R.id.logo_imageview)
        appNameTextView = findViewById(R.id.app_name_textview)
        
        // Start animations
        animateSplash()
    }
    
    private fun animateSplash() {
        // Logo scale and fade in animation
        logoImageView.apply {
            scaleX = 0.5f
            scaleY = 0.5f
            alpha = 0f
        }
        
        appNameTextView.apply {
            alpha = 0f
            translationY = 50f
        }
        
        // Animate logo
        logoImageView.animate()
            .scaleX(1f)
            .scaleY(1f)
            .alpha(1f)
            .setDuration(800)
            .setInterpolator(AccelerateDecelerateInterpolator())
            .withEndAction {
                // Animate app name after logo
                appNameTextView.animate()
                    .alpha(1f)
                    .translationY(0f)
                    .setDuration(600)
                    .setInterpolator(AccelerateDecelerateInterpolator())
                    .start()
            }
            .start()
        
        // Navigate to MainActivity after delay
        Handler(Looper.getMainLooper()).postDelayed({
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
            overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
            finish()
        }, 2500)
    }
}
