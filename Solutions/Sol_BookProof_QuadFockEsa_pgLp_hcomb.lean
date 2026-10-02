-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.pgLp_hcomb
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_HermiteBand_pgLp_hpsi
import Theorems.Thm_BookProof_HermiteProductCore_pgMap_apply
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
theorem solution (f : (Fin d →₀ ℕ) →₀ ℂ) :
    pgLp (hcomb f) = ∑ γ ∈ f.support, f γ • hermiteMvLp γ := by

  rw [hcomb, Finsupp.linearCombination_apply, Finsupp.sum, ← HermiteProductCore.pgMap_apply,
    map_sum]
  exact Finset.sum_congr rfl fun γ _ => by
    rw [map_smul, HermiteProductCore.pgMap_apply, pgLp_hpsi]
