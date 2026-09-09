import Mathlib
import BookProof.ChapterSoftmaxBorn

/-!
# Chapter "The Coherent State of Attention", §"The Divergence: Classical
Sharpness versus Quantum Flatness"

The opening section of `Book/CoherentState.lean` contrasts two candidate
attention rules on *classical points*:

* the **amplitude-squared (naive Born) rule**
  `P(q → k_j) = |⟪q,k_j⟫|² / ∑_l |⟪q,k_l⟫|²`, described as a "flat, polynomial
  curve"; and
* **Softmax**, `exp(β⟪q,k_j⟫) / ∑_l exp(β⟪q,k_l⟫)`, described as "sharp,
  winner-takes-all";

and it resolves the dichotomy by replacing the classical point with a coherent
state, where the Born rule *is* Softmax (`ChapterSoftmaxBorn`).  That section
carried no formal backing; this module supplies it, in the following precise
sense.

* `ampBorn_smul_query` — **flatness.**  The amplitude-squared rule is invariant
  under rescaling the query: `ampBorn (c • q) k = ampBorn q k` for every `c ≠ 0`.
  No amount of amplification sharpens it; in particular it has no temperature.
* `softmax_smul_query` — **sharpness is a temperature.**  Rescaling the query in
  Softmax is exactly a change of inverse temperature:
  `softmax β (c • q) k = softmax (β * c) q k`.
* `scoreSoftmax_zero` — at infinite temperature (`β = 0`) Softmax is the uniform
  distribution: maximal flatness.
* `tendsto_scoreSoftmax_max` / `tendsto_scoreSoftmax_ne` — **winner-takes-all.**
  If the scores have a strict maximizer `j`, then as `β → ∞` the Softmax weight
  of `j` tends to `1` and every other weight tends to `0`.
* `tendsto_coherentBorn_smul_query` — the resolution the chapter proposes, as a
  theorem: for keys of a common norm, the coherent-state Born weight of the
  strict maximizer tends to `1` as the query is amplified.  On coherent states
  the Born rule inherits Softmax's sharpening, which the classical
  amplitude-squared rule (`ampBorn_smul_query`) does not have.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxSharpness

open Filter Topology BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}

/-! ## The amplitude-squared rule is flat -/

