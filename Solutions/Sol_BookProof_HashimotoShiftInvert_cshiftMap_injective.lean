-- Generated from ChapterComplexShiftCore.lean — solution of BookProof.HashimotoShiftInvert.cshiftMap_injective
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Theorems.Thm_BookProof_HashimotoShiftInvert_norm_cshiftMap_ge
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    {γ : ℂ} (hγ : γ.im ≠ 0) : Function.Injective (cshiftMap A γ) := by

  intro x y hxy
  have h : |γ.im| * ‖((x - y : Dom) : F)‖ ≤ ‖cshiftMap A γ (x - y)‖ := norm_cshiftMap_ge hsym _ _
  rw [map_sub, hxy, sub_self, norm_zero] at h
  have hpos : 0 < |γ.im| := abs_pos.mpr hγ
  have hx : ‖((x - y : Dom) : F)‖ = 0 :=
    le_antisymm (by nlinarith [norm_nonneg ((x - y : Dom) : F)]) (norm_nonneg _)
  have hz : x - y = 0 := Subtype.ext (by simpa using (by simpa using hx : ((x - y : Dom) : F) = 0))
  exact sub_eq_zero.mp hz
