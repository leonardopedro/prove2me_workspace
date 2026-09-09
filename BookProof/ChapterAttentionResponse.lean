import Mathlib
import BookProof.ChapterAttentionOutput
import BookProof.ChapterSoftmaxTemperatureMonotone

/-!
# Chapter "The Coherent State of Attention": how the output responds to temperature

`ChapterSoftmaxFluctuation` differentiates the attention *weights* in the inverse
temperature.  This module differentiates the **output** of the head, and finds the
vector-valued fluctuation–response law

`d/dβ  headOutput β s v  =  Cov(s, v)  =  ⟨s·v⟩ − ⟨s⟩·⟨v⟩`,

the covariance of the alignment score with the value vector under the current
attention distribution.

* `scoreValueCovariance` — the covariance vector, and `scoreValueCovariance_eq_sub`
  its familiar `⟨s v⟩ − ⟨s⟩⟨v⟩` form;
* `hasDerivAt_headOutput` / `deriv_headOutput` — **the response law**;
* `scoreValueCovariance_const` — a head whose values agree has zero response: with
  nothing to choose between, sharpening does nothing;
* `norm_scoreValueCovariance_le` — the response is bounded by (value bound) ×
  (score spread);
* `norm_headOutput_sub_le_temperature` — hence the whole temperature family is
  Lipschitz in `β`: `‖out(γ) − out(β)‖ ≤ C·(s_max − s_min)·|γ − β|`.

The last bound is the quantitative statement that an attention head cannot react
violently to a change of temperature unless its scores are genuinely spread out.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionResponse

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxFluctuation BookProof.ChapterObservableExpectation
  BookProof.ChapterAttentionOutput BookProof.ChapterSoftmaxTemperatureMonotone

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The score–value covariance -/

/-- The covariance of the alignment score with the value vector, under the
attention distribution at inverse temperature `beta`. -/
def scoreValueCovariance (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) : E :=
  ∑ j, (scoreSoftmax beta s j * (s j - meanScore beta s)) • v j

