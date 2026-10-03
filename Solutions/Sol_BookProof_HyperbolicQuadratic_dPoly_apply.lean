-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.dPoly_apply
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    dPoly i p = pderiv i p - (1/2 : ℂ) • (X i * p) := rfl

theorem sec_sec (i : Fin d) (x : Vd d) (t s : ℝ) : sec i (sec i x t) s = sec i x s := rfl
