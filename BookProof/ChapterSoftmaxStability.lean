import Mathlib
import BookProof.ChapterSoftmaxMaxEntropy

/-!
# Chapter "The Coherent State of Attention" — stability of attention under score
perturbations

An attention head is only useful if a small error in the alignment scores produces
a small change in the weights it assigns.  This module proves exactly that, in
multiplicative (and hence in additive) form: if every score moves by at most `d`,
then every attention weight changes by a factor of at most `exp (2|β| d)`.

* `partition_le_of_dist_le` — `Z(β, s) ≤ exp (|β| d) · Z(β, t)`;
* `abs_logPartition_sub_le` — the free energy is `|β|`-Lipschitz in the scores for
  the sup distance;
* `abs_log_scoreSoftmax_sub_le` — **the headline**:
  `|log pⱼ(s) − log pⱼ(t)| ≤ 2|β| d`;
* `scoreSoftmax_le_mul` and `abs_scoreSoftmax_sub_le` — the multiplicative and
  additive stability bounds for the attention weights themselves.

The `2` is the honest constant: the score of the key moves, and so does the
normalizing free energy.  At `β = 0` the bounds degenerate to the (correct)
statement that uniform attention does not move at all.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxStability

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxFluctuation BookProof.ChapterSoftmaxMaxEntropy

variable {m : ℕ}

/-! ## Stability of the partition function -/

/-- If every score moves by at most `d`, the partition function changes by a factor
of at most `exp (|β| d)`. -/
theorem partition_le_of_dist_le (beta : ℝ) {s t : Fin m → ℝ} {d : ℝ}
    (hd : ∀ l, |s l - t l| ≤ d) :
    partition beta s ≤ Real.exp (|beta| * d) * partition beta t := by
  have hterm : ∀ l : Fin m,
      Real.exp (beta * s l) ≤ Real.exp (|beta| * d) * Real.exp (beta * t l) := by
    intro l
    rw [← Real.exp_add, Real.exp_le_exp]
    have h1 : beta * (s l - t l) ≤ |beta| * d := by
      calc beta * (s l - t l) ≤ |beta * (s l - t l)| := le_abs_self _
        _ = |beta| * |s l - t l| := abs_mul _ _
        _ ≤ |beta| * d := mul_le_mul_of_nonneg_left (hd l) (abs_nonneg beta)
    nlinarith [h1]
  calc partition beta s ≤ ∑ l, Real.exp (|beta| * d) * Real.exp (beta * t l) :=
        Finset.sum_le_sum fun l _ => hterm l
    _ = Real.exp (|beta| * d) * partition beta t := by rw [← Finset.mul_sum]; rfl

/-- The free energy is `|β|`-Lipschitz in the scores for the sup distance. -/
theorem abs_logPartition_sub_le (beta : ℝ) {s t : Fin m → ℝ} {d : ℝ} (i : Fin m)
    (hd : ∀ l, |s l - t l| ≤ d) :
    |logPartition beta s - logPartition beta t| ≤ |beta| * d := by
  have hbound : ∀ u v : Fin m → ℝ, (∀ l, |u l - v l| ≤ d) →
      logPartition beta u - logPartition beta v ≤ |beta| * d := by
    intro u v huv
    have hle := partition_le_of_dist_le beta huv
    have hposu : 0 < partition beta u := partition_pos beta u i
    have hposv : 0 < partition beta v := partition_pos beta v i
    have hlog : Real.log (partition beta u)
        ≤ Real.log (Real.exp (|beta| * d) * partition beta v) :=
      Real.log_le_log hposu hle
    rw [Real.log_mul (Real.exp_ne_zero _) (ne_of_gt hposv), Real.log_exp] at hlog
    simpa [logPartition] using hlog
  have hsymm : ∀ l, |t l - s l| ≤ d := by
    intro l; rw [abs_sub_comm]; exact hd l
  exact abs_sub_le_iff.2 ⟨hbound s t hd, hbound t s hsymm⟩

/-! ## Stability of the attention weights -/

