-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.quadOp_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_hermiteMvLp
import Theorems.Thm_BookProof_HyperbolicQuadratic_hermiteMvLp_total
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin d → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (quadOp c) z :=
  deficiencyTrivialAt_of_diagonal hermiteMvLp (quadSymbol c) hermiteMvLp_total (quadOp c)
      hermiteMvLp_mem_core (fun a h => quadOp_hermiteMvLp c a h) hz