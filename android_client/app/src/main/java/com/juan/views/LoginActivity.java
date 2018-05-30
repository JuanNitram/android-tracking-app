package com.juan.views;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.juan.apiCall.FetchDataListener;
import com.juan.apiCall.POSTAPIRequest;
import com.juan.apiCall.RequestQueueService;
import com.juan.proy_localizacion.R;

import org.json.JSONArray;
import org.json.JSONObject;

public class LoginActivity extends AppCompatActivity {

    private Button btnIniciar;
    private EditText edtCi;
    private EditText edtPassword;
    private Intent MainActivity;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        loadComponents();
        verifySession();

        btnIniciar.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                onClickIniciar();
            }
        });
    }

    private void verifySession(){
        SharedPreferences prefs = getSharedPreferences("userPreferences",Context.MODE_PRIVATE);
        String ci = prefs.getString("ci","");
        if(!TextUtils.isEmpty(ci)){
            initMain();
        }
    }

    private void loadComponents(){
        btnIniciar = findViewById(R.id.btnIniciar);
        edtCi = findViewById(R.id.edtCi);
        edtPassword = findViewById(R.id.edtPassword);
    }

    private void onClickIniciar(){
        if(TextUtils.isEmpty(edtCi.getText().toString())){
            Toast.makeText(getApplicationContext(),"Ingresar email!",Toast.LENGTH_SHORT).show();
        } else if(TextUtils.isEmpty(edtPassword.getText().toString())){
            Toast.makeText(getApplicationContext(),"Ingresar contraseña!",Toast.LENGTH_SHORT).show();
        }
        else {
            String ci = edtCi.getText().toString().trim();
            String password = edtPassword.getText().toString().trim();
            postApiCall(ci,password);
        }
    }

    private void initMain(){
        MainActivity = new Intent(this,MainActivity.class);
        startActivity(MainActivity);
        finish();
    }

    public void postApiCall(String ci, String password){
        try{
            //Create Instance of POSTAPIRequest and call it's
            //request() method
            POSTAPIRequest postapiRequest=new POSTAPIRequest();
            //Attaching only part of URL as base URL is given
            //in our POSTAPIRequest(of course that need to be same for all case)
            String url="login";
            JSONObject params=new JSONObject();
            try {
                //Creating POST body in JSON format
                //to send in POST request
                params.put("ci",ci);
                params.put("password",password);
                System.out.println("PARAMS: "+ params);
            }catch (Exception e){
                e.printStackTrace();
            }
            postapiRequest.request(LoginActivity.this,fetchPostResultListener,params,url);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private FetchDataListener fetchPostResultListener = new FetchDataListener() {
        @Override
        public void onFetchComplete(JSONObject data) {
            //Fetch Complete. Now stop progress bar  or loader
            //you started in onFetchStart
            RequestQueueService.cancelProgressDialog();
            try {
                //Now check result sent by our POSTAPIRequest class
                if (data != null) {
                    if (data.has("success")) {
                        int success = data.getInt("success");
                        if(success==1){
                            JSONObject response=data.getJSONObject("response");
                            if(response!=null) {
                                //Display the result
                                //Or, You can do whatever you need to
                                //do with the JSONObject
                                //resultTextView.setText(response.toString(4));
                               /* */
                                initMain();
                                JSONArray persona = response.getJSONArray("persona");
                                JSONObject p = persona.getJSONObject(0);

                                String ci = p.getString("ci");
                                String token = response.getString("token");
                                String nombre = p.getString("nombre");
                                String apellido = p.getString("apellido");
                                String email = p.getString("email");

                                SharedPreferences prefs = getSharedPreferences("userPreferences", Context.MODE_PRIVATE);
                                SharedPreferences.Editor editor = prefs.edit();
                                editor.putString("ci", ci);
                                editor.putString("token", token );
                                editor.putString("nombre", nombre);
                                editor.putString("apellido", apellido);
                                editor.putString("email", email);
                                editor.commit();

                                System.out.println("RESPONSE PERSONA: " + ci + " " + token + " " + nombre + " " + apellido + " ");
                            }
                        }else{
                            RequestQueueService.showAlert("Error! No data success", LoginActivity.this);
                        }
                    }
                } else {
                    RequestQueueService.showAlert("Error! No data fetched", LoginActivity.this);
                }
            }catch (Exception e){
                RequestQueueService.showAlert("Something went wrong", LoginActivity.this);
                e.printStackTrace();
            }
        }

        @Override
        public void onFetchFailure(String msg) {
            RequestQueueService.cancelProgressDialog();
            //Show if any error message is there called from POSTAPIRequest class
            RequestQueueService.showAlert(msg,LoginActivity.this);
        }

        @Override
        public void onFetchStart() {
            //Start showing progressbar or any loader you have
            RequestQueueService.showProgressDialog(LoginActivity.this);
        }
    };

}
