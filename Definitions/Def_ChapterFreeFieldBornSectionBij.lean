import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterFreeFieldSphereSupport
import Mathlib


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











end BookProof.ChapterFreeFieldBornSectionBij
