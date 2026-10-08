-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.wave_rotated_essentiallySelfAdjoint
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



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}


theorem BookProof.QuadraticRotation.wave_rotated_essentiallySelfAdjoint {n : ℕ}
    {O : Matrix (Fin (1 + n)) (Fin (1 + n)) ℝ} (hO : Oᵀ * O = 1) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1 + n))
      (quadOpMat (rotConj O (minkowskiCoeff n))) := by sorry
