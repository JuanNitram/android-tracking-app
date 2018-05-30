package com.juan.views;

import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import com.juan.proy_localizacion.R;
import com.juan.services.GPSService;


public class MainActivity extends AppCompatActivity {
    private TextView txvCi, txvNombre,txvApellido,txvEmail;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if(isMyServiceRunning(GPSService.class)){
            Intent i = new Intent(this, GPSService.class);
            stopService(i);
        }

        startService(new Intent(this, GPSService.class));

        loadComponents();
        loadData();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu){
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item){
        int id = item.getItemId();

        if(id == R.id.itemCerrar){
            SharedPreferences prefs = getSharedPreferences("userPreferences", Context.MODE_PRIVATE);
            SharedPreferences.Editor editor = prefs.edit();
            editor.putString("ci", "");
            editor.putString("token", "" );
            editor.putString("nombre", "");
            editor.putString("apellido", "");
            editor.putString("email", "");
            editor.commit();
            initLogin();
        }

        if(id == R.id.gpsActivity){
            startActivity(new Intent(this,GPSActivity.class));
            finish();
        }

        return true;
    }

    private boolean isMyServiceRunning(Class<?> GPSService) {
        ActivityManager manager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningServiceInfo service : manager.getRunningServices(Integer.MAX_VALUE)) {
            if (GPSService.class.getName().equals(service.service.getClassName())) {
                return true;
            }
        }
        return false;
    }


    private void initLogin(){
        Intent login = new Intent(this, LoginActivity.class);
        startActivity(login);
        finish();
    }

    private void loadComponents(){
        txvCi = findViewById(R.id.txvCi);
        txvNombre = findViewById(R.id.txvNombre);
        txvApellido = findViewById(R.id.txvApellido);
        txvEmail = findViewById(R.id.txvEmail);
    }

    private void loadData(){
        SharedPreferences prefs = getSharedPreferences("userPreferences", Context.MODE_PRIVATE);
        String ci = prefs.getString("ci","");
        String nombre = prefs.getString("nombre","");
        String apellido = prefs.getString("apellido","");
        String email = prefs.getString("email","");
        txvCi.setText(ci);
        txvNombre.setText(nombre);
        txvApellido.setText(apellido);
        txvEmail.setText(email);
    }


    /*
    private void getApiCall(){
        try{
            //Create Instance of GETAPIRequest and call it's
            //request() method
            GETAPIRequest getapiRequest=new GETAPIRequest();
            //Attaching only part of URL as base URL is given
            //in our GETAPIRequest(of course that need to be same for all case)
            String url="webapi.php?userId=1";
            getapiRequest.request(MainActivity.this,fetchGetResultListener,url);
            Toast.makeText(MainActivity.this,"GET API called",Toast.LENGTH_SHORT).show();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //Implementing interfaces of FetchDataListener for GET api request
    FetchDataListener fetchGetResultListener=new FetchDataListener() {
        @Override
        public void onFetchComplete(JSONObject data) {
            //Fetch Complete. Now stop progress bar  or loader
            //you started in onFetchStart
            RequestQueueService.cancelProgressDialog();
            try {
                //Now check result sent by our GETAPIRequest class
                if (data != null) {
                    if (data.has("success")) {
                        int success = data.getInt("success");
                        if(success==1){
                            JSONObject response=data.getJSONObject("response");
                            if(response!=null) {
                                //Display the result
                                //Or, You can do whatever you need to
                                //do with the JSONObject
                                resultTextView.setText(response.toString(4));
                            }
                        }else{
                            RequestQueueService.showAlert("Error! No data fetched", MainActivity.this);
                        }
                    }
                } else {
                    RequestQueueService.showAlert("Error! No data fetched", MainActivity.this);
                }
            }catch (Exception e){
                RequestQueueService.showAlert("Something went wrong", MainActivity.this);
                e.printStackTrace();
            }
        }

        @Override
        public void onFetchFailure(String msg) {
            RequestQueueService.cancelProgressDialog();
            //Show if any error message is there called from GETAPIRequest class
            RequestQueueService.showAlert(msg,MainActivity.this);
        }

        @Override
        public void onFetchStart() {
            //Start showing progressbar or any loader you have
            RequestQueueService.showProgressDialog(MainActivity.this);
        }
    };
    */

}
