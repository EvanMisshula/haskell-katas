{ mkDerivation, array, base, ChasingBottoms, criterion, deepseq
, ghc-prim, HUnit, QuickCheck, random, stdenv, test-framework
, test-framework-hunit, test-framework-quickcheck2, transformers
}:
mkDerivation {
  pname = "containers";
  version = "0.5.11.0";
  sha256 = "58cd226ad5a147b12240f854a1fbadf809fd56cb9532123d60c1b23d13e04948";
  revision = "3";
  editedCabalFile = "1617q21cvkkjcqq8yrir5immxpvvxjs5lcc9qrdzfhkl0lvp7b98";
  libraryHaskellDepends = [ array base deepseq ghc-prim ];
  testHaskellDepends = [
    array base ChasingBottoms deepseq ghc-prim HUnit QuickCheck
    test-framework test-framework-hunit test-framework-quickcheck2
    transformers
  ];
  benchmarkHaskellDepends = [
    base criterion deepseq ghc-prim random transformers
  ];
  jailbreak = true;
  doCheck = false;
  description = "Assorted concrete container types";
  license = stdenv.lib.licenses.bsd3;
}
