import Mathlib
import BookProof.ChapterFreeFieldBornSurj

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Born parametrization is a *continuous* surjection of the sphere onto the simplex

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the Introduction's statement (`book.tex` ~line 805) that *"the
wave-function is nothing else than one possible parametrization of any
probability distribution; the parametrization is a surjective map from an
hypersphere to the set of all possible probability distributions"*, together
with the free-field construction of §5 (`book.tex` ~line 1706).

Wave 141 (`ChapterFreeFieldBorn`) showed the coordinate-wise Born map
`x ↦ (x_k)²` sends the unit sphere *into* the probability simplex; Wave 142
(`ChapterFreeFieldBornSurj`) showed it is *surjective* onto the simplex, with a
canonical continuous section `p ↦ (√ p_k)`.  This file records the **topological**
content of the parametrization claim: the Born map is *continuous*, so the
probability simplex is exactly the image of the (compact) unit sphere under a
continuous map — hence itself compact.  Together with Wave 142 this says the
hypersphere parametrizes "the set of all possible probability distributions"
*continuously*.

## Main results

* `continuous_bornMap` — the Born map is continuous.
* `continuous_bornSection` — the square-root section is continuous.
* `bornMap_mapsTo_stdSimplex` — the Born map sends the unit sphere into the
  simplex (packaged as `Set.MapsTo`).
* **headline** `stdSimplex_eq_bornMap_image_sphere` — the probability simplex is
  *exactly* the image of the unit sphere under the Born map:
  `stdSimplex ℝ (Fin n) = bornMap '' Metric.sphere 0 1`.
* `isCompact_stdSimplex_of_born` — consequently the simplex is compact, exhibited
  as the continuous image of the compact sphere.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj

namespace BookProof.ChapterFreeFieldBornCont

variable {n : ℕ}

/-- The Born map `x ↦ (fun k => (x k)²)` is continuous. -/
theorem continuous_bornMap :
    Continuous (bornMap : EuclideanSpace ℝ (Fin n) → (Fin n → ℝ)) := by
  unfold bornMap; fun_prop

/-- The canonical square-root section `p ↦ (fun k => √(p k))` is continuous. -/
theorem continuous_bornSection :
    Continuous (bornSection : (Fin n → ℝ) → EuclideanSpace ℝ (Fin n)) := by
  unfold bornSection; fun_prop

/-- The Born map sends the unit sphere into the probability simplex. -/
theorem bornMap_mapsTo_stdSimplex :
    Set.MapsTo (bornMap : EuclideanSpace ℝ (Fin n) → (Fin n → ℝ))
      (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) (stdSimplex ℝ (Fin n)) :=
  fun _ hx => bornMap_mem_stdSimplex hx

/-
**Headline.** The probability simplex is *exactly* the image of the unit sphere
under the Born map.  The `⊆` inclusion is surjectivity (Wave 142); the `⊇`
inclusion is that the Born map maps the sphere into the simplex (Wave 141).
-/
theorem stdSimplex_eq_bornMap_image_sphere :
    stdSimplex ℝ (Fin n) =
      (bornMap : EuclideanSpace ℝ (Fin n) → (Fin n → ℝ)) ''
        (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) := by
  apply Set.Subset.antisymm
  · exact bornMap_surjOn_stdSimplex
  · rintro _ ⟨x, hx, rfl⟩
    exact bornMap_mem_stdSimplex hx

/-
The probability simplex is compact, exhibited as the continuous image of the
compact unit sphere under the Born map.  (Mathlib also proves this directly as
`isCompact_stdSimplex`; here it drops out of the parametrization picture.)
-/
theorem isCompact_stdSimplex_of_born :
    IsCompact (stdSimplex ℝ (Fin n)) := by
  rw [stdSimplex_eq_bornMap_image_sphere]
  exact (isCompact_sphere (0 : EuclideanSpace ℝ (Fin n)) 1).image continuous_bornMap

end BookProof.ChapterFreeFieldBornCont