/-- **The attention weights are stable in the log scale**: if every score moves by
at most `d`, then every log-weight moves by at most `2|β| d`. -/
theorem abs_log_scoreSoftmax_sub_le (beta : ℝ) {s t : Fin m → ℝ} {d : ℝ} (j : Fin m)
    (hd : ∀ l, |s l - t l| ≤ d) :
    |Real.log (scoreSoftmax beta s j) - Real.log (scoreSoftmax beta t j)|
      ≤ 2 * (|beta| * d) := by
  have hZ := abs_logPartition_sub_le beta j hd
  have hs : |beta * s j - beta * t j| ≤ |beta| * d := by
    rw [← mul_sub, abs_mul]
    exact mul_le_mul_of_nonneg_left (hd j) (abs_nonneg beta)
  rw [log_scoreSoftmax, log_scoreSoftmax]
  calc |beta * s j - logPartition beta s - (beta * t j - logPartition beta t)|
      = |(beta * s j - beta * t j) + (logPartition beta t - logPartition beta s)| := by
        ring_nf
    _ ≤ |beta * s j - beta * t j| + |logPartition beta t - logPartition beta s| :=
        abs_add_le _ _
    _ ≤ |beta| * d + |beta| * d := by
        have : |logPartition beta t - logPartition beta s| ≤ |beta| * d := by
          rw [abs_sub_comm]; exact hZ
        linarith
    _ = 2 * (|beta| * d) := by ring

/-- **The multiplicative stability bound**: the attention weight of a key changes by
at most the factor `exp (2|β| d)`. -/
theorem scoreSoftmax_le_mul (beta : ℝ) {s t : Fin m → ℝ} {d : ℝ} (j : Fin m)
    (hd : ∀ l, |s l - t l| ≤ d) :
    scoreSoftmax beta s j ≤ Real.exp (2 * (|beta| * d)) * scoreSoftmax beta t j := by
  have hps : 0 < scoreSoftmax beta s j := scoreSoftmax_pos beta s j
  have hpt : 0 < scoreSoftmax beta t j := scoreSoftmax_pos beta t j
  have habs := abs_log_scoreSoftmax_sub_le beta j hd
  have hlog : Real.log (scoreSoftmax beta s j)
      ≤ 2 * (|beta| * d) + Real.log (scoreSoftmax beta t j) := by
    have := (abs_sub_le_iff.1 habs).1; linarith
  have := Real.exp_le_exp.2 hlog
  rwa [Real.exp_log hps, Real.exp_add, Real.exp_log hpt] at this

/-- **The additive stability bound**: attention weights are continuous in the
scores, with the explicit modulus `exp (2|β| d) − 1`. -/
theorem abs_scoreSoftmax_sub_le (beta : ℝ) {s t : Fin m → ℝ} {d : ℝ} (j : Fin m)
    (hd : ∀ l, |s l - t l| ≤ d) :
    |scoreSoftmax beta s j - scoreSoftmax beta t j| ≤ Real.exp (2 * (|beta| * d)) - 1 := by
  have hsymm : ∀ l, |t l - s l| ≤ d := by
    intro l; rw [abs_sub_comm]; exact hd l
  have h1 := scoreSoftmax_le_mul beta j hd
  have h2 := scoreSoftmax_le_mul beta (s := t) (t := s) j hsymm
  have hs1 : scoreSoftmax beta s j ≤ 1 := scoreSoftmax_le_one beta s j
  have ht1 : scoreSoftmax beta t j ≤ 1 := scoreSoftmax_le_one beta t j
  have hs0 : 0 ≤ scoreSoftmax beta s j := scoreSoftmax_nonneg beta s j
  have ht0 : 0 ≤ scoreSoftmax beta t j := scoreSoftmax_nonneg beta t j
  have hE : 1 ≤ Real.exp (2 * (|beta| * d)) := by
    refine Real.one_le_exp ?_
    have hd0 : 0 ≤ d := le_trans (abs_nonneg _) (hd j)
    positivity
  refine abs_sub_le_iff.2 ⟨?_, ?_⟩
  · nlinarith [h1, ht1, ht0]
  · nlinarith [h2, hs1, hs0]

/-- Identical scores give identical attention: the stability bound is sharp at
`d = 0`. -/
theorem scoreSoftmax_congr (beta : ℝ) {s t : Fin m → ℝ} (j : Fin m)
    (hst : ∀ l, s l = t l) : scoreSoftmax beta s j = scoreSoftmax beta t j := by
  simp only [scoreSoftmax, hst]

end BookProof.ChapterSoftmaxStability

end
