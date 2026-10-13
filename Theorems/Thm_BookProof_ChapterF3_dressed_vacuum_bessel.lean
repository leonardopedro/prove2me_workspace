-- Generated from ChapterF3.lean — 
theorem BookProof.ChapterF3.dressed_vacuum_bessel {ι : Type*} (x : ι → E') (hx : Orthonormal ℂ x)
    (v : E') (hv : ‖v‖ = 1) (s : Finset ι) :
    ∑ j ∈ s, ‖inner (𝕜 := ℂ) (x j) v‖ ^ 2 ≤ 1 := by sorry
