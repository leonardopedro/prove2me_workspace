import Mathlib
import BookProof.ChapterCoherentOverlap

/-!
# Chapter "The Coherent State of Attention", §"Softmax Is the Born Rule on
Coherent States" — the headline identity

Formalization of the headline claim of the new chapter `Book/CoherentState.lean`
(adapted from `coherent.md`): applying the **Born rule** (normalized squared
modulus) to the coherent-state overlaps of a query `q` against a family of keys
`k : Fin m → ℝⁿ` produces **exactly the Softmax attention weights** at inverse
temperature `2`, provided the keys have a common norm (LayerNorm / RMSNorm).

The mathematical content is a finite `Finset` identity.  Writing
`⟨q|k_j⟩ = exp (-‖q‖²/2 - ‖k_j‖²/2 + ⟪q,k_j⟫)` (`ChapterCoherentOverlap`), the
Born numerator splits into three factors

  `|⟨q|k_j⟩|² = exp (-‖q‖²) · exp (-‖k_j‖²) · exp (2⟪q,k_j⟫)`,

of which the first is independent of `j` and cancels between numerator and
denominator, and the second is *also* independent of `j` once the keys are
normalized, and cancels too.  What is left is Softmax.

Deliverables (all `sorry`-free, `axiom`-free):

* `bornWeight` — the Born-rule attention weight built from coherent overlaps;
* `softmax` — the usual Softmax attention weight at inverse temperature `beta`;
* `coherentBorn_sq_eq` — **the three-factor split** of `|⟨q|k⟩|²`;
* `bornWeight_nonneg`, `bornWeight_pos`, `bornWeight_sum_one` — the Born weights
  are a genuine probability distribution over the keys;
* `softmax_nonneg`, `softmax_pos`, `softmax_sum_one` — likewise for Softmax;
* `coherentBorn_cancel_q` — the `exp (-‖q‖²)` factor cancels: the Born weight is
  already independent of the query norm;
* **HEADLINE `coherentBorn_eq_softmax`** — under a constant key norm, the Born
  rule on coherent states *is* Softmax attention at inverse temperature `2`
  (equivalently temperature `τ = 1/2`);
* `coherentBorn_eq_softmax_of_unit_keys` — the LayerNorm special case `‖k_j‖ = 1`.

**Recorded disparity with the informal chapter.**  The chapter states the overlap
for general (complex) Bargmann parameters; the theorems here are proved for
*real* parameters, where the overlap is a positive real.  The complex case adds
only a phase `exp (i · Im ⟪q,k⟫)`, which the Born rule (squared modulus) discards,
so the weight formula is unchanged.  **This disparity is now closed**: the complex
case is formalized in `BookProof.ChapterCoherentOverlapComplex`
(`coherentBornC_eq_softmax`, `bornWeightC_phase_invariant`), and
`bornWeightC_ofReal` identifies the weights below as its real special case.
The chapter's informal step "each `exp(-‖k_j‖²)` is a fixed constant" is a genuine
hypothesis, and appears as the explicit assumption `∀ l, ‖k l‖ = r`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxBorn

open BookProof.ChapterCoherentOverlap

variable {n m : ℕ}

/-! ## The Born numerator and its three-factor split -/

/-- The Born-rule numerator: the squared modulus of the coherent-state overlap
`|⟨q | k⟩|²`. -/
def bornNumer (q k : EuclideanSpace ℝ (Fin n)) : ℝ := coherentOverlap q k ^ 2

