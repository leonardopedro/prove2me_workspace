-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.symm_equiv_hermBasisN
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteBand
open BookProof.HermiteGalerkin
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.QuadFockEsa

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section


theorem BookProof.QuadFockEsa.symm_equiv_hermBasisN (e : ℕ ≃ (Fin d →₀ ℕ)) (k : ℕ) :
    (coreRepHerm e).equiv.symm ⟨hermBasisN e k, Submodule.subset_span ⟨k, rfl⟩⟩ = hpsi (e k) := by sorry
