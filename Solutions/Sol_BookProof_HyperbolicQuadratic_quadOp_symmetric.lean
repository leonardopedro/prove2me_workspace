import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.quadOp_symmetric
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_symmetricOn_of_diagonal
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_hermiteMvLp
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (quadOp c) :=
  symmetricOn_of_diagonal hermiteMvLp orthonormal_hermiteMvLp (quadSymbol c)
      span_hermiteMvLp (quadOp c) (fun a h => quadOp_hermiteMvLp c a h)
