-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.foOp_apply
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_coreOp_add
import Theorems.Thm_BookProof_HermiteRelative_coreOp_smul
import Theorems.Thm_BookProof_HermiteRelative_coreOp_sum
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
theorem solution (b b' : Fin d → ℝ) (u : polyGaussCore (d := d)) :
    foOp b b' u = ∑ i, (((b i : ℝ) : ℂ) • posL i u + ((b' i : ℝ) : ℂ) • momL i u) :=
      foOp b b' u = ∑ i, (((b i : ℝ) : ℂ) • posL i u + ((b' i : ℝ) : ℂ) • momL i u) := by
    simp only [foOp, foPoly, LinearMap.comp_apply, Submodule.subtype_apply, coreOp_sum,
      coreOp_add, coreOp_smul, LinearMap.sum_apply, LinearMap.add_
