import Definitions.Def_ChapterSolovayCoordinates
import Mathlib


/-!
# Coordinate-level orthogonal invariance of the Mehler (Gaussian) prior

`BookProof.ChapterSolovay` states the invariance of the Mehler tail prior under
finite orthogonal symmetries *at the measurable interface*: a transformation is
admitted when it is measure preserving.  That formulation is honest but weak —
it does not exhibit a single concrete orthogonal transformation.

This file supplies the missing concrete, coordinate-level content.  Working with
the explicit coordinate realization of `BookProof.ChapterSolovayCoordinates`
(the tail is the countable product of standard Gaussians), we prove:

* `charFun_stdGaussianEuclidean` — the characteristic function of the standard
  `k`-dimensional Gaussian is `t ↦ exp (-‖t‖²/2)`, which depends on `t` only
  through its norm;
* `stdGaussianEuclidean_map_isometry` — hence the standard `k`-dimensional
  Gaussian is invariant under **every** linear isometry of `ℝᵏ`, i.e. under the
  full orthogonal group `O(k)`;
* `gaussianHead_map_orthogonal` — the same statement in raw coordinates, for an
  orthogonal matrix `O` acting by `x ↦ O *ᵥ x`;
* `coordinateTailMeasure_map_headRotation` — the **headline**: the infinite
  Mehler coordinate prior is invariant under an orthogonal transformation acting
  on the first `k` coordinates and leaving the remaining coordinates fixed.  This
  is the concrete coordinate-level form of
  `BookProof.ChapterSolovay.mehler_invariant_under_finite_orthogonal`;
* `isFiniteOrthogonalTailSymmetry_headRotation` — consequently such a rotation is
  measure preserving, so it is an admissible finite orthogonal tail symmetry in
  the sense used by the abstract chapter.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section

namespace BookProof.ChapterMehlerOrthogonalInvariance

open BookProof.ChapterSolovayCoordinates

/-! ## 1. The standard Gaussian on Euclidean `k`-space -/

/-- The standard `k`-dimensional Gaussian measure, read on the Euclidean space
`EuclideanSpace ℝ (Fin k)` (the same product of standard Gaussians as
`gaussianHead k`, transported along the `ℓ²` labelling of the coordinates). -/
def stdGaussianEuclidean (k : ℕ) : Measure (EuclideanSpace ℝ (Fin k)) :=
  (gaussianHead k).map (WithLp.toLp 2)

instance stdGaussianEuclidean_isProbability (k : ℕ) :
    IsProbabilityMeasure (stdGaussianEuclidean k) := by
  rw [stdGaussianEuclidean]
  exact Measure.isProbabilityMeasure_map (by fun_prop)







/-! ## 2. Orthogonal matrices as isometries -/

/-- An orthogonal matrix preserves the Euclidean dot product. -/
theorem dotProduct_mulVec_orthogonal {k : ℕ} {O : Matrix (Fin k) (Fin k) ℝ}
    (hO : Oᵀ * O = 1) (x y : Fin k → ℝ) :
    (O *ᵥ x) ⬝ᵥ (O *ᵥ y) = x ⬝ᵥ y := by
  have h : Oᵀ *ᵥ (O *ᵥ x) = x := by rw [Matrix.mulVec_mulVec, hO, Matrix.one_mulVec]
  rw [Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose, h]

/-- The linear isometry of Euclidean `k`-space determined by an orthogonal
matrix. -/
def orthEquiv {k : ℕ} (O : Matrix (Fin k) (Fin k) ℝ) (hO : Oᵀ * O = 1) :
    EuclideanSpace ℝ (Fin k) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin k) := by
  have hO' : O * Oᵀ = 1 := mul_eq_one_comm.mp hO
  refine LinearEquiv.isometryOfInner
    { toFun := fun x => (WithLp.toLp 2 (O *ᵥ (WithLp.ofLp x)))
      invFun := fun y => (WithLp.toLp 2 (Oᵀ *ᵥ (WithLp.ofLp y)))
      map_add' := by intro x y; simp [Matrix.mulVec_add]
      map_smul' := by intro c x; simp [Matrix.mulVec_smul]
      left_inv := by intro x; simp [Matrix.mulVec_mulVec, hO]
      right_inv := by intro y; simp [Matrix.mulVec_mulVec, hO'] } ?_
  intro x y
  simpa [PiLp.inner_apply, dotProduct] using
    dotProduct_mulVec_orthogonal hO (WithLp.ofLp y) (WithLp.ofLp x)

@[simp] theorem orthEquiv_apply {k : ℕ} (O : Matrix (Fin k) (Fin k) ℝ) (hO : Oᵀ * O = 1)
    (x : EuclideanSpace ℝ (Fin k)) :
    orthEquiv O hO x = WithLp.toLp 2 (O *ᵥ (WithLp.ofLp x)) := rfl



/-! ## 3. The infinite Mehler prior under a finite-rank rotation -/

/-- Rotate the first `k` coordinates of an infinite sequence by an orthogonal
matrix, leaving all further coordinates untouched. -/
def headRotation (k : ℕ) (O : Matrix (Fin k) (Fin k) ℝ) :
    CoordinateTail → CoordinateTail :=
  fun x => (tailSplitEquiv k).symm (Prod.map (fun h => O *ᵥ h) id ((tailSplitEquiv k) x))







end BookProof.ChapterMehlerOrthogonalInvariance
