import Mathlib
import BookProof.ChapterSoftmaxJacobian
import BookProof.ChapterLogPartitionConvex

/-!
# Chapter "The Coherent State of Attention": the learning signal

If Softmax attention is the Born rule, then *training* an attention layer is
fitting a Born probability to an observed outcome.  The fitting criterion is the
negative log-likelihood of the observed key — the cross-entropy loss

`L(s) = log Z_β(s) − β·s_y = −log p_β(y)`,

the free energy minus the energy of the realized outcome.  This module proves the
three facts an optimizer relies on.

* `crossEntropyLoss_eq_neg_log`, `crossEntropyLoss_nonneg`,
  `crossEntropyLoss_eq_zero_iff` — the loss is the surprisal of the observed key:
  nonnegative, and zero exactly when the layer already puts all its weight there.
* `hasDerivAt_crossEntropyLoss_score` — **the gradient of the loss is `β·(p − y)`**:
  the classical backpropagation rule of a Softmax layer, here derived from the
  free-energy derivative `∂ log Z/∂sᵢ = β·pᵢ` of `ChapterSoftmaxJacobian`.  The
  update pushes the observed key up and every other key down, in proportion to the
  attention it currently receives.
* `crossEntropyGradient_sum_zero` — the gradient sums to zero over the keys: the
  update is a *transfer* of attention, tangent to the probability simplex, and so
  the gauge freedom `s ↦ s + c` of `ChapterSoftmaxOrder` is never excited.

Finally `convexOn_crossEntropyLoss` records that the loss is convex in the inverse
temperature (`log Z` is convex, `β·s_y` is linear), so temperature fitting is a
one-dimensional convex problem with no spurious minima.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterCrossEntropyGradient

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxFluctuation BookProof.ChapterSoftmaxJacobian
  BookProof.ChapterLogPartitionConvex

variable {m : ℕ}

/-! ## The loss -/

/-- The **cross-entropy loss** of a Softmax attention layer at the observed key
`y`: the free energy minus the energy of the observed outcome. -/
def crossEntropyLoss (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) : ℝ :=
  logPartition beta s - beta * s y

