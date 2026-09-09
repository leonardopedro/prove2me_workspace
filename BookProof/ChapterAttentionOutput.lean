import Mathlib
import BookProof.ChapterObservableExpectation
import BookProof.ChapterSoftmaxSharpness
import BookProof.ChapterSoftmaxOrder

/-!
# Chapter "The Coherent State of Attention" — the output as a function of the
temperature

`ChapterObservableExpectation` already identifies the attention output with the
expectation value `observableExpectation p v = ∑ⱼ pⱼ • vⱼ` of a contextual
observable, and proves that it lies in the convex hull of the values.  This
module studies the *temperature family* of that output: what the head returns as
the inverse temperature runs from `0` to `∞`, and how sensitive the answer is to
the weights.  Nothing here re-proves what that module already has; the
convex-hull and norm bounds are reused from it.

Deliverables (all `sorry`-free, `axiom`-free):

* `headOutput β s v` — the output of a Softmax head at inverse temperature `β`,
  defined as the expectation value of the values against `scoreSoftmax β s`;
* `headOutput_zero` — **at infinite temperature the head ignores the query** and
  returns the plain mean of the values;
* `tendsto_headOutput` — **winner-takes-all**: with a strict score maximizer the
  output converges to that single value vector as the temperature drops to zero.
  Together with the previous item, the temperature dial interpolates between the
  unconditional mean and a hard table lookup;
* `headOutput_mem_convexHull`, `norm_headOutput_le`, `headOutput_const` — the
  whole family stays inside the convex hull of the values (specializations of
  `ChapterObservableExpectation`);
* `norm_observableExpectation_sub_le` — the output is `ℓ¹`-stable in the weights,
  the vector-valued companion of `ChapterSoftmaxStability`;
* `attentionOutput_eq_headOutput` — under a common key norm the coherent-state
  Born output is the head output at inverse temperature `2`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

open Filter Topology

noncomputable section

namespace BookProof.ChapterAttentionOutput

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxBorn BookProof.ChapterObservableExpectation

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The output of a head at inverse temperature `β` -/

/-- The output of a Softmax head at inverse temperature `beta`: the expectation
value of the values against the attention distribution. -/
def headOutput (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) : E :=
  observableExpectation (scoreSoftmax beta s) v

theorem headOutput_eq_sum (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    headOutput beta s v = ∑ j, scoreSoftmax beta s j • v j := rfl

/-- The whole temperature family stays inside the convex hull of the values. -/
theorem headOutput_mem_convexHull (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) (i : Fin m) :
    headOutput beta s v ∈ convexHull ℝ (Set.range v) :=
  prob_weighted_sum_mem_convexHull _ (fun j => scoreSoftmax_nonneg beta s j)
    (scoreSoftmax_sum_one beta s i) v

theorem norm_headOutput_le (beta : ℝ) (s : Fin m → ℝ) {v : Fin m → E} {C : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (i : Fin m) : ‖headOutput beta s v‖ ≤ C :=
  observableExpectation_norm_le _ (fun j => scoreSoftmax_nonneg beta s j)
    (scoreSoftmax_sum_one beta s i) v C hv

/-- A head whose values agree returns that value, at any temperature. -/
theorem headOutput_const (beta : ℝ) (s : Fin m → ℝ) (w : E) (i : Fin m) :
    headOutput beta s (fun _ => w) = w :=
  observableExpectation_const _ (scoreSoftmax_sum_one beta s i) w

/-- **At infinite temperature the head ignores the query** and returns the mean of
the values. -/
theorem headOutput_zero (s : Fin m → ℝ) (v : Fin m → E) :
    headOutput 0 s v = ((m : ℝ))⁻¹ • ∑ j, v j := by
  rw [headOutput_eq_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [scoreSoftmax_zero, one_div]

/-! ## The zero-temperature limit: a hard lookup -/

/-- **Winner-takes-all for the output.**  If the key `j` is the strict score
maximizer, the head output converges to the single value `v j` as the inverse
temperature grows: the soft average becomes a hard table lookup. -/
theorem tendsto_headOutput (s : Fin m → ℝ) (v : Fin m → E) (j : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) :
    Tendsto (fun b : ℝ => headOutput b s v) atTop (𝓝 (v j)) := by
  have h : Tendsto (fun b : ℝ => ∑ l, scoreSoftmax b s l • v l) atTop
      (𝓝 (∑ l : Fin m, (if l = j then (1 : ℝ) else 0) • v l)) := by
    refine tendsto_finset_sum _ fun l _ => ?_
    rcases eq_or_ne l j with hl | hl
    · subst hl
      simpa using (tendsto_scoreSoftmax_max s l hmax).smul_const (v l)
    · simpa [hl] using (tendsto_scoreSoftmax_ne s j l hmax hl).smul_const (v l)
  simpa [headOutput_eq_sum] using h

/-! ## Stability of the output -/

/-- The expectation value is `ℓ¹`-stable in the weights: this is the
vector-valued companion of the scalar stability bounds of
`ChapterSoftmaxStability`. -/
theorem norm_observableExpectation_sub_le (p q : Fin m → ℝ) {v : Fin m → E} {C : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) :
    ‖observableExpectation p v - observableExpectation q v‖ ≤ (∑ j, |p j - q j|) * C := by
  have hdiff : observableExpectation p v - observableExpectation q v
      = ∑ j, (p j - q j) • v j := by
    rw [observableExpectation, observableExpectation, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun j _ => by rw [sub_smul]
  calc ‖observableExpectation p v - observableExpectation q v‖
      ≤ ∑ j, ‖(p j - q j) • v j‖ := by rw [hdiff]; exact norm_sum_le _ _
    _ = ∑ j, |p j - q j| * ‖v j‖ := by
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [norm_smul, Real.norm_eq_abs]
    _ ≤ ∑ j, |p j - q j| * C := Finset.sum_le_sum fun j _ =>
        mul_le_mul_of_nonneg_left (hv j) (abs_nonneg _)
    _ = (∑ j, |p j - q j|) * C := by rw [Finset.sum_mul]

/-! ## The coherent-state head -/

/-- **The Born output is the head output at inverse temperature `2`.**  Under a
common key norm the coherent-state Born weights are Softmax in the alignment
scores (`ChapterSoftmaxBorn.coherentBorn_eq_softmax`), so the two descriptions of
the layer return the same value vector. -/
theorem attentionOutput_eq_headOutput (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (r : ℝ)
    (hnorm : ∀ l, ‖k l‖ = r) :
    attentionOutput q k v = headOutput 2 (fun l => (inner ℝ q (k l) : ℝ)) v := by
  rw [attentionOutput, headOutput_eq_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [coherentBorn_eq_softmax q k r hnorm j, softmax_eq_scoreSoftmax]

end BookProof.ChapterAttentionOutput

end
