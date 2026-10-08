-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.pgLp_hcomb
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteBand
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.QuadFockEsa



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}


theorem BookProof.QuadFockEsa.pgLp_hcomb (f : (Fin d →₀ ℕ) →₀ ℂ) :
    pgLp (hcomb f) = ∑ γ ∈ f.support, f γ • hermiteMvLp γ := by sorry
