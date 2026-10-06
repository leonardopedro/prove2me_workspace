-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.exists_sin_sq
import Mathlib
import Definitions.Def_ChapterEulerNState
import Theorems.Thm_BookProof_ChapterEulerNState_exists_cos_sq
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution {q : ℝ} (h0 : 0 ≤ q) (h1 : q ≤ 1) :
    ∃ θ : ℝ, Real.sin θ ^ 2 = q := by

  obtain ⟨θ, hθ⟩ := exists_cos_sq h0 h1
  refine ⟨θ + Real.pi / 2, ?_⟩
  rw [Real.sin_add]
  simp [Real.cos_pi_div_two, Real.sin_pi_div_two]
  nlinarith [hθ]
