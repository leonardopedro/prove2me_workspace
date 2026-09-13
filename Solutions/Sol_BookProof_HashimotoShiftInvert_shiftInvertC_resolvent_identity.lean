-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.shiftInvertC_resolvent_identity
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_shift_apply
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
    (hX : IsShiftInvertC A γ X) (hY : IsShiftInvertC A δ Y) (u : F) :
    X u - Y u = (δ - γ) • X (Y u) := by

  have hy : δ • Y u - A ⟨Y u, hY.mem u⟩ = u := hY.shift_apply u
  have hsplit : cshiftMap A γ ⟨Y u, hY.mem u⟩ + (δ - γ) • Y u = u := by
    rw [cshiftMap_apply]
    have hrw : γ • ((⟨Y u, hY.mem u⟩ : Dom) : F) - A ⟨Y u, hY.mem u⟩ + (δ - γ) • Y u
        = δ • Y u - A ⟨Y u, hY.mem u⟩ := by
      module
    rw [hrw, hy]
  have hXu : X u = Y u + (δ - γ) • X (Y u) := by
    conv_lhs => rw [← hsplit]
    rw [map_add, map_smul, hX.1 ⟨Y u, hY.mem u⟩]
  rw [hXu]; abel
