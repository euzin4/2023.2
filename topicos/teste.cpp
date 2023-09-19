#include <bits/stdc++.h>
 
using namespace std;
 
//vector <int> v;
int n,x;
 
int main()
{
    cin >> n;
    int v[n];
 
    for(int i=0;i<n-1;i++){
        cin >> x;
        //v.push_back(x);
        v[x-1]=x;
    }
    cout << "\n";
    if(v[0]!=1){
        cout << "1\n";
    }else{
        for(int i=1;i<n;i++){
            if(v[i] != v[i-1]+1){
                printf("%d",v[i-1]+1);
                break;
            }
        }
    }
}