-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.quadOpMat_symmetric
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.QuadraticRotation

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.quadOpMat_symmetric {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian) :
    SymmetricOn (polyGaussCore (d := d)) (quadOpMat A) := by sorry
