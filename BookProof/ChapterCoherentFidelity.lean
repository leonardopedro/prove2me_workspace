import Mathlib
import BookProof.ChapterCoherentOverlapComplex
import BookProof.ChapterCoherentGeometry

/-!
# Chapter "The Coherent State of Attention" — the **quantum fidelity** of coherent
states

`Book/CoherentState.lean` §"Temperature and the Thermal Bath" phrases the
comparison of two wave-packets as a *fidelity*: the probability that a
measurement prepared in the state `|q⟩` is found in the state `|k⟩`.  For pure
states this is `F(q,k) = |⟨q|k⟩|²`, which is exactly the Born numerator
`ChapterCoherentOverlapComplex.bornNumerC` of the attention weight.

This module proves the closed form of that fidelity for **complex** coherent-state
parameters and the properties the prose uses:

* `fidelityC_eq_exp_neg_dist_sq` — the **headline**: the fidelity of two coherent
  states is `exp (-‖q - k‖²)`, a pure function of the distance between the two
  displacement parameters.  The phase of the Bargmann kernel has dropped out and
  so have the individual norms;
* `fidelityC_symm`, `fidelityC_pos`, `fidelityC_le_one`, `fidelityC_self`,
  `fidelityC_eq_one_iff` — the fidelity is a symmetric, strictly positive
  quantity bounded by `1`, attaining `1` exactly on equal parameters;
* `fidelityC_translation_invariant` — displacing *both* states by the same vector
  leaves the fidelity unchanged: the fidelity of two displaced states depends only
  on the relative displacement.  This is the formal content of "the packet is
  rigid and only its centre moves";
* `fidelityC_le_iff_dist_le`, `fidelityC_lt_iff_dist_lt` — the fidelity is
  strictly antitone in the distance;
* `bornWeightC_eq_scoreSoftmax_neg_dist_sq` — the complex Born attention weight is
  the Softmax over minus the squared distances at inverse temperature `1`; i.e.
  **attention is the normalized fidelity**, `bornWeightC_eq_fidelity_normalized`;
* `fidelityC_ofReal` — the real theory of `ChapterCoherentGeometry` is the
  restriction of this one to real parameters.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterCoherentFidelity

open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

/-! ## The fidelity and its closed form -/

/-- The **quantum fidelity** of two (complex) coherent states: the Born
probability `|⟨q|k⟩|²`. -/
def fidelityC (q k : EuclideanSpace ℂ (Fin n)) : ℝ := ‖coherentOverlapC q k‖ ^ 2

