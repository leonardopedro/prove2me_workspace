import Mathlib
import BookProof.ChapterSoftmaxDivergence

/-!
# Chapter "The Coherent State of Attention" — convexity of the free energy

The log-partition function `log Z(β) = log ∑ⱼ exp (β sⱼ)` of an attention head is
the generating function of the attention statistics: its first derivative is the
mean score and its second derivative is the score variance
(`ChapterSoftmaxFluctuation`).  Because the variance is nonnegative, `log Z` is a
**convex** function of the inverse temperature, and strictly convex as soon as two
alignment scores differ.

* `hasDerivAt_deriv_logPartition` — the second derivative of `log Z` is `Var_β(s)`;
* `convexOn_logPartition` — **the headline**: `β ↦ log Z(β)` is convex on `ℝ`;
* `strictConvexOn_logPartition` — strict convexity when two scores differ;
* `logPartition_isGreatest` — the variational (Legendre) description: `log Z(β)`
  is the *largest* value of `β⟨s⟩_p + H(p)` over probability vectors `p`, attained
  at the Softmax distribution.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterLogPartitionConvex

open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxOrder BookProof.ChapterSoftmaxFluctuation
  BookProof.ChapterSoftmaxMaxEntropy BookProof.ChapterSoftmaxDivergence

variable {m : ℕ}

/-! ## The derivative of the free energy -/

theorem deriv_logPartition_eq (s : Fin m → ℝ) (i : Fin m) :
    (deriv fun b : ℝ => logPartition b s) = fun b : ℝ => meanScore b s :=
  funext fun b => deriv_logPartition b s i

theorem differentiable_logPartition (s : Fin m → ℝ) (i : Fin m) :
    Differentiable ℝ fun b : ℝ => logPartition b s := fun b =>
  (hasDerivAt_logPartition b s i).differentiableAt

/-- **The second derivative of the free energy is the score variance.** -/
theorem hasDerivAt_deriv_logPartition (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (deriv fun b : ℝ => logPartition b s) (varScore beta s) beta := by
  rw [deriv_logPartition_eq s i]
  exact hasDerivAt_meanScore beta s i

/-! ## Convexity -/

/-- **The free energy is convex in the inverse temperature.** -/
theorem convexOn_logPartition (s : Fin m → ℝ) (i : Fin m) :
    ConvexOn ℝ Set.univ fun b : ℝ => logPartition b s := by
  refine Monotone.convexOn_univ_of_deriv (differentiable_logPartition s i) ?_
  rw [deriv_logPartition_eq s i]
  exact meanScore_monotone s i

/-- When two alignment scores differ, the free energy is **strictly** convex. -/
theorem strictConvexOn_logPartition {s : Fin m → ℝ} {a b : Fin m} (hab : s a ≠ s b) :
    StrictConvexOn ℝ Set.univ fun c : ℝ => logPartition c s := by
  refine StrictMono.strictConvexOn_univ_of_deriv
    (differentiable_logPartition s a).continuous ?_
  rw [deriv_logPartition_eq s a]
  refine strictMono_of_deriv_pos fun c => ?_
  rw [deriv_meanScore c s a]
  exact varScore_pos_of_ne hab

/-- The convexity inequality, spelled out on a convex combination of two inverse
temperatures. -/
theorem logPartition_convex_comb (s : Fin m → ℝ) (i : Fin m) (b c t u : ℝ)
    (ht : 0 ≤ t) (hu : 0 ≤ u) (htu : t + u = 1) :
    logPartition (t * b + u * c) s ≤ t * logPartition b s + u * logPartition c s :=
  (convexOn_logPartition s i).2 (Set.mem_univ b) (Set.mem_univ c) ht hu htu

/-! ## The variational (Legendre) description -/

/-- **`log Z(β)` is the maximum of `β⟨s⟩_p + H(p)` over probability vectors `p`,**
attained at the Softmax distribution: the Legendre-dual form of the maximum-entropy
principle. -/
theorem logPartition_isGreatest (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    IsGreatest {x : ℝ | ∃ p : Fin m → ℝ, (∀ j, 0 ≤ p j) ∧ (∑ j, p j) = 1 ∧
        x = beta * (∑ j, p j * s j) + shannonEntropy p} (logPartition beta s) := by
  constructor
  · refine ⟨scoreSoftmax beta s, fun j => scoreSoftmax_nonneg beta s j,
      scoreSoftmax_sum_one beta s i, ?_⟩
    have := softmax_free_energy_eq beta s i
    linarith
  · rintro x ⟨p, hp0, hpsum, rfl⟩
    have := softmax_free_energy_le beta s i hp0 hpsum
    linarith

end BookProof.ChapterLogPartitionConvex

end
