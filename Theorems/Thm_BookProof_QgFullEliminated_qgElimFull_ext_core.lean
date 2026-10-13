-- Generated from ChapterQgFullEliminated.lean — 
theorem BookProof.QgFullEliminated.qgElimFull_ext_core (W : WallPot) (g : ℝ) (p : secCore (ι := EGMode)) :
    (secData W (qgElimFullModes g)).ext
        ⟨(p : Sec EGMode), (secData W (qgElimFullModes g)).gc.le p.2⟩
      = secHam W (qgElimFullModes g) p := by sorry
