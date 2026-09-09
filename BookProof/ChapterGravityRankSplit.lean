import Mathlib
import BookProof.ChapterGravityProjector
import BookProof.ChapterGravityTimeProj
import BookProof.ChapterGravityProjDirectSum

/-!
# Chapter — Diffeomorphisms and gravity: the split `ℝ^{1,3} = im χ ⊕ im Π` is `3 + 1`

Source: `book.tex`, chapter *"Diffeomorphisms and gravity"*, §*"Classical
Hamiltonian"*.

`ChapterGravityProjDirectSum` already proves that, for a unit timelike vector `v`
(`minkSq v = -1`), the images of the spatial projector `χ^a{}_b = δ^a{}_b + v^a v_b`
and of the temporal projector `Π^a{}_b = −v^a v_b` are **complementary** subspaces
of spacetime (`isCompl_spatial_time_range`).  What that statement does not record
is the *shape* of the split asserted by the chapter: the temporal summand is the
line `ℝ·v` and the spatial summand is a hyperplane, i.e. the decomposition is
`4 = 3 + 1`.  This file supplies exactly that missing dimension count.

## Deliverables

* `timeRange_eq_span` — `im Π = ℝ·v`: the temporal summand is the line through the
  unit timelike vector;
* `finrank_timeRange` — `dim (im Π) = 1`;
* `finrank_spatialRange` — `dim (im χ) = 3`;
* `gravity_split_three_plus_one` — the bundled headline: the two images are
  complementary, of dimensions `3` and `1`.

Nothing here re-proves the complementarity itself; it is imported from
`ChapterGravityProjDirectSum`.  Everything is `sorry`-free and `axiom`-free (only
`propext`, `Classical.choice`, `Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterGravityRankSplit

open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector BookProof.ChapterGravityTimeProj
open BookProof.ChapterGravityProjDirectSum

/-- A unit timelike vector is nonzero (otherwise `minkSq v = 0 ≠ -1`). -/
theorem ne_zero_of_minkSq {v : Fin 4 → ℝ} (hv : minkSq v = -1) : v ≠ 0 := by
  intro h
  rw [h] at hv
  simp [minkSq, lower] at hv

/-- The temporal summand is the line spanned by `v`: `im Π = ℝ·v`. -/
theorem timeRange_eq_span (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    LinearMap.range (timeProj v).mulVecLin = Submodule.span ℝ {v} := by
  apply le_antisymm
  · rintro x ⟨w, rfl⟩
    refine Submodule.mem_span_singleton.2 ⟨-(∑ b, lower v b * w b), ?_⟩
    ext a
    simp [timeProj, Matrix.mulVec, dotProduct, Finset.sum_mul]
    ring_nf
    simp [mul_comm, mul_left_comm]
  · rw [Submodule.span_le, Set.singleton_subset_iff]
    exact ⟨v, timeProj_mulVec_self v hv⟩

/-- The time direction is one-dimensional. -/
theorem finrank_timeRange (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    Module.finrank ℝ (LinearMap.range (timeProj v).mulVecLin) = 1 := by
  rw [timeRange_eq_span v hv]
  exact finrank_span_singleton (ne_zero_of_minkSq hv)

/-- The spatial hyperplane is three-dimensional. -/
theorem finrank_spatialRange (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    Module.finrank ℝ (LinearMap.range (spatialProj v).mulVecLin) = 3 := by
  have hsum := Submodule.finrank_add_eq_of_isCompl (isCompl_spatial_time_range v hv)
  rw [finrank_timeRange v hv] at hsum
  have h4 : Module.finrank ℝ (Fin 4 → ℝ) = 4 := by simp
  omega

/-- **Headline — the gravitational split of spacetime is `3 + 1`.**  For a unit
timelike vector `v`, the images of `χ` and `Π` are complementary subspaces of
`ℝ^{1,3}` of dimensions `3` (the spatial hyperplane `v^⊥`) and `1` (the time
direction `ℝ·v`). -/
theorem gravity_split_three_plus_one (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    IsCompl (LinearMap.range (spatialProj v).mulVecLin)
        (LinearMap.range (timeProj v).mulVecLin) ∧
      Module.finrank ℝ (LinearMap.range (spatialProj v).mulVecLin) = 3 ∧
      Module.finrank ℝ (LinearMap.range (timeProj v).mulVecLin) = 1 :=
  ⟨isCompl_spatial_time_range v hv, finrank_spatialRange v hv, finrank_timeRange v hv⟩

end BookProof.ChapterGravityRankSplit
