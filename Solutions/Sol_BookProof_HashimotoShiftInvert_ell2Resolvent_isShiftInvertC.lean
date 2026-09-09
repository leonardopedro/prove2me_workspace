-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.ell2Resolvent_isShiftInvertC
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_isShiftInvertC_of_rightInverse
import Theorems.Thm_BookProof_HashimotoShiftInvert_sub_natCast_ne_zero
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2Example_symmetricOn
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2ShiftInvert_resolventPre
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}




















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]







variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]








open scoped InnerProductSpace ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {γ : ℂ} (hγ : γ.im ≠ 0) :
    IsShiftInvertC ell2UnboundedExample γ (ell2Resolvent hγ) := by

  refine isShiftInvertC_of_rightInverse ell2Example_symmetricOn hγ ?_
  intro u
  have hR : ell2ShiftInvert (ell2ResolventPre hγ u) = ell2Resolvent hγ u :=
    ell2ShiftInvert_resolventPre hγ u
  have hmem : ell2Resolvent hγ u
      ∈ LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)) :=
    ⟨ell2ResolventPre hγ u, hR⟩
  refine ⟨hmem, ?_⟩
  have hpre : preim ell2ShiftInvert ⟨ell2Resolvent hγ u, hmem⟩ = ell2ResolventPre hγ u :=
    preim_eq _ ell2ShiftInvert_injective _ hR
  have hA : ell2UnboundedExample ⟨ell2Resolvent hγ u, hmem⟩
      = ell2ResolventPre hγ u - (1 : ℂ) • (ell2Resolvent hγ u) := by
    rw [ell2UnboundedExample, invShiftOperator_apply, hpre]
    norm_num
  rw [cshiftMap_apply]
  change γ • (ell2Resolvent hγ u) - ell2UnboundedExample ⟨ell2Resolvent hγ u, hmem⟩ = u
  rw [hA]
  apply lp.ext
  funext n
  have hne : γ - (n : ℂ) ≠ 0 := sub_natCast_ne_zero hγ n
  simp only [lp.coeFn_sub, lp.coeFn_smul, Pi.sub_apply, Pi.smul_apply, smul_eq_mul,
    ell2Resolvent, ell2ResolventPre, diagCLMC_apply, resCoeff, preCoeff]
  field_simp
  ring
