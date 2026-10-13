-- Generated from ChapterQgVielbeinModeInstance.lean — 
theorem BookProof.QgVielbeinModeInstance.qgLattice_ext_core (W : WallPot) (sig : VMode L → ℝ) (hsig : ∀ a, 1 ≤ sig a) (g : ℝ)
    (p : secCore (ι := VMode L)) :
    (secData W (qgLatticeModes L sig hsig g)).ext
        ⟨(p : Sec (VMode L)), (secData W (qgLatticeModes L sig hsig g)).gc.le p.2⟩
      = secHam W (qgLatticeModes L sig hsig g) p := by sorry