/-- The loss is the surprisal `−log p(y)` of the observed key. -/
theorem crossEntropyLoss_eq_neg_log (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    crossEntropyLoss beta s y = -Real.log (scoreSoftmax beta s y) := by
  have hZ : partition beta s ≠ 0 := partition_ne_zero beta s y
  rw [crossEntropyLoss, scoreSoftmax_eq_div, Real.log_div (Real.exp_ne_zero _) hZ,
    Real.log_exp, logPartition]
  ring

theorem crossEntropyLoss_nonneg (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    0 ≤ crossEntropyLoss beta s y := by
  rw [crossEntropyLoss_eq_neg_log, neg_nonneg]
  exact Real.log_nonpos (scoreSoftmax_nonneg beta s y) (scoreSoftmax_le_one beta s y)

/-- The loss vanishes exactly when the layer already places all of its attention on
the observed key. -/
theorem crossEntropyLoss_eq_zero_iff (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    crossEntropyLoss beta s y = 0 ↔ scoreSoftmax beta s y = 1 := by
  rw [crossEntropyLoss_eq_neg_log, neg_eq_zero]
  constructor
  · intro h
    have hpos : 0 < scoreSoftmax beta s y := scoreSoftmax_pos beta s y
    rcases Real.log_eq_zero.1 h with h0 | h1 | hm1
    · exact absurd h0 (ne_of_gt hpos)
    · exact h1
    · linarith
  · intro h
    rw [h, Real.log_one]

/-! ## The gradient -/

/-- The gradient of the cross-entropy loss with respect to the score of the key
`i`: `β·(pᵢ − δᵢy)`. -/
def crossEntropyGradient (beta : ℝ) (s : Fin m → ℝ) (y i : Fin m) : ℝ :=
  beta * (scoreSoftmax beta s i - (if i = y then 1 else 0))

/-- **HEADLINE — the backpropagation rule of a Softmax layer.**  The derivative of
the cross-entropy loss in the score of the key `i` is `β·(pᵢ − δᵢy)`: attention is
subtracted from every key in proportion to the weight it currently holds, and one
full unit is returned to the observed key. -/
theorem hasDerivAt_crossEntropyLoss_score (beta : ℝ) (s : Fin m → ℝ) (y i : Fin m) :
    HasDerivAt (fun t : ℝ => crossEntropyLoss beta (scorePerturb s i t) y)
      (crossEntropyGradient beta s y i) 0 := by
  have hlog := hasDerivAt_logPartition_score beta s i
  have henergy : HasDerivAt (fun t : ℝ => beta * scorePerturb s i t y)
      (beta * (if i = y then 1 else 0)) 0 := by
    by_cases h : y = i
    · subst h
      have : HasDerivAt (fun t : ℝ => beta * (s y + t)) beta 0 := by
        simpa using ((hasDerivAt_id (0 : ℝ)).const_add (s y)).const_mul beta
      simpa [scorePerturb, mul_comm] using this
    · have hconst : (fun t : ℝ => beta * scorePerturb s i t y)
          = fun _ : ℝ => beta * s y := by
        funext t
        rw [scorePerturb_of_ne s h t]
      have hiy : (if i = y then (1 : ℝ) else 0) = 0 := if_neg fun hh => h hh.symm
      rw [hconst, hiy, mul_zero]
      exact hasDerivAt_const (0 : ℝ) (beta * s y)
  have h := hlog.sub henergy
  refine h.congr_deriv ?_
  rw [crossEntropyGradient]
  ring

theorem deriv_crossEntropyLoss_score (beta : ℝ) (s : Fin m → ℝ) (y i : Fin m) :
    deriv (fun t : ℝ => crossEntropyLoss beta (scorePerturb s i t) y) 0
      = crossEntropyGradient beta s y i :=
  (hasDerivAt_crossEntropyLoss_score beta s y i).deriv

/-- **The learning signal is a transfer of attention.**  The gradient sums to zero
over the keys: what one key gains, the others lose. -/
theorem crossEntropyGradient_sum_zero (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    ∑ i, crossEntropyGradient beta s y i = 0 := by
  have hsum : ∑ i, scoreSoftmax beta s i = 1 := scoreSoftmax_sum_one beta s y
  have hdelta : ∑ i : Fin m, (if i = y then (1 : ℝ) else 0) = 1 := by
    simp
  simp only [crossEntropyGradient]
  rw [← Finset.mul_sum, Finset.sum_sub_distrib, hsum, hdelta, sub_self, mul_zero]

/-- The observed key is pushed up (its gradient is nonpositive at `β ≥ 0`), and
every other key is pushed down. -/
theorem crossEntropyGradient_target_nonpos {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (y : Fin m) : crossEntropyGradient beta s y y ≤ 0 := by
  have h := scoreSoftmax_le_one beta s y
  have : scoreSoftmax beta s y - 1 ≤ 0 := by linarith
  simpa [crossEntropyGradient] using mul_nonpos_of_nonneg_of_nonpos hb this

theorem crossEntropyGradient_other_nonneg {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    {y i : Fin m} (h : i ≠ y) : 0 ≤ crossEntropyGradient beta s y i := by
  have hp : 0 ≤ scoreSoftmax beta s i := scoreSoftmax_nonneg beta s i
  simpa [crossEntropyGradient, h] using mul_nonneg hb hp

/-! ## Convexity in the temperature -/

/-- The loss is convex in the inverse temperature: fitting the temperature of an
attention layer is a one-dimensional convex problem. -/
theorem convexOn_crossEntropyLoss (s : Fin m → ℝ) (y : Fin m) :
    ConvexOn ℝ Set.univ (fun b : ℝ => crossEntropyLoss b s y) := by
  have hlog : ConvexOn ℝ Set.univ (fun b : ℝ => logPartition b s) :=
    convexOn_logPartition s y
  have hlin : ConvexOn ℝ Set.univ (fun b : ℝ => -(b * s y)) := by
    refine ⟨convex_univ, fun x _ z _ a b _ _ _ => ?_⟩
    simp only [smul_eq_mul]
    exact le_of_eq (by ring)
  have heq : (fun b : ℝ => crossEntropyLoss b s y)
      = fun b : ℝ => logPartition b s + -(b * s y) := by
    funext b
    rw [crossEntropyLoss]
    ring
  rw [heq]
  exact hlog.add hlin

end BookProof.ChapterCrossEntropyGradient

end
