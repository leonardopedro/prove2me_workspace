-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.quadOpMat_not_bounded
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.QuadraticRotation



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}


theorem BookProof.QuadraticRotation.quadOpMat_not_bounded {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian)
    (hA0 : A ≠ 0) :
    ¬ ∃ K : ℝ, ∀ f : polyGaussCore (d := d), ‖quadOpMat A f‖ ≤ K * ‖(f : L2d d)‖ := by sorry
