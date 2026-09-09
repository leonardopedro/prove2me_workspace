import Mathlib
import BookProof.ChapterCoherentOverlapComplex

/-!
# Chapter "The Coherent State of Attention" — position enters only as a relative
phase

A transformer head has to know *where* its tokens are, and the rotary encoding
does this by rotating each complex coordinate of the query and the key by an
angle proportional to the token's position: `q ↦ (e^{i p ωᵢ} qᵢ)ᵢ`.  This module
proves the property that makes the device work: after the encoding, the alignment
of a query at position `a` with a key at position `b` depends on `a` and `b`
**only through the offset `b − a`**.  Absolute position is unobservable; relative
position is the whole content.

Deliverables (all `sorry`-free, `axiom`-free):

* `rotaryEncode ω p` — the rotary positional encoding at position `p` with
  per-coordinate frequencies `ω`;
* `rotaryEncode_zero`, `rotaryEncode_add` — it is an action of the additive group
  of positions;
* `norm_rotaryEncode` — it is norm preserving (each coordinate is multiplied by a
  unit-modulus phase), hence a unitary;
* **`inner_rotaryEncode`** — the headline: `⟪R_a q, R_b k⟫ = ⟪q, R_{b−a} k⟫`, so
  the complex alignment depends only on the offset; `inner_rotaryEncode_shift`
  states the shift invariance directly;
* `coherentOverlapC_rotaryEncode`, `bornWeightC_rotaryEncode_shift` — the Bargmann
  kernel and hence every coherent-state attention weight inherit the same
  invariance: translating the whole sequence changes nothing.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterRotaryPosition

open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

/-! ## The rotary encoding -/

/-- The **rotary positional encoding**: at position `p`, the `i`-th complex
coordinate is rotated by the angle `p·ωᵢ`. -/
def rotaryEncode (omega : Fin n → ℝ) (p : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    EuclideanSpace ℂ (Fin n) :=
  WithLp.toLp 2 fun i => Complex.exp ((p * omega i : ℝ) * Complex.I) * q i

theorem rotaryEncode_apply (omega : Fin n → ℝ) (p : ℝ) (q : EuclideanSpace ℂ (Fin n))
    (i : Fin n) :
    rotaryEncode omega p q i = Complex.exp ((p * omega i : ℝ) * Complex.I) * q i := rfl

@[simp] theorem rotaryEncode_zero (omega : Fin n → ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    rotaryEncode omega 0 q = q := by
  ext i
  rw [rotaryEncode_apply]
  norm_num

/-- Positions compose additively: the encoding is a group action. -/
theorem rotaryEncode_add (omega : Fin n → ℝ) (p p' : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    rotaryEncode omega (p + p') q = rotaryEncode omega p (rotaryEncode omega p' q) := by
  ext i
  rw [rotaryEncode_apply, rotaryEncode_apply, rotaryEncode_apply, ← mul_assoc,
    ← Complex.exp_add]
  congr 2
  push_cast
  ring

/-- The encoding multiplies each coordinate by a unit-modulus phase, so it is
norm preserving. -/
theorem norm_rotaryEncode (omega : Fin n → ℝ) (p : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    ‖rotaryEncode omega p q‖ = ‖q‖ := by
  rw [EuclideanSpace.norm_eq, EuclideanSpace.norm_eq]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [rotaryEncode_apply, norm_mul, Complex.norm_exp_ofReal_mul_I, one_mul]

/-! ## Only the relative position is visible -/

/-- **HEADLINE — the alignment sees only the offset.**  The inner product of a
rotary-encoded query at position `a` with a rotary-encoded key at position `b`
equals the inner product of the bare query with the key encoded at the *relative*
position `b − a`. -/
theorem inner_rotaryEncode (omega : Fin n → ℝ) (a b : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (rotaryEncode omega a q) (rotaryEncode omega b k) : ℂ)
      = inner ℂ q (rotaryEncode omega (b - a) k) := by
  rw [PiLp.inner_apply, PiLp.inner_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hconj : (starRingEnd ℂ) (Complex.exp ((a * omega i : ℝ) * Complex.I))
      = Complex.exp (-((a * omega i : ℝ) * Complex.I)) := by
    rw [← Complex.exp_conj]
    congr 1
    simp
  have hexp : Complex.exp (-((a * omega i : ℝ) * Complex.I))
      * Complex.exp ((b * omega i : ℝ) * Complex.I)
      = Complex.exp (((b - a) * omega i : ℝ) * Complex.I) := by
    rw [← Complex.exp_add]
    congr 1
    push_cast
    ring
  simp only [RCLike.inner_apply, rotaryEncode_apply, map_mul, hconj]
  linear_combination ((starRingEnd ℂ) (q i) * k i) * hexp

/-- Translating query and key by the same amount changes no alignment. -/
theorem inner_rotaryEncode_shift (omega : Fin n → ℝ) (a b c : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (rotaryEncode omega (a + c) q) (rotaryEncode omega (b + c) k) : ℂ)
      = inner ℂ (rotaryEncode omega a q) (rotaryEncode omega b k) := by
  rw [inner_rotaryEncode, inner_rotaryEncode]
  congr 2
  ring

/-- The Bargmann kernel of two rotary-encoded states depends only on the offset. -/
theorem coherentOverlapC_rotaryEncode (omega : Fin n → ℝ) (a b : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC (rotaryEncode omega a q) (rotaryEncode omega b k)
      = coherentOverlapC q (rotaryEncode omega (b - a) k) := by
  rw [coherentOverlapC, coherentOverlapC, norm_rotaryEncode, norm_rotaryEncode,
    norm_rotaryEncode, inner_rotaryEncode]

theorem bornNumerC_rotaryEncode_shift (omega : Fin n → ℝ) (a b c : ℝ)
    (q k : EuclideanSpace ℂ (Fin n)) :
    bornNumerC (rotaryEncode omega (a + c) q) (rotaryEncode omega (b + c) k)
      = bornNumerC (rotaryEncode omega a q) (rotaryEncode omega b k) := by
  rw [bornNumerC, bornNumerC, coherentOverlapC_rotaryEncode, coherentOverlapC_rotaryEncode,
    show b + c - (a + c) = b - a from by ring]

/-- **Attention is invariant under a translation of the whole sequence.**  Shifting
the query and every key by the same number of positions leaves each coherent-state
attention weight unchanged. -/
theorem bornWeightC_rotaryEncode_shift (omega : Fin n → ℝ) (a c : ℝ)
    (pos : Fin m → ℝ) (q : EuclideanSpace ℂ (Fin n))
    (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (rotaryEncode omega (a + c) q)
        (fun l => rotaryEncode omega (pos l + c) (k l)) j
      = bornWeightC (rotaryEncode omega a q) (fun l => rotaryEncode omega (pos l) (k l)) j := by
  have hnum : ∀ l : Fin m,
      bornNumerC (rotaryEncode omega (a + c) q) (rotaryEncode omega (pos l + c) (k l))
        = bornNumerC (rotaryEncode omega a q) (rotaryEncode omega (pos l) (k l)) :=
    fun l => bornNumerC_rotaryEncode_shift omega a (pos l) c q (k l)
  rw [bornWeightC, bornWeightC, hnum j]
  congr 1
  exact Finset.sum_congr rfl fun l _ => hnum l

end BookProof.ChapterRotaryPosition

end
