import Mathlib
import BookProof.ChapterGravityProjector
import BookProof.ChapterGravityTimeProj

/-!
# Chapter — Diffeomorphisms and gravity: the orthogonal spacetime split `x = χx + Πx`

Source: `book.tex`, chapter *"Diffeomorphisms and gravity"*, §*"Classical
Hamiltonian"* (line ~8091).  Continuing the standing directive (mine the next
self-contained mathematical claim from `book.tex`) and building directly on the
spatial projector `χ` (`ChapterGravityProjector`, Wave 69) and the complementary
temporal projector `Π` (`ChapterGravityTimeProj`, Wave 71), this file records the
**orthogonal `3 + 1` decomposition** that these projectors implement: relative to
the globally defined **unit timelike vector** `v` (`minkSq v = −1` in the
mostly-plus Minkowski metric `η = diag(−1,1,1,1)`), every contravariant vector
`x` splits uniquely as

`x = (χ x) + (Π x)`,

into its **spatial part** `χ x ∈ v^⊥` and its **temporal part** `Π x`, which is a
scalar multiple of `v`.  The two parts are Minkowski-orthogonal.  This is the
linear-algebra content underlying the book's use of `χ` to split every torsion
tensor into spatial and temporal pieces.

Formalized here (all under the physical unit-timelike hypothesis
`minkSq v = -1`, where noted):

* `minkForm x y` — the Minkowski bilinear form `⟨x,y⟩_η = ∑ₐ xᵃ y_a`;
* `minkForm_comm` — the Minkowski form is symmetric;
* `spatialPart v x`, `timePart v x` — the spatial (`χx`) and temporal (`Πx`) parts;
* `spatialPart_add_timePart` — **completeness** `χx + Πx = x`;
* `timePart_eq_smul` — the temporal part is `Πx = −⟨x,v⟩_η · v`, a multiple of `v`;
* `spatialPart_orthogonal` — the spatial part is Minkowski-orthogonal to `v`
  (`⟨χx, v⟩_η = 0`), i.e. it lies in the spatial hyperplane `v^⊥`;
* `parts_orthogonal` — **headline**: the spatial and temporal parts are
  Minkowski-orthogonal (`⟨χx, Πx⟩_η = 0`);
* `split_unique` — the `3 + 1` split is unique: if `x = s + c • v` with `s ⊥ v`
  then `s = χx` and `c • v = Πx`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterGravitySplit

open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

/-- The Minkowski bilinear form `⟨x,y⟩_η = ∑ₐ xᵃ y_a = ∑ₐ xᵃ η_{ab} yᵇ`. -/
noncomputable def minkForm (x y : Fin 4 → ℝ) : ℝ := ∑ a, x a * lower y a

/-
The Minkowski form is symmetric.
-/
theorem minkForm_comm (x y : Fin 4 → ℝ) : minkForm x y = minkForm y x := by
  unfold minkForm lower metric; norm_num [ Fin.sum_univ_four ] ; ring;
  simp [ *, Matrix.mulVec ] ; ring!;

/-
`minkForm x x` is the Minkowski square `minkSq x`.
-/
theorem minkForm_self (x : Fin 4 → ℝ) : minkForm x x = minkSq x := by
  rfl

/-- The **spatial part** `χ x` of a vector `x`. -/
noncomputable def spatialPart (v x : Fin 4 → ℝ) : Fin 4 → ℝ := (spatialProj v).mulVec x

/-- The **temporal part** `Π x` of a vector `x`. -/
noncomputable def timePart (v x : Fin 4 → ℝ) : Fin 4 → ℝ := (timeProj v).mulVec x

/-
**Completeness.** The spatial and temporal parts reconstruct `x`: `χx + Πx = x`.
-/
theorem spatialPart_add_timePart (v x : Fin 4 → ℝ) :
    spatialPart v x + timePart v x = x := by
  unfold spatialPart timePart;
  rw [ ← Matrix.add_mulVec, BookProof.ChapterGravityTimeProj.spatialProj_add_timeProj,
      Matrix.one_mulVec ]

/-
The temporal part is a scalar multiple of `v`: `Πx = −⟨x,v⟩_η · v`.
-/
theorem timePart_eq_smul (v x : Fin 4 → ℝ) :
    timePart v x = (-(minkForm x v)) • v := by
  ext a;
  unfold timePart minkForm; simp only [mulVec, dotProduct, Fin.sum_univ_four, Fin.isValue,
      neg_add_rev, Pi.smul_apply, smul_eq_mul] ; ring;
  unfold timeProj; norm_num; ring;

/-
The spatial part is Minkowski-orthogonal to `v` (`⟨χx, v⟩_η = 0`): it lies in the
spatial hyperplane `v^⊥`.
-/
theorem spatialPart_orthogonal (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    minkForm (spatialPart v x) v = 0 := by
  unfold minkForm;
  unfold spatialPart; simp only [mulVec, dotProduct] ; ring;
  unfold spatialProj; simp [ * ] ; ring;
  unfold minkSq at hv; simp_all [ Fin.sum_univ_four, lower ] ; ring;
  grobner

/-
**Headline.** The spatial and temporal parts are Minkowski-orthogonal:
`⟨χx, Πx⟩_η = 0`.
-/
theorem parts_orthogonal (v x : Fin 4 → ℝ) (hv : minkSq v = -1) :
    minkForm (spatialPart v x) (timePart v x) = 0 := by
  rw [ timePart_eq_smul ];
  convert congr_arg ( fun y => ( -minkForm x v ) * y ) ( spatialPart_orthogonal v x hv ) using 1 ;
      focus (ring);
  · unfold minkForm lower; simp [ Matrix.mulVec, dotProduct, Fin.sum_univ_four ] ; ring;
  · ring

/-
**Uniqueness of the `3 + 1` split.** If `x = s + c • v` with `s` Minkowski-orthogonal
to `v` (`⟨s, v⟩_η = 0`), then `s` is the spatial part and `c • v` is the temporal
part.
-/
theorem split_unique (v x s : Fin 4 → ℝ) (c : ℝ) (hv : minkSq v = -1)
    (hs : minkForm s v = 0) (hx : x = s + c • v) :
    s = spatialPart v x ∧ c • v = timePart v x := by
  unfold spatialPart timePart;
  simp_all [ spatialProj, timeProj, Matrix.mulVec_add, Matrix.mulVec_smul ];
  simp_all [ Matrix.add_mulVec, minkForm ];
  simp_all [ funext_iff, Matrix.mulVec, dotProduct ];
  simp_all [ mul_comm, mul_left_comm, Finset.mul_sum _ _ _, minkSq ];
  simp_all [ ← Finset.mul_sum _ _ _ ]

end BookProof.ChapterGravitySplit
