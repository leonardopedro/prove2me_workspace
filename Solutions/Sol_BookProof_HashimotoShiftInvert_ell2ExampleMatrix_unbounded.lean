-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.ell2ExampleMatrix_unbounded
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_preim_eq
import Theorems.Thm_BookProof_HashimotoShiftInvert_invShiftOperator_apply
import Theorems.Thm_BookProof_HashimotoShiftInvert_norm_single_one
import Theorems.Thm_ell2Basis_apply
import Theorems.Thm_ell2ShiftInvert_injective
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (C : ℝ) :
    ∃ x : finiteModeDomain ell2Basis, C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖ := by

  obtain ⟨k, hk⟩ := exists_nat_gt C
  have hmem : (lp.single 2 k (1 : ℂ) : ℓ²(ℕ, ℂ)) ∈ finiteModeDomain ell2Basis := by
    rw [← ell2Basis_apply]
    exact Submodule.subset_span ⟨k, rfl⟩
  refine ⟨⟨lp.single 2 k (1 : ℂ), hmem⟩, ?_⟩
  have hrange : (lp.single 2 k (1 : ℂ) : ℓ²(ℕ, ℂ))
      ∈ LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)) :=
    finiteModeDomain_le_range hmem
  have hpre : preim ell2ShiftInvert ⟨lp.single 2 k (1 : ℂ), hrange⟩
      = ((k : ℂ) + 1) • lp.single 2 k (1 : ℂ) :=
    preim_eq _ ell2ShiftInvert_injective _ (ell2ShiftInvert_smul_single k)
  have hval : ell2ExampleMatrix ⟨lp.single 2 k (1 : ℂ), hmem⟩
      = (k : ℂ) • lp.single 2 k (1 : ℂ) := by
    change ell2UnboundedExample ⟨lp.single 2 k (1 : ℂ), hrange⟩ = _
    rw [ell2UnboundedExample, invShiftOperator_apply, hpre]
    push_cast
    module
  rw [hval, norm_smul, norm_single_one]
  simp only [mul_one, Complex.norm_natCast]
  exact hk