/-- The covariance in its familiar `⟨s·v⟩ − ⟨s⟩·⟨v⟩` form. -/
theorem scoreValueCovariance_eq_sub (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    scoreValueCovariance beta s v
      = (∑ j, (scoreSoftmax beta s j * s j) • v j) - meanScore beta s • headOutput beta s v := by
  rw [scoreValueCovariance, headOutput_eq_sum, Finset.smul_sum, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [smul_smul, ← sub_smul]
  ring_nf

/-! ## The response law -/

/-- **The output of a head responds to temperature through the score–value
covariance.** -/
theorem hasDerivAt_headOutput (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    HasDerivAt (fun b : ℝ => headOutput b s v) (scoreValueCovariance beta s v) beta := by
  have h := HasDerivAt.sum (u := (Finset.univ : Finset (Fin m)))
    (A := fun (j : Fin m) (b : ℝ) => scoreSoftmax b s j • v j)
    (A' := fun j => (scoreSoftmax beta s j * (s j - meanScore beta s)) • v j)
    (fun j _ => (hasDerivAt_scoreSoftmax beta s j).smul_const (v j))
  have key : (∑ j : Fin m, fun b : ℝ => scoreSoftmax b s j • v j)
      = fun b : ℝ => headOutput b s v := by
    funext b
    rw [Finset.sum_apply, headOutput_eq_sum]
  rw [key] at h
  exact h

/-- The response law in `deriv` form. -/
theorem deriv_headOutput (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    deriv (fun b : ℝ => headOutput b s v) beta = scoreValueCovariance beta s v :=
  (hasDerivAt_headOutput beta s v).deriv

/-- **Nothing to choose between: a head with constant values has zero response.** -/
theorem scoreValueCovariance_const (beta : ℝ) (s : Fin m → ℝ) (w : E) (i : Fin m) :
    scoreValueCovariance beta s (fun _ => w) = (0 : E) := by
  have hsum : ∑ j, scoreSoftmax beta s j * (s j - meanScore beta s) = 0 := by
    have h1 : ∑ j, scoreSoftmax beta s j = 1 := scoreSoftmax_sum_one beta s i
    have : ∑ j, scoreSoftmax beta s j * (s j - meanScore beta s)
        = (∑ j, scoreSoftmax beta s j * s j)
          - (∑ j, scoreSoftmax beta s j) * meanScore beta s := by
      rw [Finset.sum_mul, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun j _ => by ring
    rw [this, h1, one_mul, ← meanScore, sub_self]
  rw [scoreValueCovariance, ← Finset.sum_smul, hsum, zero_smul]

/-! ## Quantitative bounds -/

/-- The response is bounded by the value bound times the score spread. -/
theorem norm_scoreValueCovariance_le (beta : ℝ) {s : Fin m → ℝ} {v : Fin m → E} {C D : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (hs : ∀ j, |s j - meanScore beta s| ≤ D) (i : Fin m) :
    ‖scoreValueCovariance beta s v‖ ≤ C * D := by
  have hC : 0 ≤ C := le_trans (norm_nonneg _) (hv i)
  have hterm : ∀ j : Fin m,
      ‖(scoreSoftmax beta s j * (s j - meanScore beta s)) • v j‖
        ≤ scoreSoftmax beta s j * (C * D) := by
    intro j
    rw [norm_smul, Real.norm_eq_abs, abs_mul,
      abs_of_nonneg (scoreSoftmax_nonneg beta s j)]
    have h1 : |s j - meanScore beta s| * ‖v j‖ ≤ D * C := by
      have hD : 0 ≤ D := le_trans (abs_nonneg _) (hs j)
      exact mul_le_mul (hs j) (hv j) (norm_nonneg _) hD
    calc scoreSoftmax beta s j * |s j - meanScore beta s| * ‖v j‖
        = scoreSoftmax beta s j * (|s j - meanScore beta s| * ‖v j‖) := by ring
      _ ≤ scoreSoftmax beta s j * (D * C) :=
          mul_le_mul_of_nonneg_left h1 (scoreSoftmax_nonneg beta s j)
      _ = scoreSoftmax beta s j * (C * D) := by ring
  calc ‖scoreValueCovariance beta s v‖
      ≤ ∑ j, ‖(scoreSoftmax beta s j * (s j - meanScore beta s)) • v j‖ :=
        norm_sum_le _ _
    _ ≤ ∑ j, scoreSoftmax beta s j * (C * D) := Finset.sum_le_sum fun j _ => hterm j
    _ = C * D := by rw [← Finset.sum_mul, scoreSoftmax_sum_one beta s i, one_mul]

/-- Under a two-sided bound on the scores, every score deviates from the mean by at
most the spread, at every temperature. -/
theorem abs_score_sub_meanScore_le {s : Fin m → ℝ} {a b : ℝ} (ha : ∀ l, a ≤ s l)
    (hb : ∀ l, s l ≤ b) (beta : ℝ) (j : Fin m) : |s j - meanScore beta s| ≤ b - a := by
  have h1 : meanScore beta s ≤ b := by
    have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s j
    calc meanScore beta s ≤ ∑ l, scoreSoftmax beta s l * b :=
          Finset.sum_le_sum fun l _ =>
            mul_le_mul_of_nonneg_left (hb l) (scoreSoftmax_nonneg beta s l)
      _ = b := by rw [← Finset.sum_mul, hsum, one_mul]
  have h2 : a ≤ meanScore beta s := by
    have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s j
    calc a = ∑ l, scoreSoftmax beta s l * a := by rw [← Finset.sum_mul, hsum, one_mul]
      _ ≤ meanScore beta s :=
          Finset.sum_le_sum fun l _ =>
            mul_le_mul_of_nonneg_left (ha l) (scoreSoftmax_nonneg beta s l)
  rw [abs_le]
  constructor
  · have := ha j; linarith
  · have := hb j; linarith

/-- **The temperature family is Lipschitz.**  If the values are bounded by `C` and
the scores lie in `[a, b]`, then moving the inverse temperature from `beta` to
`gamma` moves the output by at most `C·(b − a)·|γ − β|`. -/
theorem norm_headOutput_sub_le_temperature {s : Fin m → ℝ} {v : Fin m → E} {C a b : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (ha : ∀ l, a ≤ s l) (hb : ∀ l, s l ≤ b) (i : Fin m)
    (beta gamma : ℝ) :
    ‖headOutput gamma s v - headOutput beta s v‖ ≤ C * (b - a) * |gamma - beta| := by
  have hderiv : ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivWithinAt (fun t : ℝ => headOutput t s v) (scoreValueCovariance x s v)
        Set.univ x := fun x _ => (hasDerivAt_headOutput x s v).hasDerivWithinAt
  have hbound : ∀ x ∈ (Set.univ : Set ℝ), ‖scoreValueCovariance x s v‖ ≤ C * (b - a) :=
    fun x _ => norm_scoreValueCovariance_le x hv (abs_score_sub_meanScore_le ha hb x) i
  have := (convex_univ (𝕜 := ℝ) (E := ℝ)).norm_image_sub_le_of_norm_hasDerivWithin_le
    hderiv hbound (Set.mem_univ beta) (Set.mem_univ gamma)
  simpa [Real.norm_eq_abs] using this

end BookProof.ChapterAttentionResponse

end
