-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.rotPoly_C
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
open BookProof.QuadraticRotation

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.rotPoly_C (O : Matrix (Fin d) (Fin d) ℝ) (z : ℂ) : rotPoly O (C z) = C z := by sorry
