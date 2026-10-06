-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.eq_zero_of_energy_zero
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin 4 → ℝ} (hmass : 0 ≤ minkSq p) (h0 : p 0 = 0) :
    ∀ i, p i = 0 := by

  have hle : p 1 ^ 2 + p 2 ^ 2 + p 3 ^ 2 ≤ 0 := by
    simp only [minkSq, h0] at hmass
    nlinarith [hmass]
  have h1 : p 1 = 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2), sq_nonneg (p 3)]
  have h2 : p 2 = 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2), sq_nonneg (p 3)]
  have h3 : p 3 = 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2), sq_nonneg (p 3)]
  intro i
  fin_cases i
  · simpa using h0
  · simpa using h1
  · simpa using h2
  · simpa using h3
