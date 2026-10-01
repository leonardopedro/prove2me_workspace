-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.harmonicOsc_add_linearPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

simp_rw [hx]
  push_cast
  rw [Finset.sum_mul]
  exact Finset.sum_congr rfl fun i _ => by ring

theorem BookProof.HermiteRelative.harmonicOsc_add_linearPotential_essentiallySelfAdjoint (b : Fin d → ℝ) :
    E := by sorry
