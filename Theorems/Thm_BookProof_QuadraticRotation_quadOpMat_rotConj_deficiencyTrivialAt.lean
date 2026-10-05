-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.quadOpMat_rotConj_deficiencyTrivialAt
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HermiteProductCore
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.quadOpMat_rotConj_deficiencyTrivialAt {O : Matrix (Fin d) (Fin d) ℝ}
    (hO : Oᵀ * O = 1) (c : Fin d → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (quadOpMat (rotConj O c)) z := by sorry
