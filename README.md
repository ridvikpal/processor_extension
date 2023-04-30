# processor_extension
## IT IS AN ACADEMIC OFFENSE TO COPY CODE. THIS IS SIMPLY FOR REFERENCE
Working Code for ECE243 Lab 8 (Winter 2023) at the University of Toronto. The main code is in Verilog and can be simulated in Modelsim. The goal is to extend the simple processor from lab 7 to support all of the following instructions:
![image](https://user-images.githubusercontent.com/105998663/235357382-53db1cf8-bf32-4236-b0fc-cfe14912a4d8.png)
![image](https://user-images.githubusercontent.com/105998663/235357387-cf4fc2c5-72d3-4cef-8c68-eb97bdde5726.png)
![image](https://user-images.githubusercontent.com/105998663/235357398-15d8aaa1-4c1b-4fe7-ae90-bd9e21f348fb.png)

These instructions can be loaded into a .mif file with the help of the provided (created by Professor Jonathon Rose) sbasm.py python compiler script that will input a .s file and write to a .mif file. The processor reads the instructions to execute from the .mif file. Please see the attached PDF for more information. A schematic of how the enhanced processor works is as follows:

![image](https://user-images.githubusercontent.com/105998663/235357463-ffa69cc2-1a84-475d-9a01-1b62fae3f618.png)
![image](https://user-images.githubusercontent.com/105998663/235357470-08e1c78d-dfce-460d-a09e-70fca090670b.png)
