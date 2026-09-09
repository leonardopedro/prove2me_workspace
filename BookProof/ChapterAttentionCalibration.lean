import Mathlib
import BookProof.ChapterEntropyTemperature

/-!
# Chapter "The Coherent State of Attention": the entropy fixes the temperature

`ChapterEntropyTemperature` shows that sharpening a head destroys entropy:
`dH/dβ = −β·Var_β(s)`, so `H` is non-increasing on `β ≥ 0`.  This module upgrades
that monotonicity to a **calibration** statement: as long as the head's scores are
not all equal, the entropy is a *strictly* decreasing, continuous function of the
inverse temperature, so a target entropy level determines the temperature that
achieves it, uniquely.

* `continuous_attentionEntropy` — `β ↦ H(β)` is continuous (indeed differentiable);
* `attentionEntropy_strictAntiOn` — and strictly decreasing on `β ≥ 0` once two
  scores differ;
* `attentionEntropy_injOn` — hence injective there: two different temperatures
  never produce the same attention entropy;
* `exists_beta_attentionEntropy_eq` — every entropy level between `H(B)` and the
  maximal value `log m` is attained by some `β ∈ [0, B]`;
* **`existsUnique_beta_attentionEntropy_eq`** — the headline: that `β` is unique, so
  "set the entropy of this head to `h`" is a well-posed instruction.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionCalibration

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxFluctuation BookProof.ChapterAttentionEntropy
  BookProof.ChapterEntropyTemperature

variable {m : ℕ}

/-! ## Regularity of the entropy curve -/

theorem differentiable_attentionEntropy (s : Fin m → ℝ) (i : Fin m) :
    Differentiable ℝ fun b : ℝ => attentionEntropy b s := fun b =>
  (hasDerivAt_attentionEntropy b s i).differentiableAt

theorem continuous_attentionEntropy (s : Fin m → ℝ) (i : Fin m) :
    Continuous fun b : ℝ => attentionEntropy b s :=
  (differentiable_attentionEntropy s i).continuous

/-! ## Strict monotonicity -/

/-- **Cooling a non-degenerate head strictly destroys entropy.** -/
theorem attentionEntropy_strictAntiOn {s : Fin m → ℝ} {a b : Fin m} (hab : s a ≠ s b) :
    StrictAntiOn (fun x : ℝ => attentionEntropy x s) (Set.Ici (0 : ℝ)) := by
  have hdiff := differentiable_attentionEntropy s a
  refine strictAntiOn_of_deriv_neg (convex_Ici 0) hdiff.continuous.continuousOn
    fun x hx => ?_
  have hx0 : (0 : ℝ) < x := by simpa using hx
  rw [(hasDerivAt_attentionEntropy x s a).deriv, neg_neg_iff_pos]
  exact mul_pos hx0 (varScore_pos_of_ne hab)

/-- Two different (non-negative) temperatures never give the same entropy. -/
theorem attentionEntropy_injOn {s : Fin m → ℝ} {a b : Fin m} (hab : s a ≠ s b) :
    Set.InjOn (fun x : ℝ => attentionEntropy x s) (Set.Ici (0 : ℝ)) :=
  (attentionEntropy_strictAntiOn hab).injOn

/-! ## Calibration -/

/-- **Every achievable entropy level is achieved.**  For `B ≥ 0`, each value between
`H(B)` and the maximal entropy `log m = H(0)` is the entropy of the head at some
inverse temperature in `[0, B]`. -/
theorem exists_beta_attentionEntropy_eq (s : Fin m → ℝ) (i : Fin m) {B h : ℝ}
    (hB : 0 ≤ B) (hlow : attentionEntropy B s ≤ h) (hhigh : h ≤ Real.log m) :
    ∃ beta ∈ Set.Icc (0 : ℝ) B, attentionEntropy beta s = h := by
  have hm : 0 < m := Fin.pos i
  have h0 : attentionEntropy 0 s = Real.log m := shannonEntropy_scoreSoftmax_zero s hm
  have hcont : ContinuousOn (fun x : ℝ => attentionEntropy x s) (Set.Icc 0 B) :=
    (continuous_attentionEntropy s i).continuousOn
  have hmem : h ∈ Set.Icc (attentionEntropy B s) (attentionEntropy 0 s) :=
    ⟨hlow, by rw [h0]; exact hhigh⟩
  obtain ⟨beta, hbeta, hval⟩ := intermediate_value_Icc' hB hcont hmem
  exact ⟨beta, hbeta, hval⟩

/-- **HEADLINE — the entropy fixes the temperature.**  For a head whose scores are
not all equal, each achievable entropy level is achieved at exactly one inverse
temperature in `[0, B]`. -/
theorem existsUnique_beta_attentionEntropy_eq {s : Fin m → ℝ} {a b : Fin m}
    (hab : s a ≠ s b) {B h : ℝ} (hB : 0 ≤ B) (hlow : attentionEntropy B s ≤ h)
    (hhigh : h ≤ Real.log m) :
    ∃! beta : ℝ, beta ∈ Set.Icc (0 : ℝ) B ∧ attentionEntropy beta s = h := by
  obtain ⟨beta, hbeta, hval⟩ := exists_beta_attentionEntropy_eq s a hB hlow hhigh
  refine ⟨beta, ⟨hbeta, hval⟩, ?_⟩
  rintro gamma ⟨hgamma, hgval⟩
  have hEq : attentionEntropy gamma s = attentionEntropy beta s := by rw [hgval, hval]
  exact attentionEntropy_injOn hab (Set.mem_Ici.2 hgamma.1) (Set.mem_Ici.2 hbeta.1) hEq

end BookProof.ChapterAttentionCalibration

end
