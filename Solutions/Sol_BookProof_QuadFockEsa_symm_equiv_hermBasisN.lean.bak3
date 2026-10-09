-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.symm_equiv_hermBasisN
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_HermiteBand_pgLp_hpsi
import Theorems.Thm_BookProof_HermiteProductCore_pgMap_apply
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_symm
open BookProof.QuadFockEsa




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin d →₀ ℕ)) (k : ℕ) :
    (coreRepHerm e).equiv.symm ⟨hermBasisN e k, Submodule.subset_span ⟨k, rfl⟩⟩ = hpsi (e k) := by

  have h1 : pgLp ((coreRepHerm e).equiv.symm
      ⟨hermBasisN e k, Submodule.subset_span ⟨k, rfl⟩⟩) = hermiteMvLp (e k) := by
    rw [← (coreRepHerm e).coe_symm]
    simp
  have h2 : pgLp (hpsi (e k)) = hermiteMvLp (e k) := pgLp_hpsi (e k)
  exact pgMap_injective (by rw [HermiteProductCore.pgMap_apply, HermiteProductCore.pgMap_apply,
    h1, h2])
