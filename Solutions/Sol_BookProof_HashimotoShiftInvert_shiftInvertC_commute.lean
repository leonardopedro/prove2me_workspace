-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.shiftInvertC_commute
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_isShiftInvertC_unique
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftInvertC_resolvent_identity
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ δ : ℂ} {X Y : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hY : IsShiftInvertC A δ Y) : X ∘L Y = Y ∘L X := by

  rcases eq_or_ne γ δ with rfl | hne
  · rw [isShiftInvertC_unique hX hY]
  · have h1 : ∀ u, X u - Y u = (δ - γ) • X (Y u) :=
      shiftInvertC_resolvent_identity hX hY
    have h2 : ∀ u, Y u - X u = (γ - δ) • Y (X u) :=
      shiftInvertC_resolvent_identity hY hX
    have hd : (δ - γ) ≠ 0 := sub_ne_zero.mpr (Ne.symm hne)
    ext u
    have h3 : (δ - γ) • X (Y u) = (δ - γ) • Y (X u) := by
      have hneg : (δ - γ) • X (Y u) = -((γ - δ) • Y (X u)) := by
        rw [← h1 u, ← h2 u]; abel
      rw [hneg]; module
    exact smul_right_injective F hd h3
