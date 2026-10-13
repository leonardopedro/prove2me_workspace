-- Generated from ChapterQgSymmetricSector.lean — 
theorem BookProof.QgSymmetricSector.qgFull_dGamma_esa (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore qgSecSpace (secCore (ι := GMode))
        (secCore (ι := GMode)) n))
      (dGammaCoreOp qgSecSpace (secCore (ι := GMode)) (qgFullOp W g)
        (secCore (ι := GMode))) := by sorry
