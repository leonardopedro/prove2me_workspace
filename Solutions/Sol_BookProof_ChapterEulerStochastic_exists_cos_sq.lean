-- Generated from ChapterEulerStochastic.lean — solution of BookProof.ChapterEulerStochastic.exists_cos_sq
import Mathlib
import Definitions.Def_ChapterEulerStochastic
open BookProof.ChapterEulerStochastic



open scoped Matrix BigOperators

set_option maxHeartbeats 1000000 in
theorem solution {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1) :
    ∃ a : ℝ, Real.cos a ^ 2 = p := by

      exact ⟨ Real.arccos ( Real.sqrt p ), by rw [ Real.cos_arccos ] <;> nlinarith [
                                              Real.mul_self_sqrt hp0 ] ⟩
