import Mathlib
import BookProof.ChapterCoherentOverlap
import BookProof.ChapterSoftmaxBorn

/-!
# Chapter "The Coherent State of Attention" — the **complex** Bargmann kernel and
the phase-invariance of the Born weight

`BookProof.ChapterCoherentOverlap` and `BookProof.ChapterSoftmaxBorn` prove the
coherent-overlap and Softmax-is-Born identities for *real* coherent-state
parameters, where the Bargmann–Fock kernel is a positive real number.  Both
modules record the same disparity with the informal chapter, which states the
kernel for general **complex** parameters:

  `⟨q | k⟩ = exp (-‖q‖²/2 - ‖k‖²/2 + ⟪q, k⟫)`,   `q, k ∈ ℂⁿ`,

where now `⟪q, k⟫ = ∑ᵢ conj (qᵢ) kᵢ` is a complex number, so the kernel carries an
extra phase `exp (i · Im ⟪q,k⟫)`.  This module closes that disparity: it defines
the complex kernel, factors it into modulus and phase, and shows that the Born
rule — the squared modulus — *discards the phase*, so the attention weights are
exactly the ones computed in the real case, with the alignment score being the
real part `Re ⟪q, k⟫` (which is what a real-valued attention logit is).

Deliverables (all `sorry`-free, `axiom`-free):

* `coherentOverlapC` — the complex Bargmann–Fock reproducing kernel;
* `coherentOverlapC_eq_sum` — the coordinate formula;
* `coherentOverlapC_eq_modulus_mul_phase` — **the modulus/phase factorization**:
  the kernel is a positive real Gaussian factor times a pure phase
  `exp (i · Im ⟪q,k⟫)`;
* `norm_coherentOverlapC` — the modulus is the real Gaussian factor;
* `coherentOverlapC_self`, `norm_coherentOverlapC_le_one` — normalization and the
  Cauchy–Schwarz bound;
* `coherentOverlapC_ofReal`, `bornNumerC_ofReal` — the real theory of
  `ChapterCoherentOverlap` is the special case of real parameters;
* `bornNumerC_eq` — **the three-factor split** of `|⟨q|k⟩|²` with `Complex.normSq`;
* `bornWeightC`, `softmaxC` and the **HEADLINE `coherentBornC_eq_softmax`** — for
  complex coherent-state parameters with a common key norm, the Born weight is
  exactly the Softmax attention weight at inverse temperature `2` in the real
  alignment scores `Re ⟪q, kⱼ⟫`;
* `bornWeightC_phase_invariant` — the Born weight is unchanged if each key is
  replaced by a key with the same norm and the same real alignment, i.e. the
  phase of the overlap is invisible to attention.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

/-! ## The complex Bargmann–Fock kernel -/

/-- The **complex coherent-state overlap** (Bargmann–Fock reproducing kernel):
`⟨q | k⟩ = exp (-‖q‖²/2 - ‖k‖²/2 + ⟪q, k⟫)` for complex parameters. -/
def coherentOverlapC (q k : EuclideanSpace ℂ (Fin n)) : ℂ :=
  Complex.exp (((-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 : ℝ) : ℂ) + inner ℂ q k)

/-- The coordinate form of the complex inner product. -/
theorem innerC_eq_sum (q k : EuclideanSpace ℂ (Fin n)) :
    inner ℂ q k = ∑ i, (starRingEnd ℂ) (q i) * k i := by
  rw [PiLp.inner_apply]
  simp [RCLike.inner_apply, mul_comm]

