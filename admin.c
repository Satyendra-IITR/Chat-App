/* call main function of Main.hs and pass port number and channel name */


#include <HsFFI.h>
#ifdef __GLASGOW_HASKELL__
// #include "main.h"
extern void __stginit_Safe(void);
#endif
#include <stdio.h>

int main(int argc, char *argv[])
{
    int i;
    hs_init(&argc, &argv);
#ifdef __GLASGOW_HASKELL__
    hs_add_root(__stginit_Safe);
#endif
    hs_exit();
   
  
  
  return 0;
}




