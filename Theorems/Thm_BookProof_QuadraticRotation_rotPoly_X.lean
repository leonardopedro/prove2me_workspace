-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.rotPoly_X
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
open BookProof.QuadraticRotation



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}


theorem BookProof.QuadraticRotation.rotPoly_X (O : Matrix (Fin d) (Fin d) ℝ) (i : Fin d) :
    rotPoly O (X i) = ∑ j, C ((O j i : ℝ) : ℂ) * X j := by sorry