/-- **The three-factor split of the Born numerator.**  Squaring the exponential
doubles the exponent, and the laws of exponents separate the query penalty, the
key penalty and the alignment reward. -/
theorem coherentBorn_sq_eq (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumer q k =
      Real.exp (-‖q‖ ^ 2) * Real.exp (-‖k‖ ^ 2) * Real.exp (2 * inner ℝ q k) := by
  rw [bornNumer, coherentOverlap, ← Real.exp_nat_mul, ← Real.exp_add, ← Real.exp_add]
  congr 1
  ring

theorem bornNumer_pos (q k : EuclideanSpace ℝ (Fin n)) : 0 < bornNumer q k :=
  pow_pos (coherentOverlap_pos q k) 2

/-! ## The Born weights and the Softmax weights -/

/-- The **Born-rule attention weight**: the normalized squared overlap of the
query coherent state with the `j`-th key coherent state. -/
def bornWeight (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (j : Fin m) : ℝ :=
  bornNumer q (k j) / ∑ l, bornNumer q (k l)

/-- The **Softmax attention weight** at inverse temperature `beta` (temperature
`τ = 1/beta`). -/
def softmax (beta : ℝ) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) : ℝ :=
  Real.exp (beta * inner ℝ q (k j)) / ∑ l, Real.exp (beta * inner ℝ q (k l))

/-- The Born denominator is strictly positive as soon as there is at least one
key. -/
theorem bornDenom_pos (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (j : Fin m) : 0 < ∑ i, bornNumer q (k i) :=
  Finset.sum_pos (fun l _ => bornNumer_pos q (k l)) ⟨j, Finset.mem_univ j⟩

/-- The Softmax denominator is strictly positive as soon as there is at least one
key. -/
theorem softmaxDenom_pos (beta : ℝ) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    0 < ∑ l, Real.exp (beta * inner ℝ q (k l)) :=
  Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨j, Finset.mem_univ j⟩

theorem bornWeight_pos (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (j : Fin m) : 0 < bornWeight q k j :=
  div_pos (bornNumer_pos q (k j)) (bornDenom_pos q k j)

theorem bornWeight_nonneg (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (j : Fin m) : 0 ≤ bornWeight q k j :=
  le_of_lt (bornWeight_pos q k j)

theorem softmax_pos (beta : ℝ) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) : 0 < softmax beta q k j :=
  div_pos (Real.exp_pos _) (softmaxDenom_pos beta q k j)

theorem softmax_nonneg (beta : ℝ) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) : 0 ≤ softmax beta q k j :=
  le_of_lt (softmax_pos beta q k j)

/-- **The Born rule really is a rule of probability**: the coherent-state Born
weights sum to one over the keys. -/
theorem bornWeight_sum_one (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j₀ : Fin m) :
    ∑ j, bornWeight q k j = 1 := by
  simp only [bornWeight]
  rw [← Finset.sum_div]
  exact div_self (ne_of_gt (bornDenom_pos q k j₀))

/-- Softmax is a probability distribution over the keys. -/
theorem softmax_sum_one (beta : ℝ) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j₀ : Fin m) :
    ∑ j, softmax beta q k j = 1 := by
  simp only [softmax]
  rw [← Finset.sum_div]
  exact div_self (ne_of_gt (softmaxDenom_pos beta q k j₀))

/-! ## Cancelling the query factor -/

/-- **The `exp(-‖q‖²)` factor cancels.**  It is constant along the row, so it
factors out of the sum and drops out of the normalized weight: the Born weight
depends on the query only through the alignments `⟪q, k_l⟫`. -/
theorem coherentBorn_cancel_q (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    bornWeight q k j =
      Real.exp (-‖k j‖ ^ 2) * Real.exp (2 * inner ℝ q (k j)) /
        ∑ l, Real.exp (-‖k l‖ ^ 2) * Real.exp (2 * inner ℝ q (k l)) := by
  have hc : (0 : ℝ) < Real.exp (-‖q‖ ^ 2) := Real.exp_pos _
  have hsum : ∑ l, bornNumer q (k l)
      = Real.exp (-‖q‖ ^ 2) *
        ∑ l, Real.exp (-‖k l‖ ^ 2) * Real.exp (2 * inner ℝ q (k l)) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [coherentBorn_sq_eq]
    ring
  rw [bornWeight, hsum, coherentBorn_sq_eq]
  rw [mul_assoc, mul_div_mul_left _ _ (ne_of_gt hc)]

/-! ## The headline: Softmax is the Born rule -/

/-- **HEADLINE — Softmax attention is the Born rule on coherent states.**

If the keys share a common norm `r` (the LayerNorm / RMSNorm hypothesis of the
chapter), then the normalized squared coherent-state overlap of the query against
the keys is *exactly* the Softmax attention weight at inverse temperature `2`,
i.e. at temperature `τ = 1/2`. -/
theorem coherentBorn_eq_softmax (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r) (j : Fin m) :
    bornWeight q k j = softmax 2 q k j := by
  have hc : (0 : ℝ) < Real.exp (-r ^ 2) := Real.exp_pos _
  rw [coherentBorn_cancel_q, softmax]
  have hnum : Real.exp (-‖k j‖ ^ 2) * Real.exp (2 * inner ℝ q (k j))
      = Real.exp (-r ^ 2) * Real.exp (2 * inner ℝ q (k j)) := by rw [hk j]
  have hden : ∑ l, Real.exp (-‖k l‖ ^ 2) * Real.exp (2 * inner ℝ q (k l))
      = Real.exp (-r ^ 2) * ∑ l, Real.exp (2 * inner ℝ q (k l)) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by rw [hk l]
  rw [hnum, hden, mul_div_mul_left _ _ (ne_of_gt hc)]

/-- The LayerNorm special case of the headline: unit-norm keys. -/
theorem coherentBorn_eq_softmax_of_unit_keys (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (hk : ∀ l, ‖k l‖ = 1) (j : Fin m) :
    bornWeight q k j = softmax 2 q k j :=
  coherentBorn_eq_softmax q k 1 hk j

/-- The baseline temperature of the derivation, read off the headline: the
Softmax that the Born rule produces has inverse temperature `2`, i.e.
temperature `τ = 1/2`. -/
theorem coherentBorn_temperature_half (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r) (j : Fin m) :
    bornWeight q k j =
      Real.exp (inner ℝ q (k j) / (1 / 2)) / ∑ l, Real.exp (inner ℝ q (k l) / (1 / 2)) := by
  have hx : ∀ x : ℝ, x / (1 / 2) = 2 * x := fun x => by ring
  rw [coherentBorn_eq_softmax q k r hk j, softmax]
  simp only [hx]

end BookProof.ChapterSoftmaxBorn

end
