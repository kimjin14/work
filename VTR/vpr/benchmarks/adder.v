module adder (
	top^a~0, top^a~1, top^a~2, top^a~3, top^a~4, top^a~5, top^a~6, top^a~7, 
	top^a~8, top^a~9, top^a~10, top^a~11, top^a~12, top^a~13, top^a~14, top^a~15, top^b~0, top^b~1, 
	top^b~2, top^b~3, top^b~4, top^b~5, top^b~6, top^b~7, top^b~8, top^b~9, top^b~10, top^b~11, 
	top^b~12, top^b~13, top^b~14, top^b~15, a[0], a[1], a[2], a[3], b[0], b[1], 
	b[2], b[3], cin[0], top^c~0, top^c~1, top^c~2, top^c~3, top^c~4, top^c~5, top^c~6, 
	top^c~7, top^c~8, top^c~9, top^c~10, top^c~11, top^c~12, top^c~13, top^c~14, top^c~15, top^d~0, 
	top^d~1, top^d~2, top^d~3, top^d~4, top^d~5, top^d~6, top^d~7, top^d~8, top^d~9, top^d~10, 
	top^d~11, top^d~12, top^d~13, top^d~14, top^d~15, sumout[0], sumout[1], sumout[2], sumout[3], cout[0]);

input top^a~0;
input top^a~1;
input top^a~2;
input top^a~3;
input top^a~4;
input top^a~5;
input top^a~6;
input top^a~7;
input top^a~8;
input top^a~9;
input top^a~10;
input top^a~11;
input top^a~12;
input top^a~13;
input top^a~14;
input top^a~15;
input top^b~0;
input top^b~1;
input top^b~2;
input top^b~3;
input top^b~4;
input top^b~5;
input top^b~6;
input top^b~7;
input top^b~8;
input top^b~9;
input top^b~10;
input top^b~11;
input top^b~12;
input top^b~13;
input top^b~14;
input top^b~15;
input a[0];
input a[1];
input a[2];
input a[3];
input b[0];
input b[1];
input b[2];
input b[3];
input cin[0];
output top^c~0;
output top^c~1;
output top^c~2;
output top^c~3;
output top^c~4;
output top^c~5;
output top^c~6;
output top^c~7;
output top^c~8;
output top^c~9;
output top^c~10;
output top^c~11;
output top^c~12;
output top^c~13;
output top^c~14;
output top^c~15;
output top^d~0;
output top^d~1;
output top^d~2;
output top^d~3;
output top^d~4;
output top^d~5;
output top^d~6;
output top^d~7;
output top^d~8;
output top^d~9;
output top^d~10;
output top^d~11;
output top^d~12;
output top^d~13;
output top^d~14;
output top^d~15;
output sumout[0];
output sumout[1];
output sumout[2];
output sumout[3];
output cout[0];
wire unconn;
assign unconn =((~ top^a~0) & top^a~0);
 assign top^c~0 = ( top^ADD~0-0[0] ) ;
 assign top^c~1 = ( top^ADD~0-0[1] ) ;
 assign top^c~2 = ( top^ADD~0-0[2] ) ;
 assign top^c~3 = ( top^ADD~0-0[3] ) ;
 assign top^c~4 = ( top^ADD~0-1[0] ) ;
 assign top^c~5 = ( top^ADD~0-1[1] ) ;
 assign top^c~6 = ( top^ADD~0-1[2] ) ;
 assign top^c~7 = ( top^ADD~0-1[3] ) ;
 assign top^c~8 = ( top^ADD~0-2[0] ) ;
 assign top^c~9 = ( top^ADD~0-2[1] ) ;
 assign top^c~10 = ( top^ADD~0-2[2] ) ;
 assign top^c~11 = ( top^ADD~0-2[3] ) ;
 assign top^c~12 = ( top^ADD~0-3[0] ) ;
 assign top^c~13 = ( top^ADD~0-3[1] ) ;
 assign top^c~14 = ( top^ADD~0-3[2] ) ;
 assign top^c~15 = ( top^ADD~0-3[3] ) ;
 assign top^d~0 = ( top^ADD~17-0[0] ) ;
 assign top^d~1 = ( top^ADD~17-0[1] ) ;
 assign top^d~2 = ( top^ADD~17-0[2] ) ;
 assign top^d~3 = ( top^ADD~17-0[3] ) ;
 assign top^d~4 = ( top^ADD~17-1[0] ) ;
 assign top^d~5 = ( top^ADD~17-1[1] ) ;
 assign top^d~6 = ( top^ADD~17-1[2] ) ;
 assign top^d~7 = ( top^ADD~17-1[3] ) ;
 assign top^d~8 = ( top^ADD~17-2[0] ) ;
 assign top^d~9 = ( top^ADD~17-2[1] ) ;
 assign top^d~10 = ( top^ADD~17-2[2] ) ;
 assign top^d~11 = ( top^ADD~17-2[3] ) ;
 assign top^d~12 = ( top^ADD~17-3[0] ) ;
 assign top^d~13 = ( top^ADD~17-3[1] ) ;
 assign top^d~14 = ( top^ADD~17-3[2] ) ;
 assign top^d~15 = ( top^ADD~17-3[3] ) ;


endmodule

