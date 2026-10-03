-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.rotPoly_mulXPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterA4
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.rotPoly_mulXPoly (O : Matrix (Fin d) (Fin d) ℝ) (i : Fin d)
    (p : MvPolynomial (Fin d) ℂ) :
    rotPoly O (mulXPoly i p) = ∑ k, ((O k i : ℝ) : ℂ) • mulXPoly k (rotPoly O p) := by sorry
