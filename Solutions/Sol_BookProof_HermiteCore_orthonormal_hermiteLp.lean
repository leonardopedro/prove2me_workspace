-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.orthonormal_hermiteLp
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hermiteInner_eq
import Theorems.Thm_BookProof_HermiteCore_hermiteFun_mul
import Theorems.Thm_BookProof_HermiteCore_hermiteNorm_sq
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
fine (memLp_congr_ae (Filter.Eventually.of_forall fun x => ?_)).mp h
  simp only [hermiteC, hermiteFun, Polynomial.eval_mu :=
  l, Polynomial.eval_C]
    push_cast
    ring
  
  /-- The normalized Hermite functions as elements of `L²(ℝ, ℂ)`. -/
  def hermiteLp (n : ℕ) : Lp ℂ 2 (volume : Measure ℝ) := (memLp_hermiteC n).toLp _
  
  theorem hermiteLp_coeFn (n : ℕ) : (hermiteLp n : ℝ → ℂ) =ᵐ[volume] hermiteC n :=
    (memLp_hermiteC n).coeFn_toLp
  
  /-- **The Hermite functions are orthonormal in `L²(ℝ)`.** -/
  theorem orthonormal_hermiteLp : Orthonormal ℂ hermiteLp := by
    rw [orthonormal_iff_ite]
    intro m n
    have hcoe : (fun x : ℝ => (inner ℂ ((hermiteLp m : ℝ → ℂ) x) ((hermiteLp n : ℝ → ℂ) x) : ℂ))
        =ᵐ[volume] fun x : ℝ =>
          ((hermiteFun m x * hermiteFun n x / (hermiteNorm m * hermiteNorm n) : ℝ) : ℂ) := by
      filter_upwards [hermiteLp_coeFn m, hermiteLp_coeFn n] with x h1 h2
      rw [h1, h2]
      simp only [hermiteC, RCLike.inner_apply, Complex.conj_ofReal, ← Complex.ofReal_mul]
      push_cast
      ring
    rw [L2.inner_def, integral_congr_ae hcoe, integral_complex_ofReal]
    have hint : ∫ x : ℝ, hermiteFun m x * hermiteFun n x / (hermiteNorm m * hermiteNorm n)
        = hermiteInner m n / (hermiteNorm m * hermiteNorm n) := by
      rw [integral_div]
      congr 1
      rw [hermiteInner, gint]
      exact i
