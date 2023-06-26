package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.Scanner;

public class Cordenates {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        while(true) {
            String line = sc.nextLine();
             String[] longLat = line.split(",");
             String coor = "LatLng(" + longLat[1] + ", " + longLat[0] + "),";
             System.out.println(coor);

        }
    }
}
