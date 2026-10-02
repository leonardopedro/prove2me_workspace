-- Generated from ChapterStoneGroup.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.yosida_inner
import Mathlib
import Definitions.Def_ChapterStoneGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_sub
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_yosida_zero
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_inner_res
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℝ) (y z : H) :
    ⟪ T.yosida n y, z ⟫_ℂ = ⟪ y, T.yosida n z ⟫_ℂ := by

  rcases eq_or_ne n 0 with rfl | hn
  · simp
  have hn' : -n ≠ 0 := neg_ne_zero.mpr hn
  have e1 : ∀ w v : H, ⟪ T.resCLM (-n) w, v ⟫_ℂ = ⟪ w, T.resCLM n v ⟫_ℂ := by
    intro w v
    have := T.inner_res hn' w v
    simpa using this
  have e2 : ∀ w v : H, ⟪ T.resCLM n w, v ⟫_ℂ = ⟪ w, T.resCLM (-n) v ⟫_ℂ := by
    intro w v
    have := T.inner_res hn w v
    simpa using this
  have hres : T.resCLM n z - T.resCLM (-n) z
      = (((n : ℂ) - ((-n : ℝ) : ℂ)) * Complex.I) • T.resCLM n (T.resCLM (-n) z) :=
    T.res_sub hn hn' z
  have hz : T.resCLM n z
      = T.resCLM (-n) z + ((2 * (n : ℂ)) * Complex.I) • T.resCLM n (T.resCLM (-n) z) := by
    have := hres
    push_cast at this ⊢
    linear_combination (norm := module) this
  rw [yosida_apply, yosida_apply, inner_add_left, inner_add_right, inner_smul_left,
    inner_smul_left, inner_smul_right, inner_smul_right]
  rw [e1 y z, e2 (T.resCLM (-n) y) z, e1 y (T.resCLM (-n) z), hz]
  rw [inner_add_right, inner_smul_right]
  simp only [map_pow, map_mul, Complex.conj_I, Complex.conj_ofReal]
  ring
