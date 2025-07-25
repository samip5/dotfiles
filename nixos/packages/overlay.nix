{ inputs, system, ... }:
final: prev: {
   nheko = prev.nheko.override {
        curl = prev.curlHTTP3;
        coeurl = prev.coeurl.override {
          curl = prev.curlHTTP3;
        };
   };
}
