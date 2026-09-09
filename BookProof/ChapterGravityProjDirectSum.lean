import Mathlib
import BookProof.ChapterGravityTimeProj

/-!
# The spatial and temporal projectors split Minkowski space

`BookProof.ChapterGravityTimeProj` proves the algebraic identities satisfied by
the spatial projector `χ` and the temporal projector `Π` attached to a unit
timelike vector `v`:

* `spatialProj_add_timeProj` : `χ + Π = δ`;
* `spatialProj_mul_timeProj` : `χ · Π = 0`;
* `timeProj_mul_spatialProj` : `Π · χ = 0`.

The book's chapter on diffeomorphisms and gravity uses these to conclude that
the two projectors decompose spacetime, `ℝ^{1,3} = im χ ⊕ im Π`.  This file
records that conclusion as a genuine submodule statement, via the general
linear-algebra fact that two complementary, mutually annihilating endomorphisms
have complementary ranges.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterGravityProjDirectSum

open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

/-- **General fact.**  If two endomorphisms sum to the identity and annihilate
each other, their ranges are complementary submodules. -/
theorem isCompl_range_of_add_eq_id {R V : Type*} [CommRing R] [AddCommGroup V] [Module R V]
    (P Q : V →ₗ[R] V) (hsum : P + Q = LinearMap.id)
    (hPQ : P.comp Q = 0) (hQP : Q.comp P = 0) :
    IsCompl (LinearMap.range P) (LinearMap.range Q) := by
  have hx : ∀ x : V, P x + Q x = x := by
    intro x
    have := congrArg (fun L : V →ₗ[R] V => L x) hsum
    simpa using this
  constructor
  · rw [Submodule.disjoint_def]
    rintro x ⟨a, rfl⟩ ⟨b, hb⟩
    have h1 : Q (P a) = 0 := congrArg (fun L : V →ₗ[R] V => L a) hQP
    have h2 : P (P a) = P a := by
      have := hx (P a)
      rw [h1] at this
      simpa using this
    have h3 : P (P a) = 0 := by
      rw [← hb]
      exact congrArg (fun L : V →ₗ[R] V => L b) hPQ
    rw [h2] at h3
    exact h3
  · rw [codisjoint_iff_le_sup]
    intro x _
    exact Submodule.mem_sup.2 ⟨P x, ⟨x, rfl⟩, Q x, ⟨x, rfl⟩, hx x⟩

/-- The two projectors, read as linear endomorphisms of `ℝ⁴`, sum to the
identity. -/
theorem mulVecLin_spatial_add_time (v : Fin 4 → ℝ) :
    (spatialProj v).mulVecLin + (timeProj v).mulVecLin = LinearMap.id := by
  rw [← Matrix.mulVecLin_add, spatialProj_add_timeProj, Matrix.mulVecLin_one]

/-- The spatial projector annihilates the temporal one. -/
theorem mulVecLin_spatial_comp_time (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).mulVecLin.comp (timeProj v).mulVecLin = 0 := by
  rw [← Matrix.mulVecLin_mul, spatialProj_mul_timeProj v hv, Matrix.mulVecLin_zero]

/-- The temporal projector annihilates the spatial one. -/
theorem mulVecLin_time_comp_spatial (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (timeProj v).mulVecLin.comp (spatialProj v).mulVecLin = 0 := by
  rw [← Matrix.mulVecLin_mul, timeProj_mul_spatialProj v hv, Matrix.mulVecLin_zero]

/-- **`ℝ^{1,3} = im χ ⊕ im Π`.**  For a unit timelike vector `v`, the images of
the spatial and temporal projectors are complementary subspaces of spacetime:
every vector decomposes uniquely into a spatial and a temporal part. -/
theorem isCompl_spatial_time_range (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    IsCompl (LinearMap.range (spatialProj v).mulVecLin)
      (LinearMap.range (timeProj v).mulVecLin) :=
  isCompl_range_of_add_eq_id _ _ (mulVecLin_spatial_add_time v)
    (mulVecLin_spatial_comp_time v hv) (mulVecLin_time_comp_spatial v hv)

/-- Equivalently: the image of the spatial projector is exactly the kernel of the
temporal projector. -/
theorem range_spatial_eq_ker_time (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    LinearMap.range (spatialProj v).mulVecLin
      = LinearMap.ker (timeProj v).mulVecLin := by
  apply le_antisymm
  · rintro x ⟨a, rfl⟩
    have := congrArg (fun L : (Fin 4 → ℝ) →ₗ[ℝ] (Fin 4 → ℝ) => L a)
      (mulVecLin_time_comp_spatial v hv)
    simpa [LinearMap.mem_ker] using this
  · intro x hx
    have hid : (spatialProj v).mulVecLin x + (timeProj v).mulVecLin x = x := by
      have := congrArg (fun L : (Fin 4 → ℝ) →ₗ[ℝ] (Fin 4 → ℝ) => L x)
        (mulVecLin_spatial_add_time v)
      simpa using this
    rw [LinearMap.mem_ker] at hx
    rw [hx, add_zero] at hid
    exact ⟨x, hid⟩

end BookProof.ChapterGravityProjDirectSum
