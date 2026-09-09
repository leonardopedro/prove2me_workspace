import Mathlib
import BookProof.ChapterFreeFieldBornGauge

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the full coordinate-wise *sign gauge group* of the Born parametrization

Source: `book.tex`, Introduction, section *"Wave-function collapse versus Euler's
formula"* (`book.tex` line ~805): *"the wave-function is nothing else than one
possible parametrization of any probability distribution; the parametrization is
a surjective map from an hypersphere to the set of all possible probability
distributions.  **Two wave-functions are always related by a rotation of the
hypersphere** …"* together with the free-field construction of §5 (`book.tex`
~line 1706).

Wave 144 (`ChapterFreeFieldBornGauge`) recorded a single element of the gauge
redundancy of the Born map `x ↦ (x_k)²`: invariance under the antipodal map
`x ↦ -x` (a *global* sign flip).  In fact the real gauge freedom is much larger:
the Born probabilities `(x_k)²` are unchanged by *any coordinate-wise choice of
signs* `x_k ↦ s_k x_k` with `s_k = ±1`.  This diagonal `{±1}ⁿ` reflection group
preserves the unit sphere (each reflection is an isometry) and acts trivially on
the Born image, so it lies inside every Born fiber; the antipodal map of Wave 144
is the special case `s ≡ -1`.

## Main results

* `signFlip` — the coordinate-wise sign flip `x ↦ (fun k => s_k · x_k)`.
* `signFlip_apply` — its defining coordinate formula.
* `signFlip_norm` — for a `±1` sign vector `s`, `‖signFlip s x‖ = ‖x‖`
  (each reflection is an isometry).
* `signFlip_mem_sphere` — the sign flip preserves the unit sphere.
* **headline** `bornMap_signFlip` — for a `±1` sign vector `s`,
  `bornMap (signFlip s x) = bornMap x`: the Born image is invariant under the
  whole diagonal `{±1}ⁿ` sign group.
* `signFlip_neg_one` — the antipodal map of Wave 144 is the special case
  `s ≡ -1`, recovering `bornMap_neg`.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn

namespace BookProof.ChapterFreeFieldBornSignGauge

variable {n : ℕ}

/-- The **coordinate-wise sign flip** by a sign vector `s : Fin n → ℝ`:
`signFlip s x` has coordinates `s_k · x_k`.  When each `s_k = ±1` this is one of
the `2ⁿ` diagonal reflections generating the real gauge group of the Born map. -/
noncomputable def signFlip (s : Fin n → ℝ) (x : EuclideanSpace ℝ (Fin n)) :
    EuclideanSpace ℝ (Fin n) :=
  (WithLp.equiv 2 (Fin n → ℝ)).symm (fun k => s k * x k)

@[simp] theorem signFlip_apply (s : Fin n → ℝ) (x : EuclideanSpace ℝ (Fin n)) (k : Fin n) :
    signFlip s x k = s k * x k := rfl

/-- For a `±1` sign vector `s`, coordinate-wise sign flipping is an isometry:
`‖signFlip s x‖ = ‖x‖`. -/
theorem signFlip_norm {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    ‖signFlip s x‖ = ‖x‖ := by
  rw [EuclideanSpace.norm_eq, EuclideanSpace.norm_eq]
  congr 1
  refine Finset.sum_congr rfl (fun k _ => ?_)
  rw [signFlip_apply]
  rcases hs k with h | h <;> rw [h] <;> simp [norm_neg]

/-- A `±1` sign flip preserves the unit sphere. -/
theorem signFlip_mem_sphere {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    signFlip s x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by
  rw [Metric.mem_sphere, dist_zero_right, signFlip_norm hs]
  rw [Metric.mem_sphere, dist_zero_right] at hx
  exact hx

/-- **Headline.** The Born image is invariant under the whole diagonal `{±1}ⁿ`
sign group: for any `±1` sign vector `s`, `bornMap (signFlip s x) = bornMap x`.
This is the full real gauge freedom of the wave-function parametrization
(coordinate-wise sign choices), of which the antipodal map of Wave 144 is a
single element. -/
theorem bornMap_signFlip {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    bornMap (signFlip s x) = bornMap x := by
  funext k
  change (signFlip s x k) ^ 2 = (x k) ^ 2
  rw [signFlip_apply]
  rcases hs k with h | h <;> rw [h] <;> ring

/-- The antipodal map of Wave 144 (`bornMap_neg`) is the special case of the sign
gauge with the constant `-1` sign vector: `signFlip (fun _ => -1) x = -x`. -/
theorem signFlip_neg_one (x : EuclideanSpace ℝ (Fin n)) :
    signFlip (fun _ => -1) x = -x := by
  ext k
  change (-1 : ℝ) * x k = -(x k)
  ring

end BookProof.ChapterFreeFieldBornSignGauge
