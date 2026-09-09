import Mathlib
import BookProof.ChapterSoftmaxOrder
import BookProof.ChapterObservableExpectation

/-!
# Chapter "The Coherent State of Attention": a logit bias is a prior

Real heads rarely score their keys on alignment alone: a learned per-key bias, a
relative-position bias, a repetition penalty or a class prior is added to the
logits before the Softmax.  Read through the Born rule, such a bias is not a hack —
it is the **prior** of the Bayesian update whose likelihood is `e^{β s}`.

Writing `w j > 0` for the prior weight of key `j`:

* `priorSoftmax` — the biased head `pⱼ ∝ wⱼ e^{β sⱼ}`, a probability distribution
  (`priorSoftmax_pos`, `priorSoftmax_sum_one`);
* **`priorSoftmax_eq_posterior`** — it *is* the Bayes posterior of
  `ChapterBayesInference` with prior `w` and likelihood `e^{β s}`;
* **`priorSoftmax_odds`** — the headline in odds form: posterior odds = prior odds
  × likelihood ratio, `pᵢ/pⱼ = (wᵢ/wⱼ)·e^{β(sᵢ−sⱼ)}`;
* `priorSoftmax_eq_scoreSoftmax_bias` — equivalently, the prior is exactly a score
  bias `sⱼ ↦ sⱼ + (log wⱼ)/β`: a logit bias and a prior are the same object;
* `priorSoftmax_smul` — only the *ratios* of the prior weights matter (its overall
  scale is a gauge), and `priorSoftmax_uniform` recovers plain Softmax;
* `priorSoftmax_zero` — at infinite temperature the head returns the normalized
  prior: with no evidence, the posterior is the prior.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionPrior

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterBayesInference

variable {m : ℕ}

/-! ## The biased head -/

/-- **Attention with a prior**: `pⱼ ∝ wⱼ·e^{β sⱼ}`. -/
def priorSoftmax (w : Fin m → ℝ) (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) : ℝ :=
  w j * Real.exp (beta * s j) / ∑ l, w l * Real.exp (beta * s l)

theorem priorDenom_pos {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ) (s : Fin m → ℝ)
    (i : Fin m) : 0 < ∑ l, w l * Real.exp (beta * s l) :=
  Finset.sum_pos' (fun l _ => (mul_pos (hw l) (Real.exp_pos _)).le)
    ⟨i, Finset.mem_univ i, mul_pos (hw i) (Real.exp_pos _)⟩

theorem priorSoftmax_pos {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ) (s : Fin m → ℝ)
    (j : Fin m) : 0 < priorSoftmax w beta s j :=
  div_pos (mul_pos (hw j) (Real.exp_pos _)) (priorDenom_pos hw beta s j)

theorem priorSoftmax_sum_one {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ)
    (s : Fin m → ℝ) (i : Fin m) : ∑ j, priorSoftmax w beta s j = 1 := by
  simp only [priorSoftmax]
  rw [← Finset.sum_div]
  exact div_self (priorDenom_pos hw beta s i).ne'

/-! ## It is the Bayes posterior -/

/-- **A logit bias is a Bayesian prior.**  The biased head is the Bayes posterior
with prior `w` and likelihood `e^{β s}` (the evidence being the sole observation). -/
theorem priorSoftmax_eq_posterior (w : Fin m → ℝ) (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w beta s j
      = posterior w (fun l (_ : Unit) => Real.exp (beta * s l)) () j := rfl

/-- **HEADLINE — posterior odds = prior odds × likelihood ratio.** -/
theorem priorSoftmax_odds {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ) (s : Fin m → ℝ)
    (i j : Fin m) :
    priorSoftmax w beta s i
      = (w i / w j) * Real.exp (beta * (s i - s j)) * priorSoftmax w beta s j := by
  have hD : (0 : ℝ) < ∑ l, w l * Real.exp (beta * s l) := priorDenom_pos hw beta s i
  have hwj : w j ≠ 0 := (hw j).ne'
  rw [priorSoftmax, priorSoftmax, mul_sub, Real.exp_sub]
  field_simp

/-- **A prior is exactly a score bias.**  At a finite, non-zero temperature the
biased head is the plain head on the shifted scores `sⱼ + (log wⱼ)/β`. -/
theorem priorSoftmax_eq_scoreSoftmax_bias {w : Fin m → ℝ} (hw : ∀ j, 0 < w j)
    {beta : ℝ} (hb : beta ≠ 0) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w beta s j
      = scoreSoftmax beta (fun l => s l + Real.log (w l) / beta) j := by
  have hterm : ∀ l : Fin m,
      Real.exp (beta * (s l + Real.log (w l) / beta)) = w l * Real.exp (beta * s l) := by
    intro l
    rw [mul_add, Real.exp_add, mul_div_cancel₀ _ hb, Real.exp_log (hw l), mul_comm]
  rw [scoreSoftmax, priorSoftmax, hterm j]
  exact congrArg _ (Finset.sum_congr rfl fun l _ => (hterm l).symm)

/-! ## Gauge freedom and the two extremes -/

/-- Only the ratios of the prior weights matter: rescaling the prior is a gauge. -/
theorem priorSoftmax_smul {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) {c : ℝ} (hc : 0 < c)
    (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax (fun l => c * w l) beta s j = priorSoftmax w beta s j := by
  have hD : (0 : ℝ) < ∑ l, w l * Real.exp (beta * s l) := priorDenom_pos hw beta s j
  have hsum : ∑ l, c * w l * Real.exp (beta * s l)
      = c * ∑ l, w l * Real.exp (beta * s l) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by ring
  rw [priorSoftmax, priorSoftmax, hsum]
  field_simp

/-- A uniform prior is no prior: the biased head is the ordinary Softmax head. -/
theorem priorSoftmax_uniform {c : ℝ} (hc : 0 < c) (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax (fun _ => c) beta s j = scoreSoftmax beta s j := by
  have hsum : ∑ l, c * Real.exp (beta * s l) = c * ∑ l, Real.exp (beta * s l) := by
    rw [Finset.mul_sum]
  rw [priorSoftmax, scoreSoftmax, hsum, mul_div_mul_left _ _ hc.ne']

/-- **With no evidence, the posterior is the prior.**  At `β = 0` the biased head
returns the normalized prior weights. -/
theorem priorSoftmax_zero (w : Fin m → ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w 0 s j = w j / ∑ l, w l := by
  simp [priorSoftmax]

end BookProof.ChapterAttentionPrior

end
