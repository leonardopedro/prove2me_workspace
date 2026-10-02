-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.harmonicOsc_add_linearPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_quadOp_add_firstOrder_essentiallySelfAdjoint
open BookProof.HermiteRelative




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
simp_rw [hx]
  push_cast
  rw [Finset.sum_mul]
  exact Finset.sum_congr rfl fun i _ => by ring

theorem solution (b : Fin d → ℝ) :
    E :=
  ssentiallySelfAdjointOn (polyGaussCore (d := d))
        (quadOp (fun _ => (1 : ℝ)) + foOp
