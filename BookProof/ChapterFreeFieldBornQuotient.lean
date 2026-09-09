import Mathlib
import BookProof.ChapterFreeFieldBornCont
import BookProof.ChapterFreeFieldBornSurj

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Born parametrization of the *whole* sphere is a topological quotient map

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the Introduction's statement (`book.tex` ~line 805) that *"the
wave-function is nothing else than one possible parametrization of any
probability distribution; the parametrization is a surjective map from an
hypersphere to the set of all possible probability distributions"*, together
with the free-field construction of §5 (`book.tex` ~line 1706).

Previous waves on this thread built the Born map `x ↦ (x_k)²`, showed it is a
*continuous surjection* of the unit sphere onto the probability simplex
(`ChapterFreeFieldBornCont`, `ChapterFreeFieldBornSurj`), and — after
quotienting out the `{±1}ⁿ` sign gauge — proved that on the **nonnegative
orthant** of the sphere it is a *homeomorphism* onto the simplex
(`ChapterFreeFieldBornHomeo`).

This wave records the topological status of the parametrization on the *whole*
sphere: the Born map, as a map from the unit sphere onto the probability
simplex, is a **topological quotient map**.  Concretely the simplex carries
exactly the quotient topology induced by the Born map: it is the sphere with the
sign gauge collapsed.  The proof is the standard "continuous surjection from a
compact space to a Hausdorff space is a closed map, hence a quotient map"
argument (`Continuous.isClosedMap`, `IsClosedMap.isQuotientMap`).

## Main results

* `bornMapSphere` — the Born map as a map of subtypes `↥(sphere 0 1) →
  ↥(stdSimplex ℝ (Fin n))`.
* `continuous_bornMapSphere`, `surjective_bornMapSphere`.
* **headline** `isQuotientMap_bornMapSphere` — `bornMapSphere` is a quotient map.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont

namespace BookProof.ChapterFreeFieldBornQuotient

variable {n : ℕ}

/-- The Born map packaged as a map of subtypes: the unit sphere onto the
probability simplex, `x ↦ (x_k)²`. -/
noncomputable def bornMapSphere (n : ℕ) :
    ↥(Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) → ↥(stdSimplex ℝ (Fin n)) :=
  fun x => ⟨bornMap x, bornMap_mem_stdSimplex x.2⟩

@[simp] theorem bornMapSphere_coe
    (x : ↥(Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1)) :
    (bornMapSphere n x : Fin n → ℝ) = bornMap x := rfl

/-- `bornMapSphere` is continuous (its underlying map is the continuous Born
map, restricted to the sphere subtype). -/
theorem continuous_bornMapSphere : Continuous (bornMapSphere n) := by
  apply Continuous.subtype_mk
  exact continuous_bornMap.comp continuous_subtype_val

/-- `bornMapSphere` is surjective: every probability distribution is the Born
image of its square-root section, which lies on the unit sphere (Wave 142). -/
theorem surjective_bornMapSphere : Function.Surjective (bornMapSphere n) := by
  intro p
  refine ⟨⟨bornSection p, bornSection_mem_sphere p.2⟩, ?_⟩
  exact Subtype.ext (bornMap_bornSection p.2)

/-- **Headline.** The Born parametrization of the whole unit sphere is a
topological **quotient map** onto the probability simplex: the simplex carries
exactly the quotient topology obtained by collapsing the `{±1}ⁿ` sign gauge of
the sphere.  Since `bornMapSphere` is a continuous surjection
(`continuous_bornMapSphere`, `surjective_bornMapSphere`) from the compact sphere
to the Hausdorff simplex, it is a closed map (`Continuous.isClosedMap`) and
hence a quotient map (`IsClosedMap.isQuotientMap`). -/
theorem isQuotientMap_bornMapSphere :
    Topology.IsQuotientMap (bornMapSphere n) := by
  haveI : CompactSpace ↥(Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :=
    isCompact_iff_compactSpace.mp (isCompact_sphere _ _)
  exact (continuous_bornMapSphere.isClosedMap).isQuotientMap
    continuous_bornMapSphere surjective_bornMapSphere

end BookProof.ChapterFreeFieldBornQuotient
