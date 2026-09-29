-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.hashimoto_shiftInvert_unbounded_example
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_isShiftInvert_unique
import Theorems.Thm_BookProof_HashimotoShiftInvert_hashimoto_shiftInvert_selects_friedrichs
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2UnboundedExample_isShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2Example_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2ExampleMatrix_unbounded
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution :
    IsShiftInvert ell2UnboundedExample 1 ell2ShiftInvert ∧
    ‖ell2ShiftInvert‖ ≤ 1 ∧ IsSelfAdjoint ell2ShiftInvert ∧
    (∀ u : ℓ²(ℕ, ℂ), Tendsto
      (fun m : ℕ => galerkinCompression ell2ShiftInvert ell2Basis m u) atTop
        (nhds (ell2ShiftInvert u))) ∧
    (∀ z : ℂ, z.im ≠ 0 → ∀ u : ℓ²(ℕ, ℂ), Tendsto
      (fun m : ℕ => resolvent (galerkinCompression ell2ShiftInvert ell2Basis m) z u) atTop
        (nhds (resolvent ell2ShiftInvert z u))) ∧
    (∀ (Dom' : Submodule ℂ (ℓ²(ℕ, ℂ))) (A' : Dom' →ₗ[ℂ] ℓ²(ℕ, ℂ)),
      IsShiftInvert A' 1 ell2ShiftInvert →
      Dom' = LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ))) ∧
    (∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
      C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖) := by

  obtain ⟨R, hR, hnorm, hsa, -, hstrong, hres, huniq⟩ :=
    hashimoto_shiftInvert_selects_friedrichs ell2Basis ell2ExampleMatrix ell2UnboundedExample
      ell2Example_isPositiveSelfAdjointExtension (γ := 1) one_pos
  have hReq : R = ell2ShiftInvert :=
    isShiftInvert_unique hR ell2UnboundedExample_isShiftInvert
  subst hReq
  refine ⟨hR, by simpa only [inv_one] using hnorm, hsa, hstrong, hres, ?_,
    ell2ExampleMatrix_unbounded⟩
  intro Dom' A' hA'
  exact (huniq Dom' A' hA').1
