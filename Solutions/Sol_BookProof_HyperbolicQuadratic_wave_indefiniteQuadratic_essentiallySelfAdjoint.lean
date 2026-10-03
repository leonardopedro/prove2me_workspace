-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.wave_indefiniteQuadratic_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_essentiallySelfAdjoint
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution := 
