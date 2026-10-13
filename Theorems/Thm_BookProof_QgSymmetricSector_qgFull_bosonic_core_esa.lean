-- Generated from ChapterQgSymmetricSector.lean — 
theorem BookProof.QgSymmetricSector.qgFull_bosonic_core_esa (W : WallPot) (g : ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj qgSecSpace n)
        (sectorCore qgSecSpace (secCore (ι := GMode)) (secCore (ι := GMode)) n))
      (bosonicCoreOp qgSecSpace (secCore (ι := GMode)) (qgFullOp W g)
        (secCore (ι := GMode)) n) := by sorry
