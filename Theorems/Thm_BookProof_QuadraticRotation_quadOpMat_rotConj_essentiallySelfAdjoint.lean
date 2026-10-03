-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.quadOpMat_rotConj_essentiallySelfAdjoint
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.quadOpMat_rotConj_essentiallySelfAdjoint {O : Matrix (Fin d) (Fin d) ℝ}
    (hO : Oᵀ * O = 1) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOpMat (rotConj O c)) := by sorry