/-- The fidelity *is* the Born numerator of the attention weight. -/
theorem fidelityC_eq_bornNumerC (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = bornNumerC q k := rfl

/-- **The fidelity of two coherent states is `exp (-‖q - k‖²)`.**  It is a pure
function of the distance between the displacement parameters: the Bargmann phase
and the individual norms both cancel. -/
theorem fidelityC_eq_exp_neg_dist_sq (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = Real.exp (-‖q - k‖ ^ 2) := by
  have hdist : ‖q - k‖ ^ 2 = ‖q‖ ^ 2 - 2 * (inner ℂ q k : ℂ).re + ‖k‖ ^ 2 := by
    simpa using norm_sub_sq (𝕜 := ℂ) q k
  rw [fidelityC_eq_bornNumerC, bornNumerC_eq, ← Real.exp_add, ← Real.exp_add, hdist]
  congr 1
  ring

theorem fidelityC_pos (q k : EuclideanSpace ℂ (Fin n)) : 0 < fidelityC q k := by
  rw [fidelityC_eq_exp_neg_dist_sq]; exact Real.exp_pos _

/-- The fidelity is symmetric. -/
theorem fidelityC_symm (q k : EuclideanSpace ℂ (Fin n)) : fidelityC q k = fidelityC k q := by
  rw [fidelityC_eq_exp_neg_dist_sq, fidelityC_eq_exp_neg_dist_sq, norm_sub_rev]

/-- A coherent state has fidelity `1` with itself. -/
theorem fidelityC_self (q : EuclideanSpace ℂ (Fin n)) : fidelityC q q = 1 := by
  rw [fidelityC_eq_exp_neg_dist_sq]
  simp

theorem fidelityC_le_one (q k : EuclideanSpace ℂ (Fin n)) : fidelityC q k ≤ 1 := by
  rw [fidelityC_eq_exp_neg_dist_sq, Real.exp_le_one_iff, neg_nonpos]
  positivity

/-- **The fidelity separates coherent states**: it equals `1` exactly when the two
displacement parameters agree. -/
theorem fidelityC_eq_one_iff (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = 1 ↔ q = k := by
  rw [fidelityC_eq_exp_neg_dist_sq, Real.exp_eq_one_iff, neg_eq_zero,
    pow_eq_zero_iff (two_ne_zero), norm_eq_zero, sub_eq_zero]

/-- **Displacement invariance.**  Displacing both coherent states by the same
vector leaves the fidelity unchanged: only the relative displacement matters. -/
theorem fidelityC_translation_invariant (q k v : EuclideanSpace ℂ (Fin n)) :
    fidelityC (q + v) (k + v) = fidelityC q k := by
  rw [fidelityC_eq_exp_neg_dist_sq, fidelityC_eq_exp_neg_dist_sq]
  congr 2
  rw [show q + v - (k + v) = q - k from by abel]

/-! ## The fidelity is a strictly decreasing readout of the distance -/

theorem fidelityC_le_iff_dist_le (q k k' : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k ≤ fidelityC q k' ↔ ‖q - k'‖ ≤ ‖q - k‖ := by
  rw [fidelityC_eq_exp_neg_dist_sq, fidelityC_eq_exp_neg_dist_sq, Real.exp_le_exp,
    neg_le_neg_iff]
  constructor
  · intro h; nlinarith [norm_nonneg (q - k), norm_nonneg (q - k')]
  · intro h; nlinarith [norm_nonneg (q - k), norm_nonneg (q - k')]

theorem fidelityC_lt_iff_dist_lt (q k k' : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k < fidelityC q k' ↔ ‖q - k'‖ < ‖q - k‖ := by
  rw [← not_le, ← not_le, fidelityC_le_iff_dist_le]

/-- Taking `- log` of the fidelity returns the squared distance: the fidelity is a
lossless metric readout. -/
theorem neg_log_fidelityC (q k : EuclideanSpace ℂ (Fin n)) :
    -Real.log (fidelityC q k) = ‖q - k‖ ^ 2 := by
  rw [fidelityC_eq_exp_neg_dist_sq, Real.log_exp, neg_neg]

/-! ## Attention is the normalized fidelity -/

/-- **The complex Born attention weight is the Softmax over minus the squared
distances**, at inverse temperature `1`. -/
theorem bornWeightC_eq_scoreSoftmax_neg_dist_sq (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC q k j = scoreSoftmax 1 (fun l => -‖q - k l‖ ^ 2) j := by
  rw [bornWeightC, scoreSoftmax]
  simp only [one_mul]
  rw [← fidelityC_eq_bornNumerC, fidelityC_eq_exp_neg_dist_sq]
  refine congrArg _ (Finset.sum_congr rfl fun l _ => ?_)
  rw [← fidelityC_eq_bornNumerC, fidelityC_eq_exp_neg_dist_sq]

/-- **Attention is the normalized fidelity.** -/
theorem bornWeightC_eq_fidelity_normalized (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC q k j = fidelityC q (k j) / ∑ l, fidelityC q (k l) := rfl

/-! ## The real case -/

/-- At real parameters the complex fidelity is the real Born numerator of
`ChapterCoherentGeometry`. -/
theorem fidelityC_ofReal (q k : EuclideanSpace ℝ (Fin n)) :
    fidelityC (ofRealVec q) (ofRealVec k) = Real.exp (-‖q - k‖ ^ 2) := by
  rw [fidelityC_eq_bornNumerC, bornNumerC_ofReal,
    BookProof.ChapterCoherentGeometry.bornNumer_eq_exp_neg_dist_sq]

end BookProof.ChapterCoherentFidelity

end
