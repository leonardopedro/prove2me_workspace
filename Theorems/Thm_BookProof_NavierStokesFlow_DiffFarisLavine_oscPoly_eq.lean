-- Generated from ChapterNavierStokesDiffFarisLavine.lean — theorem BookProof.NavierStokesFlow.DiffFarisLavine.oscPoly_eq
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

theorem BookProof.NavierStokesFlow.DiffFarisLavine.oscPoly_eq (i : Fin 3) (p : MvPolynomial (Fin 3) ℂ) :
    momPoly i (momPoly i p) + mulXPoly i (mulXPoly i (((1 / 4 : ℂ)) • p))
      = crePoly i (annPoly i p) + ((1 / 2 : ℂ)) • p := by sorry
