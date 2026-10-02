-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.hermiteMvBasis_repr_quadOp
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvBasis_apply
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvLp_mem_core
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_hermiteMvLp
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_symmetric
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
 u‖ + K * (2 / (c0 * e)) * ‖(u : L2d d)‖ := by ring

theorem solution (c : Fin d → ℝ) (u : polyGaussCore (d := d))
    (a : Fin d →₀ ℕ) :
    hermiteMvBasis :=
  .repr (quadOp c u) a
        = ((quadSymbol c a : ℝ) : ℂ) * hermiteMvBasis.repr (u : L2d d) a := by
    have hmem : hermiteMvLp a ∈ polyGaussCore (d := d) := hermiteMvLp_mem_core a
    have hsym := quadOp_symmetric c ⟨hermiteMvLp a, hmem⟩ u
    rw [quadOp_hermiteMvLp c a hmem, inner_smul_left, Complex.conj_ofReal] at hsym
    rw [Hilbe
