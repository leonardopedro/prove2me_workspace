-- Generated from ChapterQgContinuumModeInstance.lean — 
theorem BookProof.QgContinuumModeInstance.qgContinuum_ext_core (W : WallPot) (g : ℝ) (p : secCore (ι := CMode)) :
    (secData W (qgContinuumModes g)).ext
        ⟨(p : Sec CMode), (secData W (qgContinuumModes g)).gc.le p.2⟩
      = secHam W (qgContinuumModes g) p := by sorry
