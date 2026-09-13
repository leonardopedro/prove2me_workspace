-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.hashimoto_multishift_unbounded_example
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_opNorm_le
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftInvertC_determines
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftInvertC_resolvent_identity
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftInvertC_commute
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftInvertC_comp_one_sub
import Theorems.Thm_BookProof_HashimotoShiftInvert_sirkDen_rkVec
import Theorems.Thm_BookProof_HashimotoShiftInvert_diagCLMC_apply
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2Example_symmetricOn
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2Resolvent_isShiftInvertC
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




















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]







variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]








open scoped InnerProductSpace ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ X : ℕ → ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ),
      (∀ j u n, ((X j u : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n = (u : ℕ → ℂ) n / (γ j - (n : ℂ))) ∧
      (∀ j, IsShiftInvertC ell2UnboundedExample (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ (ℓ²(ℕ, ℂ)) - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) ell2Basis n u) atTop
        (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (ℓ²(ℕ, ℂ))) (A' : Dom' →ₗ[ℂ] ℓ²(ℕ, ℂ)),
        IsShiftInvertC A' (γ j) (X j) →
        Dom' = LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ))) ∧
      (∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖) := by

  refine ⟨fun j => ell2Resolvent (hγ j), ?_, fun j => ell2Resolvent_isShiftInvertC (hγ j), ?_, ?_,
    ?_, ?_, ?_, fun j u => galerkinCompression_tendsto _ ell2Basis u, ?_,
    ell2ExampleMatrix_unbounded⟩
  · intro j u n
    have h1 : ((ell2Resolvent (hγ j) u : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n
        = resCoeff (γ j) n * (u : ℕ → ℂ) n := diagCLMC_apply (resCoeff_norm_le (hγ j)) u n
    rw [h1, resCoeff, one_div, inv_mul_eq_div]
  · intro j
    exact (ell2Resolvent_isShiftInvertC (hγ j)).opNorm_le ell2Example_symmetricOn (hγ j)
  · intro j k u
    exact shiftInvertC_resolvent_identity (ell2Resolvent_isShiftInvertC (hγ j))
      (ell2Resolvent_isShiftInvertC (hγ k)) u
  · intro j k
    exact shiftInvertC_commute (ell2Resolvent_isShiftInvertC (hγ j))
      (ell2Resolvent_isShiftInvertC (hγ k))
  · intro j m
    exact shiftInvertC_comp_one_sub (ell2Resolvent_isShiftInvertC (hγ j))
      (ell2Resolvent_isShiftInvertC (hγ m))
  · intro m v k
    exact sirkDen_rkVec m (fun j => ell2Resolvent_isShiftInvertC (hγ j)) v k
  · intro j Dom' A' hA'
    obtain ⟨hdom, -⟩ := shiftInvertC_determines hA' (ell2Resolvent_isShiftInvertC (hγ j))
    exact hdom