/-- The **amplitude-squared (naive Born) attention rule** on classical points:
the dot products are read as probability amplitudes and normalized after
squaring. -/
def ampBorn (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (j : Fin m) : ℝ :=
  (inner ℝ q (k j)) ^ 2 / ∑ l, (inner ℝ q (k l)) ^ 2

theorem ampBorn_nonneg (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (j : Fin m) : 0 ≤ ampBorn q k j := by
  refine div_nonneg (sq_nonneg _) (Finset.sum_nonneg fun l _ => sq_nonneg _)

/-- **Flatness: the amplitude-squared rule has no temperature.**  Amplifying the
query by any nonzero factor leaves every weight unchanged — the "flat polynomial
curve" of the chapter cannot be sharpened. -/
theorem ampBorn_smul_query (c : ℝ) (hc : c ≠ 0) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    ampBorn (c • q) k j = ampBorn q k j := by
  have hinner : ∀ l, (inner ℝ (c • q) (k l) : ℝ) = c * inner ℝ q (k l) := fun l =>
    real_inner_smul_left _ _ _
  have hnum : (inner ℝ (c • q) (k j) : ℝ) ^ 2 = c ^ 2 * (inner ℝ q (k j)) ^ 2 := by
    rw [hinner]; ring
  have hden : ∑ l, (inner ℝ (c • q) (k l) : ℝ) ^ 2
      = c ^ 2 * ∑ l, (inner ℝ q (k l)) ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by rw [hinner]; ring
  rw [ampBorn, ampBorn, hnum, hden, mul_div_mul_left _ _ (pow_ne_zero 2 hc)]

/-! ## Softmax on abstract scores -/

/-- Softmax at inverse temperature `beta` applied directly to a family of real
scores. -/
def scoreSoftmax (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) : ℝ :=
  Real.exp (beta * s j) / ∑ l, Real.exp (beta * s l)

/-- The attention Softmax of `ChapterSoftmaxBorn` is the score Softmax of the
inner products. -/
theorem softmax_eq_scoreSoftmax (beta : ℝ) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    softmax beta q k j = scoreSoftmax beta (fun l => inner ℝ q (k l)) j := rfl

/-- **At infinite temperature Softmax is uniform** (`β = 0`): the flattest
possible distribution over `m` keys. -/
theorem scoreSoftmax_zero (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax 0 s j = 1 / m := by
  simp [scoreSoftmax]

/-- Softmax normalized against the score of `j`. -/
theorem scoreSoftmax_eq_inv_sum (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta s j = 1 / ∑ l, Real.exp (beta * (s l - s j)) := by
  have hfac : ∑ l, Real.exp (beta * s l)
      = Real.exp (beta * s j) * ∑ l, Real.exp (beta * (s l - s j)) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [← Real.exp_add]
    ring_nf
  rw [scoreSoftmax, hfac, mul_comm, ← div_div, div_self (Real.exp_ne_zero _)]

/-- **Sharpening is a change of temperature.**  Rescaling the query by `c` is
exactly multiplying the inverse temperature by `c`. -/
theorem softmax_smul_query (beta c : ℝ) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    softmax beta (c • q) k j = softmax (beta * c) q k j := by
  have hinner : ∀ l, (inner ℝ (c • q) (k l) : ℝ) = c * inner ℝ q (k l) := fun l =>
    real_inner_smul_left _ _ _
  have hexp : ∀ l, Real.exp (beta * inner ℝ (c • q) (k l))
      = Real.exp (beta * c * inner ℝ q (k l)) := by
    intro l
    rw [hinner]
    ring_nf
  rw [softmax, softmax, hexp j]
  exact congrArg _ (Finset.sum_congr rfl fun l _ => hexp l)

/-! ## The zero-temperature limit: winner-takes-all -/

theorem tendsto_exp_mul_neg (c : ℝ) (hc : c < 0) :
    Tendsto (fun b : ℝ => Real.exp (b * c)) atTop (𝓝 0) := by
  have h : Tendsto (fun b : ℝ => b * c) atTop atBot := by
    simpa using (tendsto_id (α := ℝ)).atTop_mul_const_of_neg hc
  exact Real.tendsto_exp_atBot.comp h

/-- The normalized Softmax denominator tends to `1` at zero temperature. -/
theorem tendsto_scoreSoftmax_denom (s : Fin m → ℝ) (j : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) :
    Tendsto (fun b : ℝ => ∑ l, Real.exp (b * (s l - s j))) atTop (𝓝 1) := by
  have h : Tendsto (fun b : ℝ => ∑ l, Real.exp (b * (s l - s j))) atTop
      (𝓝 (∑ l : Fin m, if l = j then (1 : ℝ) else 0)) := by
    refine tendsto_finset_sum _ fun l _ => ?_
    by_cases hl : l = j
    · subst hl
      simp
    · simpa [hl] using tendsto_exp_mul_neg (s l - s j) (by linarith [hmax l hl])
  simpa using h

/-- **Winner-takes-all.**  If `j` is the strict maximizer of the scores, its
Softmax weight tends to `1` as the temperature goes to zero. -/
theorem tendsto_scoreSoftmax_max (s : Fin m → ℝ) (j : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) :
    Tendsto (fun b : ℝ => scoreSoftmax b s j) atTop (𝓝 1) := by
  have h := (tendsto_scoreSoftmax_denom s j hmax).inv₀ (by norm_num)
  simpa [scoreSoftmax_eq_inv_sum, one_div] using h

/-- **Winner-takes-all, the losers.**  Every non-maximal weight tends to `0`. -/
theorem tendsto_scoreSoftmax_ne (s : Fin m → ℝ) (j i : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) (hi : i ≠ j) :
    Tendsto (fun b : ℝ => scoreSoftmax b s i) atTop (𝓝 0) := by
  have hnum : Tendsto (fun b : ℝ => Real.exp (b * (s i - s j))) atTop (𝓝 0) :=
    tendsto_exp_mul_neg _ (by linarith [hmax i hi])
  have hden := tendsto_scoreSoftmax_denom s j hmax
  have hquot := hnum.div hden (by norm_num)
  have heq : ∀ b : ℝ, scoreSoftmax b s i
      = Real.exp (b * (s i - s j)) / ∑ l, Real.exp (b * (s l - s j)) := by
    intro b
    have hfac : ∑ l, Real.exp (b * s l)
        = Real.exp (b * s j) * ∑ l, Real.exp (b * (s l - s j)) := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun l _ => ?_
      rw [← Real.exp_add]
      ring_nf
    rw [scoreSoftmax, hfac, show Real.exp (b * s i)
        = Real.exp (b * s j) * Real.exp (b * (s i - s j)) by rw [← Real.exp_add]; ring_nf,
      mul_div_mul_left _ _ (Real.exp_ne_zero _)]
  simpa [heq, zero_div] using hquot

/-! ## The resolution: the coherent Born rule does sharpen -/

/-- **The chapter's resolution, as a theorem.**  For keys of a common norm the
coherent-state Born weight equals Softmax at inverse temperature `2`
(`coherentBorn_eq_softmax`); amplifying the query therefore lowers the
temperature, and the weight of the strictly best-aligned key tends to `1`.  The
classical amplitude-squared rule of `ampBorn_smul_query` is, by contrast,
completely unaffected by the same amplification. -/
theorem tendsto_coherentBorn_smul_query (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r) (j : Fin m)
    (hmax : ∀ l, l ≠ j → (inner ℝ q (k l) : ℝ) < inner ℝ q (k j)) :
    Tendsto (fun c : ℝ => bornWeight (c • q) k j) atTop (𝓝 1) := by
  have hrewrite : ∀ c : ℝ, bornWeight (c • q) k j
      = scoreSoftmax (2 * c) (fun l => inner ℝ q (k l)) j := by
    intro c
    rw [coherentBorn_eq_softmax (c • q) k r hk j, softmax_smul_query,
      softmax_eq_scoreSoftmax]
  have hscale : Tendsto (fun c : ℝ => 2 * c) atTop atTop :=
    Filter.tendsto_id.const_mul_atTop (by norm_num)
  have hlim := (tendsto_scoreSoftmax_max (fun l => inner ℝ q (k l)) j hmax).comp hscale
  simpa [hrewrite, Function.comp] using hlim

/-- The losing keys of the same configuration are extinguished. -/
theorem tendsto_coherentBorn_smul_query_ne (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r) (j i : Fin m)
    (hmax : ∀ l, l ≠ j → (inner ℝ q (k l) : ℝ) < inner ℝ q (k j)) (hi : i ≠ j) :
    Tendsto (fun c : ℝ => bornWeight (c • q) k i) atTop (𝓝 0) := by
  have hrewrite : ∀ c : ℝ, bornWeight (c • q) k i
      = scoreSoftmax (2 * c) (fun l => inner ℝ q (k l)) i := by
    intro c
    rw [coherentBorn_eq_softmax (c • q) k r hk i, softmax_smul_query,
      softmax_eq_scoreSoftmax]
  have hscale : Tendsto (fun c : ℝ => 2 * c) atTop atTop :=
    Filter.tendsto_id.const_mul_atTop (by norm_num)
  have hlim := (tendsto_scoreSoftmax_ne (fun l => inner ℝ q (k l)) j i hmax hi).comp hscale
  simpa [hrewrite, Function.comp] using hlim

end BookProof.ChapterSoftmaxSharpness

end
