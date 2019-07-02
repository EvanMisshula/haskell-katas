{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, base-unicode-symbols, bytestring
      , containers, containers-unicode-symbols, hspec, mtl, QuickCheck
      , stdenv
      } :
  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

   h = haskellPackages.extend (self: super: {
        containers-unicode-symbols =
            self.callPackage ./containers-unicode-symbols.nix { };
  });

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in
{
  mkShell {
   buildInputs = [ (h.ghcWithPackages (p: [p.containers-unicode-symbols])) ];
   }

   mkDerivation {
        pname = "katas";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        buildTools =  [
         haskellPackages.cabal-install
         haskellPackages.ghcid
            ];
        executableHaskellDepends = [ base ];
          
        testHaskellDepends = [
          base base-unicode-symbols bytestring containers
          containers-unicode-symbols hspec mtl QuickCheck
        ];
        homepage = "https://github.com/adomokos/hashmir#readme";
        license = "unknown";
        hydraPlatforms = stdenv.lib.platforms.none;
      };



  if pkgs.lib.inNixShell then drv.env else drv
}  
