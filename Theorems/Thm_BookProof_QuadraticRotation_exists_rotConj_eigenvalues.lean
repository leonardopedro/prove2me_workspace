-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.exists_rotConj_eigenvalues
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterA4
open BookProof.QuadraticRotation

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.exists_rotConj_eigenvalues {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian) :
    ∃ O : Matrix (Fin d) (Fin d) ℝ, Oᵀ * O = 1 ∧ A = rotConj O hA.eigenvalues := by sorry
