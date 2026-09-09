import Mathlib
import BookProof.ChapterSoftmaxMaxEntropy

/-!
# Chapter "The Coherent State of Attention" — the entropy is antitone in the
inverse temperature

`ChapterAttentionEntropy` computes the two endpoints of the attention entropy:
it is `log m` at `β = 0` (maximal ignorance) and tends to `0` as `β → ∞` (the
argmax collapse).  `ChapterSoftmaxFluctuation` supplies the response laws.  This
module joins the two ends by differentiating the entropy itself.

* `attentionEntropy` `H(β) = H(scoreSoftmax β s)` and the thermodynamic identity
  `attentionEntropy_eq` : `H(β) = log Z(β) − β⟨s⟩_β`;
* `hasDerivAt_attentionEntropy` — **the headline**: `dH/dβ = −β · Var_β(s)`;
* `heatCapacity` `C(β) = β² · Var_β(s)` and
  `hasDerivAt_attentionEntropy_neg_heatCapacity` — the standard
  `dH/d log(1/β)`-style reading: the response of the entropy is the (nonnegative)
  heat capacity divided by `−β`;
* `attentionEntropy_antitoneOn` — consequently the attention entropy is
  **non-increasing** on `β ≥ 0`: sharpening attention can only destroy entropy;
* `attentionEntropy_le_at_zero` — every positive temperature parameter gives at
  most the `β = 0` entropy, which `ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_zero`
  identifies with `log m`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterEntropyTemperature

open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxFluctuation BookProof.ChapterSoftmaxMaxEntropy

variable {m : ℕ}

/-- The **attention entropy** as a function of the inverse temperature. -/
def attentionEntropy (beta : ℝ) (s : Fin m → ℝ) : ℝ := shannonEntropy (scoreSoftmax beta s)

/-- The thermodynamic identity `H(β) = log Z(β) − β⟨s⟩_β`. -/
theorem attentionEntropy_eq (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    attentionEntropy beta s = logPartition beta s - beta * meanScore beta s :=
  shannonEntropy_scoreSoftmax beta s i

/-- **The entropy response law**: `dH/dβ = −β · Var_β(s)`. -/
theorem hasDerivAt_attentionEntropy (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun b : ℝ => attentionEntropy b s) (-(beta * varScore beta s)) beta := by
  have hrepr : (fun b : ℝ => attentionEntropy b s)
      = fun b : ℝ => logPartition b s - b * meanScore b s :=
    funext fun b => attentionEntropy_eq b s i
  rw [hrepr]
  have hlog := hasDerivAt_logPartition beta s i
  have hmean := hasDerivAt_meanScore beta s i
  have hprod : HasDerivAt (fun b : ℝ => b * meanScore b s)
      (1 * meanScore beta s + beta * varScore beta s) beta := by
    simpa using (hasDerivAt_id beta).mul hmean
  have := hlog.sub hprod
  refine this.congr_deriv ?_
  ring

/-- The **heat capacity** `C(β) = β²·Var_β(s)` of the attention head. -/
def heatCapacity (beta : ℝ) (s : Fin m → ℝ) : ℝ := beta ^ 2 * varScore beta s

theorem heatCapacity_nonneg (beta : ℝ) (s : Fin m → ℝ) : 0 ≤ heatCapacity beta s :=
  mul_nonneg (sq_nonneg _) (varScore_nonneg beta s)

/-- For `β ≠ 0` the entropy response is `−C(β)/β`. -/
theorem hasDerivAt_attentionEntropy_neg_heatCapacity {beta : ℝ} (hbeta : beta ≠ 0)
    (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun b : ℝ => attentionEntropy b s) (-(heatCapacity beta s / beta)) beta := by
  refine (hasDerivAt_attentionEntropy beta s i).congr_deriv ?_
  rw [heatCapacity]
  field_simp

/-- **Sharpening attention destroys entropy.**  The attention entropy is
non-increasing in the inverse temperature on `β ≥ 0`. -/
theorem attentionEntropy_antitoneOn (s : Fin m → ℝ) (i : Fin m) :
    AntitoneOn (fun b : ℝ => attentionEntropy b s) (Set.Ici (0 : ℝ)) := by
  have hdiff : Differentiable ℝ fun b : ℝ => attentionEntropy b s := fun b =>
    (hasDerivAt_attentionEntropy b s i).differentiableAt
  refine antitoneOn_of_deriv_nonpos (convex_Ici 0) hdiff.continuous.continuousOn
    (hdiff.differentiableOn.mono interior_subset) fun b hb => ?_
  have hb0 : (0 : ℝ) ≤ b := le_of_lt (by simpa using hb)
  rw [(hasDerivAt_attentionEntropy b s i).deriv, neg_nonpos]
  exact mul_nonneg hb0 (varScore_nonneg b s)

/-- Every nonnegative inverse temperature gives at most the `β = 0` entropy. -/
theorem attentionEntropy_le_at_zero (s : Fin m → ℝ) (i : Fin m) {beta : ℝ}
    (hbeta : 0 ≤ beta) : attentionEntropy beta s ≤ attentionEntropy 0 s :=
  attentionEntropy_antitoneOn s i (Set.self_mem_Ici) (Set.mem_Ici.2 hbeta) hbeta

/-- Combined with `ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_zero`: the
attention entropy is bounded by `log m` for every nonnegative `β`, with the bound
attained exactly at infinite temperature. -/
theorem attentionEntropy_le_log_card (s : Fin m → ℝ) (i : Fin m) {beta : ℝ}
    (hbeta : 0 ≤ beta) : attentionEntropy beta s ≤ Real.log m := by
  have hm : 0 < m := Fin.pos i
  have h0 : attentionEntropy 0 s = Real.log m := shannonEntropy_scoreSoftmax_zero s hm
  exact (attentionEntropy_le_at_zero s i hbeta).trans_eq h0

end BookProof.ChapterEntropyTemperature

end
