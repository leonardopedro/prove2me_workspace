import Mathlib
import BookProof.ChapterFreeFieldBorn

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Born parametrization of the probability simplex is surjective

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the Introduction's statement (`book.tex` ~line 805) that *"the
wave-function is nothing else than one possible parametrization of any
probability distribution; the parametrization is a surjective map from an
hypersphere to the set of all possible probability distributions"*, together
with the free-field construction of §5 (`book.tex` ~line 1706).

Wave 141 (`ChapterFreeFieldBorn`) introduced the coordinate-wise Born map
`x ↦ (x_k)²` and showed it sends the unit sphere *into* the probability simplex
`stdSimplex ℝ (Fin n)`, hence pushes the Gaussian sphere measure forward to a
genuine probability distribution on the simplex.  This file completes the book's
headline claim by proving the map is **surjective**: every probability
distribution `p` on `Fin n` is the Born image of a wave function on the unit
sphere, namely the coordinate-wise square root `x_k = √(p_k)`.

## Main results

* `bornSection` — the canonical section `p ↦ (fun k => √(p_k))` of the Born map.
* `bornMap_bornSection` — `bornMap (bornSection p) = p` for `p` in the simplex.
* `bornSection_mem_sphere` — `bornSection p` lies on the unit sphere.
* **headline** `bornMap_surjOn_stdSimplex` — the Born map restricted to the unit
  sphere surjects onto the probability simplex `stdSimplex ℝ (Fin n)`; this is
  the book's claim that the hypersphere parametrizes *"the set of all possible
  probability distributions"*.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn

namespace BookProof.ChapterFreeFieldBornSurj

variable {n : ℕ}

/-- The canonical **section** of the Born map: a probability distribution `p` is
realized by the wave function whose coordinates are the square roots
`x_k = √(p_k)`. -/
noncomputable def bornSection (p : Fin n → ℝ) : EuclideanSpace ℝ (Fin n) :=
  (WithLp.toLp 2) (fun k => Real.sqrt (p k))

theorem bornSection_apply (p : Fin n → ℝ) (k : Fin n) :
    bornSection p k = Real.sqrt (p k) := rfl

/-
The Born map recovers `p` from its square-root section, on the simplex (where
every coordinate is nonnegative, so `(√ p_k)² = p_k`).
-/
theorem bornMap_bornSection {p : Fin n → ℝ} (hp : p ∈ stdSimplex ℝ (Fin n)) :
    bornMap (bornSection p) = p := by
  funext k
  change (bornSection p k) ^ 2 = p k
  rw [bornSection_apply, Real.sq_sqrt (hp.1 k)]

/-
The square-root section of a probability distribution lands on the unit sphere:
`‖bornSection p‖² = ∑ (√ p_k)² = ∑ p_k = 1`.
-/
theorem bornSection_mem_sphere {p : Fin n → ℝ} (hp : p ∈ stdSimplex ℝ (Fin n)) :
    bornSection p ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by
  rw [Metric.mem_sphere, dist_zero_right, EuclideanSpace.norm_eq, Real.sqrt_eq_one, ← hp.2]
  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [Real.norm_eq_abs, sq_abs, bornSection_apply, Real.sq_sqrt (hp.1 i)]

/-
**Headline.** The Born map restricted to the unit sphere is surjective onto the
probability simplex: every probability distribution `p` on `Fin n` is the Born
image `bornMap x` of a wave function `x` on the unit sphere (namely
`x = bornSection p`).  This is the book's claim that the hypersphere
parametrizes "the set of all possible probability distributions".
-/
theorem bornMap_surjOn_stdSimplex :
    Set.SurjOn (bornMap : EuclideanSpace ℝ (Fin n) → _)
      (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) (stdSimplex ℝ (Fin n)) := by
  intro p hp
  exact ⟨bornSection p, bornSection_mem_sphere hp, bornMap_bornSection hp⟩

end BookProof.ChapterFreeFieldBornSurj
