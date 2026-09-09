-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.re_inner_oscL_le_quadOp
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_re_inner_diagonal_le
import Theorems.Thm_BookProof_HermiteRelative_oscL_hermiteMvLp
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
set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem solution (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    (i : Fin d) (u : polyGaussCore (d := d)) :
    c0 * (inner ℂ (u : L2d d) (oscL i u) : ℂ).re
      ≤ (inner ℂ (u : L2d d) (quadOp c u) : ℂ).re := by

  classical
  have hsymb : ∀ a : Fin d →₀ ℕ, c0 * ((a i : ℝ) + 1/2) ≤ quadSymbol c a := by
    intro a
    have hterms : ∀ j ∈ (Finset.univ : Finset (Fin d)), 0 ≤ c j * ((a j : ℝ) + 1/2) := by
      intro j _
      have : (0 : ℝ) ≤ c j := le_trans hc0.le (hc j)
      positivity
    have hle : c0 * ((a i : ℝ) + 1/2) ≤ c i * ((a i : ℝ) + 1/2) := by
      have hpos : (0 : ℝ) ≤ (a i : ℝ) + 1/2 := by positivity
      exact mul_le_mul_of_nonneg_right (hc i) hpos
    have hsum : c i * ((a i : ℝ) + 1/2) ≤ ∑ j, c j * ((a j : ℝ) + 1/2) :=
      Finset.single_le_sum hterms (Finset.mem_univ i)
    exact le_trans hle (by simpa [quadSymbol] using hsum)
  have hSdiag : ∀ (a : Fin d →₀ ℕ) (h : hermiteMvLp a ∈ polyGaussCore (d := d)),
      (((c0 : ℝ) : ℂ) • oscL i) ⟨hermiteMvLp a, h⟩
        = (((c0 * ((a i : ℝ) + 1/2) : ℝ)) : ℂ) • hermiteMvLp a := by
    intro a h
    rw [LinearMap.smul_apply, oscL_hermiteMvLp, smul_smul]
    push_cast
    ring_nf
  have hmain := re_inner_diagonal_le (hermiteMvLp (d := d)) orthonormal_hermiteMvLp
    (fun a => c0 * ((a i : ℝ) + 1/2)) (quadSymbol c) span_hermiteMvLp
    (((c0 : ℝ) : ℂ) • oscL i) (quadOp c) hSdiag (fun a h => quadOp_hermiteMvLp c a h) hsymb u
  simpa [inner_smul_right, Complex.ofReal_re] using hmain