/-- The explicit coordinate formula for the complex kernel. -/
theorem coherentOverlapC_eq_sum (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q k =
      Complex.exp (((-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 : ℝ) : ℂ)
        + ∑ i, (starRingEnd ℂ) (q i) * k i) := by
  rw [coherentOverlapC, innerC_eq_sum]

/-- **Modulus/phase factorization of the complex kernel.**  The Bargmann kernel is
the real Gaussian factor `exp (-‖q‖²/2 - ‖k‖²/2 + Re ⟪q,k⟫)` times the pure phase
`exp (i · Im ⟪q,k⟫)`. -/
theorem coherentOverlapC_eq_modulus_mul_phase (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q k =
      (Real.exp (-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 + (inner ℂ q k : ℂ).re) : ℂ) *
        Complex.exp (((inner ℂ q k : ℂ).im : ℂ) * Complex.I) := by
  rw [coherentOverlapC, Complex.ofReal_exp, ← Complex.exp_add]
  congr 1
  apply Complex.ext <;> simp [-Complex.ofReal_pow]

/-- **The modulus of the complex kernel** is the real Gaussian factor: the phase
drops out. -/
theorem norm_coherentOverlapC (q k : EuclideanSpace ℂ (Fin n)) :
    ‖coherentOverlapC q k‖
      = Real.exp (-‖q‖ ^ 2 / 2 - ‖k‖ ^ 2 / 2 + (inner ℂ q k : ℂ).re) := by
  rw [coherentOverlapC, Complex.norm_exp]
  simp [-Complex.ofReal_pow]

theorem coherentOverlapC_ne_zero (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q k ≠ 0 := Complex.exp_ne_zero _

/-- A complex coherent state is normalized: `⟨q|q⟩ = 1`. -/
theorem coherentOverlapC_self (q : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC q q = 1 := by
  rw [coherentOverlapC, inner_self_eq_norm_sq_to_K]
  norm_num
  rw [show -(‖q‖ : ℂ) ^ 2 / 2 - (‖q‖ : ℂ) ^ 2 / 2 + (‖q‖ : ℂ) ^ 2 = 0 from by ring]
  exact Complex.exp_zero

/-- Cauchy–Schwarz for coherent states: the modulus of the overlap never exceeds
`1`. -/
theorem norm_coherentOverlapC_le_one (q k : EuclideanSpace ℂ (Fin n)) :
    ‖coherentOverlapC q k‖ ≤ 1 := by
  rw [norm_coherentOverlapC, Real.exp_le_one_iff]
  have h1 : (inner ℂ q k : ℂ).re ≤ ‖(inner ℂ q k : ℂ)‖ := Complex.re_le_norm _
  have h2 : ‖(inner ℂ q k : ℂ)‖ ≤ ‖q‖ * ‖k‖ := norm_inner_le_norm _ _
  have h3 : 2 * (‖q‖ * ‖k‖) ≤ ‖q‖ ^ 2 + ‖k‖ ^ 2 := by nlinarith [sq_nonneg (‖q‖ - ‖k‖)]
  linarith

/-! ## The real theory is the special case of real parameters -/

/-- The inclusion of real coherent-state parameters into complex ones. -/
def ofRealVec (q : EuclideanSpace ℝ (Fin n)) : EuclideanSpace ℂ (Fin n) :=
  WithLp.toLp 2 fun i => (q i : ℂ)

theorem norm_ofRealVec (q : EuclideanSpace ℝ (Fin n)) : ‖ofRealVec q‖ = ‖q‖ := by
  rw [EuclideanSpace.norm_eq, EuclideanSpace.norm_eq]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  change ‖((q i : ℂ))‖ ^ 2 = ‖q i‖ ^ 2
  simp

theorem inner_ofRealVec (q k : EuclideanSpace ℝ (Fin n)) :
    inner ℂ (ofRealVec q) (ofRealVec k) = ((inner ℝ q k : ℝ) : ℂ) := by
  rw [PiLp.inner_apply, PiLp.inner_apply]
  push_cast
  refine Finset.sum_congr rfl fun i _ => ?_
  simp [RCLike.inner_apply, ofRealVec, mul_comm]

/-- **The real kernel is the complex kernel at real parameters**: the disparity
recorded in `ChapterCoherentOverlap` is exactly a restriction. -/
theorem coherentOverlapC_ofReal (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlapC (ofRealVec q) (ofRealVec k)
      = ((BookProof.ChapterCoherentOverlap.coherentOverlap q k : ℝ) : ℂ) := by
  rw [coherentOverlapC, inner_ofRealVec, norm_ofRealVec, norm_ofRealVec,
    BookProof.ChapterCoherentOverlap.coherentOverlap, Complex.ofReal_exp]
  congr 1
  push_cast
  ring

/-! ## The Born rule on complex coherent states -/

/-- The Born numerator for complex parameters: `|⟨q|k⟩|²`. -/
def bornNumerC (q k : EuclideanSpace ℂ (Fin n)) : ℝ := ‖coherentOverlapC q k‖ ^ 2

/-- **The three-factor split of the complex Born numerator.**  The phase is gone;
what remains is the query penalty, the key penalty and the *real* alignment
`Re ⟪q, k⟫`. -/
theorem bornNumerC_eq (q k : EuclideanSpace ℂ (Fin n)) :
    bornNumerC q k =
      Real.exp (-‖q‖ ^ 2) * Real.exp (-‖k‖ ^ 2)
        * Real.exp (2 * (inner ℂ q k : ℂ).re) := by
  rw [bornNumerC, norm_coherentOverlapC, ← Real.exp_nat_mul, ← Real.exp_add, ← Real.exp_add]
  congr 1
  ring

theorem bornNumerC_pos (q k : EuclideanSpace ℂ (Fin n)) : 0 < bornNumerC q k := by
  rw [bornNumerC]
  exact pow_pos (norm_pos_iff.2 (coherentOverlapC_ne_zero q k)) 2

/-- At real parameters the complex Born numerator is the real one. -/
theorem bornNumerC_ofReal (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumerC (ofRealVec q) (ofRealVec k)
      = BookProof.ChapterSoftmaxBorn.bornNumer q k := by
  rw [bornNumerC, coherentOverlapC_ofReal, BookProof.ChapterSoftmaxBorn.bornNumer,
    Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos (BookProof.ChapterCoherentOverlap.coherentOverlap_pos q k)]

/-- The **Born-rule attention weight** for complex coherent-state parameters. -/
def bornWeightC (q : EuclideanSpace ℂ (Fin n)) (k : Fin m → EuclideanSpace ℂ (Fin n))
    (j : Fin m) : ℝ :=
  bornNumerC q (k j) / ∑ l, bornNumerC q (k l)

/-- The **Softmax attention weight** at inverse temperature `beta` in the real
alignment scores `Re ⟪q, kⱼ⟫`. -/
def softmaxC (beta : ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) : ℝ :=
  Real.exp (beta * (inner ℂ q (k j) : ℂ).re) /
    ∑ l, Real.exp (beta * (inner ℂ q (k l) : ℂ).re)

theorem bornDenomC_pos (q : EuclideanSpace ℂ (Fin n)) (k : Fin m → EuclideanSpace ℂ (Fin n))
    (j : Fin m) : 0 < ∑ l, bornNumerC q (k l) :=
  Finset.sum_pos (fun l _ => bornNumerC_pos q (k l)) ⟨j, Finset.mem_univ j⟩

theorem softmaxDenomC_pos (beta : ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    0 < ∑ l, Real.exp (beta * (inner ℂ q (k l) : ℂ).re) :=
  Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨j, Finset.mem_univ j⟩

theorem bornWeightC_pos (q : EuclideanSpace ℂ (Fin n)) (k : Fin m → EuclideanSpace ℂ (Fin n))
    (j : Fin m) : 0 < bornWeightC q k j :=
  div_pos (bornNumerC_pos q (k j)) (bornDenomC_pos q k j)

/-- The complex Born weights are a probability distribution over the keys. -/
theorem bornWeightC_sum_one (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j₀ : Fin m) :
    ∑ j, bornWeightC q k j = 1 := by
  simp only [bornWeightC]
  rw [← Finset.sum_div]
  exact div_self (ne_of_gt (bornDenomC_pos q k j₀))

/-- The `exp(-‖q‖²)` factor cancels in the complex case too. -/
theorem coherentBornC_cancel_q (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC q k j =
      Real.exp (-‖k j‖ ^ 2) * Real.exp (2 * (inner ℂ q (k j) : ℂ).re) /
        ∑ l, Real.exp (-‖k l‖ ^ 2) * Real.exp (2 * (inner ℂ q (k l) : ℂ).re) := by
  have hc : (0 : ℝ) < Real.exp (-‖q‖ ^ 2) := Real.exp_pos _
  have hsum : ∑ l, bornNumerC q (k l)
      = Real.exp (-‖q‖ ^ 2) *
        ∑ l, Real.exp (-‖k l‖ ^ 2) * Real.exp (2 * (inner ℂ q (k l) : ℂ).re) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [bornNumerC_eq]
    ring
  rw [bornWeightC, hsum, bornNumerC_eq, mul_assoc, mul_div_mul_left _ _ (ne_of_gt hc)]

/-- **HEADLINE (complex case) — Softmax attention is the Born rule on complex
coherent states.**  For complex coherent-state parameters with a common key norm,
the normalized squared modulus of the Bargmann kernel is exactly the Softmax
weight at inverse temperature `2` in the real alignment scores `Re ⟪q, kⱼ⟫`.  The
phase `exp (i · Im ⟪q,kⱼ⟫)` of the kernel is discarded by the Born rule. -/
theorem coherentBornC_eq_softmax (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (r : ℝ) (hk : ∀ l, ‖k l‖ = r) (j : Fin m) :
    bornWeightC q k j = softmaxC 2 q k j := by
  have hc : (0 : ℝ) < Real.exp (-r ^ 2) := Real.exp_pos _
  rw [coherentBornC_cancel_q, softmaxC]
  have hnum : Real.exp (-‖k j‖ ^ 2) * Real.exp (2 * (inner ℂ q (k j) : ℂ).re)
      = Real.exp (-r ^ 2) * Real.exp (2 * (inner ℂ q (k j) : ℂ).re) := by rw [hk j]
  have hden : ∑ l, Real.exp (-‖k l‖ ^ 2) * Real.exp (2 * (inner ℂ q (k l) : ℂ).re)
      = Real.exp (-r ^ 2) * ∑ l, Real.exp (2 * (inner ℂ q (k l) : ℂ).re) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by rw [hk l]
  rw [hnum, hden, mul_div_mul_left _ _ (ne_of_gt hc)]

/-- The LayerNorm special case of the complex headline: unit-norm keys. -/
theorem coherentBornC_eq_softmax_of_unit_keys (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (hk : ∀ l, ‖k l‖ = 1) (j : Fin m) :
    bornWeightC q k j = softmaxC 2 q k j :=
  coherentBornC_eq_softmax q k 1 hk j

/-- **The Born weight only sees modulus data.**  Two key families with the same
norms and the same *real* alignments against the query produce the same attention
weights, whatever the imaginary parts of the overlaps are: the Bargmann phase is
invisible to attention. -/
theorem bornWeightC_phase_invariant (q : EuclideanSpace ℂ (Fin n))
    (k k' : Fin m → EuclideanSpace ℂ (Fin n)) (hnorm : ∀ l, ‖k' l‖ = ‖k l‖)
    (hre : ∀ l, (inner ℂ q (k' l) : ℂ).re = (inner ℂ q (k l) : ℂ).re) (j : Fin m) :
    bornWeightC q k' j = bornWeightC q k j := by
  rw [coherentBornC_cancel_q, coherentBornC_cancel_q, hnorm j, hre j]
  congr 1
  exact Finset.sum_congr rfl fun l _ => by rw [hnorm l, hre l]

/-- At real parameters the complex Born weights are the real ones of
`ChapterSoftmaxBorn`. -/
theorem bornWeightC_ofReal (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    bornWeightC (ofRealVec q) (fun l => ofRealVec (k l)) j
      = BookProof.ChapterSoftmaxBorn.bornWeight q k j := by
  rw [bornWeightC, BookProof.ChapterSoftmaxBorn.bornWeight, bornNumerC_ofReal]
  congr 1
  exact Finset.sum_congr rfl fun l _ => bornNumerC_ofReal q (k l)

end BookProof.ChapterCoherentOverlapComplex

end
