-- Generated from ChapterEulerNState.lean — solution of BookProof.ChapterEulerNState.exists_cos_sq
import Mathlib
import Definitions.Def_ChapterEulerNState
open BookProof.ChapterEulerNState



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution {q : ℝ} (h0 : 0 ≤ q) (h1 : q ≤ 1) :
    ∃ θ : ℝ, Real.cos θ ^ 2 = q :=
  ⟨Real.arccos (Real.sqrt q), by
      rw [Real.cos_arccos] <;> nlinarith [Real.mul_self_sqrt h0]⟩
