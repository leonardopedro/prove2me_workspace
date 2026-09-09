import Mathlib
import BookProof.ChapterAttentionOutput
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention": many heads are one mixture

A transformer layer runs several attention heads in parallel and combines them.
Probabilistically, a bank of heads read by a common set of values is a **mixture**
of the individual attention distributions, and this module proves the three facts
that make the mixture picture work.

* `mixture_isProb` — a convex combination of attention distributions is again an
  attention distribution (a probability vector over the keys).
* `observableExpectation_mixture` — **the ensemble output is the weighted mean of
  the head outputs**: combining the heads' distributions first and reading the
  values once is the same as reading the values head by head and averaging.  This
  is why the "concatenate then project" construction of multi-head attention is
  legitimate.
* `le_shannonEntropy_mixture` — **mixing heads never destroys information.**  By
  concavity of `x ↦ -x log x`, the entropy of the mixture is at least the mean of
  the head entropies: a bank of confident but disagreeing heads produces an
  uncertain consensus, never the reverse.

The multi-head specializations `multiHead_output_eq_mean` and
`le_shannonEntropy_multiHead` apply all three to the Softmax heads of
`ChapterSoftmaxSharpness` — heads may differ both in their scores and in their
temperatures.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionMixture

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterObservableExpectation BookProof.ChapterAttentionOutput
  BookProof.ChapterAttentionEntropy

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The mixture of a bank of attention distributions -/

/-- The mixture of the distributions `p h` with mixing weights `w h`. -/
def mixture (w : Fin H → ℝ) (p : Fin H → Fin m → ℝ) (j : Fin m) : ℝ := ∑ h, w h * p h j

theorem mixture_nonneg {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw : ∀ h, 0 ≤ w h)
    (hp : ∀ h j, 0 ≤ p h j) (j : Fin m) : 0 ≤ mixture w p j :=
  Finset.sum_nonneg fun h _ => mul_nonneg (hw h) (hp h j)

theorem mixture_sum_one {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw : ∑ h, w h = 1)
    (hp : ∀ h, ∑ j, p h j = 1) : ∑ j, mixture w p j = 1 := by
  simp only [mixture]
  rw [Finset.sum_comm]
  calc ∑ h, ∑ j, w h * p h j = ∑ h, w h := by
        refine Finset.sum_congr rfl fun h _ => ?_
        rw [← Finset.mul_sum, hp h, mul_one]
    _ = 1 := hw

/-- **A mixture of attention distributions is an attention distribution.** -/
theorem mixture_isProb {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw0 : ∀ h, 0 ≤ w h)
    (hw : ∑ h, w h = 1) (hp0 : ∀ h j, 0 ≤ p h j) (hp : ∀ h, ∑ j, p h j = 1) :
    (∀ j, 0 ≤ mixture w p j) ∧ ∑ j, mixture w p j = 1 :=
  ⟨fun j => mixture_nonneg hw0 hp0 j, mixture_sum_one hw hp⟩

/-! ## The output of the ensemble -/

/-- **The ensemble output is the weighted mean of the head outputs.** -/
theorem observableExpectation_mixture (w : Fin H → ℝ) (p : Fin H → Fin m → ℝ)
    (v : Fin m → E) :
    observableExpectation (mixture w p) v = ∑ h, w h • observableExpectation (p h) v := by
  rw [observableExpectation]
  have hterm : ∀ j : Fin m, mixture w p j • v j = ∑ h, w h • (p h j • v j) := by
    intro j
    rw [mixture, Finset.sum_smul]
    exact Finset.sum_congr rfl fun h _ => by rw [mul_smul]
  rw [Finset.sum_congr rfl (fun j _ => hterm j), Finset.sum_comm]
  refine Finset.sum_congr rfl fun h _ => ?_
  rw [observableExpectation, Finset.smul_sum]

/-! ## Mixing heads never destroys information -/

