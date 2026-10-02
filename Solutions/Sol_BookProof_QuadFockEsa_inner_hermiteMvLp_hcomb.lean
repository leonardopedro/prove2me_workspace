-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.inner_hermiteMvLp_hcomb
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_QuadFockEsa_pgLp_hcomb
open BookProof.QuadFockEsa




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (f : (Fin d →₀ ℕ) →₀ ℂ) (β : Fin d →₀ ℕ) :
    (inner ℂ (hermiteMvLp β) (pgLp (hcomb f)) : ℂ) = f β := by

  classical
  rw [pgLp_hcomb, inner_sum]
  have hterm : ∀ γ ∈ f.support,
      (inner ℂ (hermiteMvLp β) (f γ • hermiteMvLp γ) : ℂ) = if β = γ then f γ else 0 := by
    intro γ _
    rw [inner_smul_right, inner_hermiteMvLp]
    split <;> simp_all
  rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq f.support β f]
  split
  · rfl
  · exact (Finsupp.notMem_support_iff.mp (by assumption)).symm
