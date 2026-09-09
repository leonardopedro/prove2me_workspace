import Mathlib
import BookProof.ChapterFreeFieldBornSurj

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the square-root section is the *unique* nonnegative representative of each Born fiber

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the Introduction's statement (`book.tex` ~line 805) that *"the
wave-function is nothing else than one possible parametrization of any
probability distribution; the parametrization is a surjective map from an
hypersphere to the set of all possible probability distributions"*, together
with the free-field construction of §5 (`book.tex` ~line 1706).

Previous waves on this thread built the Born map `x ↦ (x_k)²`, showed it is a
continuous surjection of the unit sphere onto the probability simplex
(`ChapterFreeFieldBornSurj`), and pinned down its fibers as exactly the diagonal
`{±1}ⁿ` sign orbits (`ChapterFreeFieldBornSignFiber`).  Since each fiber is a
`{±1}ⁿ` orbit, it contains a *distinguished* representative — the one with all
coordinates nonnegative — and the square-root section `bornSection` of Wave 142
picks it out.  This wave makes that precise: restricted to the **nonnegative
orthant** of the sphere, the Born map is a *bijection* onto the simplex, with
`bornSection` as its two-sided inverse.

## Main results

* `bornSection_nonneg` — the square-root section has nonnegative coordinates.
* `bornMap_injOn_nonneg` — the Born map is injective on the nonnegative orthant
  (`x_k = √((x_k)²) = √((y_k)²) = y_k`).
* `bornSection_bornMap` — on the nonnegative orthant `bornSection` inverts the
  Born map: `bornSection (bornMap x) = x`.
* **headline** `bornMap_bijOn_nonneg_sphere` — the Born map restricts to a
  bijection from the nonnegative part of the unit sphere onto the probability
  simplex `stdSimplex ℝ (Fin n)`: every probability distribution has a *unique*
  nonnegative square-root wave function on the sphere.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSurj

namespace BookProof.ChapterFreeFieldBornSectionBij

variable {n : ℕ}

/-- The nonnegative orthant of `EuclideanSpace ℝ (Fin n)`: wave functions whose
coordinates are all `≥ 0`. -/
def nonnegOrthant (n : ℕ) : Set (EuclideanSpace ℝ (Fin n)) :=
  {x | ∀ k, 0 ≤ x k}

theorem mem_nonnegOrthant {x : EuclideanSpace ℝ (Fin n)} :
    x ∈ nonnegOrthant n ↔ ∀ k, 0 ≤ x k := Iff.rfl

/-- The square-root section always lands in the nonnegative orthant. -/
theorem bornSection_nonneg (p : Fin n → ℝ) : bornSection p ∈ nonnegOrthant n := by
  intro k; rw [bornSection_apply]; exact Real.sqrt_nonneg _

/-- The Born map is injective on the nonnegative orthant: if two nonnegative
wave functions have the same Born probabilities they are equal. -/
theorem bornMap_injOn_nonneg :
    Set.InjOn (bornMap : EuclideanSpace ℝ (Fin n) → _) (nonnegOrthant n) := by
  intro x hx y hy h_eq
  ext k
  have hsq : (x k) ^ 2 = (y k) ^ 2 := congr_fun h_eq k
  have := congr_arg Real.sqrt hsq
  rwa [Real.sqrt_sq (hx k), Real.sqrt_sq (hy k)] at this

/-- On the nonnegative orthant, the square-root section is a genuine left inverse
of the Born map: `bornSection (bornMap x) = x`, since `√((x_k)²) = x_k` when
`x_k ≥ 0`. -/
theorem bornSection_bornMap {x : EuclideanSpace ℝ (Fin n)} (hx : x ∈ nonnegOrthant n) :
    bornSection (bornMap x) = x := by
  ext k
  rw [bornSection_apply]
  change Real.sqrt ((x k) ^ 2) = x k
  rw [Real.sqrt_sq (hx k)]

/-- **Headline.** The Born map restricts to a *bijection* from the nonnegative
part of the unit sphere onto the probability simplex: every probability
distribution `p` is the Born image of a *unique* nonnegative wave function on the
sphere (namely the square-root section `bornSection p`).  This distinguishes a
canonical representative in each `{±1}ⁿ` gauge fiber. -/
theorem bornMap_bijOn_nonneg_sphere :
    Set.BijOn (bornMap : EuclideanSpace ℝ (Fin n) → _)
      (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 ∩ nonnegOrthant n)
      (stdSimplex ℝ (Fin n)) := by
  refine ⟨?_, ?_, ?_⟩
  · -- MapsTo
    intro x hx
    exact bornMap_mem_stdSimplex hx.1
  · -- InjOn
    exact bornMap_injOn_nonneg.mono (Set.inter_subset_right)
  · -- SurjOn
    intro p hp
    exact ⟨bornSection p, ⟨bornSection_mem_sphere hp, bornSection_nonneg p⟩,
      bornMap_bornSection hp⟩

end BookProof.ChapterFreeFieldBornSectionBij