/-- The Shannon entropy is the sum of `Real.negMulLog` over the weights. -/
theorem shannonEntropy_eq_sum_negMulLog (p : Fin m → ℝ) :
    shannonEntropy p = ∑ j, Real.negMulLog (p j) := by
  rw [shannonEntropy, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [Real.negMulLog]; ring

/-- **Concavity of the entropy, pointwise in a key.** -/
theorem le_negMulLog_mixture {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw0 : ∀ h, 0 ≤ w h)
    (hw : ∑ h, w h = 1) (hp0 : ∀ h j, 0 ≤ p h j) (j : Fin m) :
    ∑ h, w h * Real.negMulLog (p h j) ≤ Real.negMulLog (mixture w p j) := by
  have h := Real.concaveOn_negMulLog.le_map_sum (t := (Finset.univ : Finset (Fin H)))
    (w := w) (p := fun h => p h j) (fun h _ => hw0 h) hw (fun h _ => hp0 h j)
  simpa [mixture, smul_eq_mul] using h

/-- **Mixing heads never destroys information**: the entropy of the mixture is at
least the mean of the head entropies. -/
theorem le_shannonEntropy_mixture {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ}
    (hw0 : ∀ h, 0 ≤ w h) (hw : ∑ h, w h = 1) (hp0 : ∀ h j, 0 ≤ p h j) :
    ∑ h, w h * shannonEntropy (p h) ≤ shannonEntropy (mixture w p) := by
  have hleft : ∑ h, w h * shannonEntropy (p h)
      = ∑ j, ∑ h, w h * Real.negMulLog (p h j) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun h _ => ?_
    rw [shannonEntropy_eq_sum_negMulLog, Finset.mul_sum]
  rw [hleft, shannonEntropy_eq_sum_negMulLog]
  exact Finset.sum_le_sum fun j _ => le_negMulLog_mixture hw0 hw hp0 j

/-! ## Multi-head attention -/

/-- The attention distribution of a bank of Softmax heads: head `h` has its own
scores `s h` and its own inverse temperature `beta h`. -/
def multiHead (w : Fin H → ℝ) (beta : Fin H → ℝ) (s : Fin H → Fin m → ℝ) :
    Fin m → ℝ :=
  mixture w (fun h => scoreSoftmax (beta h) (s h))

/-- The multi-head distribution is a probability distribution over the keys. -/
theorem multiHead_isProb {w : Fin H → ℝ} (hw0 : ∀ h, 0 ≤ w h) (hw : ∑ h, w h = 1)
    (beta : Fin H → ℝ) (s : Fin H → Fin m → ℝ) (j₀ : Fin m) :
    (∀ j, 0 ≤ multiHead w beta s j) ∧ ∑ j, multiHead w beta s j = 1 :=
  mixture_isProb hw0 hw (fun h j => scoreSoftmax_nonneg (beta h) (s h) j)
    (fun h => scoreSoftmax_sum_one (beta h) (s h) j₀)

/-- **HEADLINE — multi-head attention is the weighted mean of its heads.** -/
theorem multiHead_output_eq_mean (w : Fin H → ℝ) (beta : Fin H → ℝ)
    (s : Fin H → Fin m → ℝ) (v : Fin m → E) :
    observableExpectation (multiHead w beta s) v
      = ∑ h, w h • headOutput (beta h) (s h) v :=
  observableExpectation_mixture w (fun h => scoreSoftmax (beta h) (s h)) v

/-- **A bank of heads is never more certain than its heads are on average.** -/
theorem le_shannonEntropy_multiHead {w : Fin H → ℝ} (hw0 : ∀ h, 0 ≤ w h) (hw : ∑ h, w h = 1)
    (beta : Fin H → ℝ) (s : Fin H → Fin m → ℝ) :
    ∑ h, w h * shannonEntropy (scoreSoftmax (beta h) (s h))
      ≤ shannonEntropy (multiHead w beta s) :=
  le_shannonEntropy_mixture hw0 hw (fun h j => scoreSoftmax_nonneg (beta h) (s h) j)

end BookProof.ChapterAttentionMixture

end
