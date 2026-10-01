-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.hermCol_eq_coef
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

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section


theorem BookProof.QuadFockEsa.hermCol_eq_coef (e : ℕ ≃ (Fin d →₀ ℕ)) {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)}
    {f : (Fin d →₀ ℕ) →₀ ℂ} {k : ℕ} (hf : T (hpsi (e k)) = hcomb f) (j : ℕ) :
    hermCol e T k j = f (e j) := by sorry
