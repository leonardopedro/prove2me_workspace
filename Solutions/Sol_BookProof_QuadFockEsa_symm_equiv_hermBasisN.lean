-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.symm_equiv_hermBasisN
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_HermiteBand_pgLp_hpsi
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_symm
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.QuadFockEsa




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteBand
open BookProof.HermiteGalerkin
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

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
