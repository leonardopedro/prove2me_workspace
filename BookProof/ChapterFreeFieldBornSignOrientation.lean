import Mathlib
import BookProof.ChapterFreeFieldBornSignMatrix

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# orientation of the diagonal sign gauge

This file refines the orthogonal matrix representation of the diagonal Born sign
gauge by separating its orientation-preserving and orientation-reversing parts.
The determinant character computed in `ChapterFreeFieldBornSignMatrix` is `+1`
exactly when an even number of coordinates are flipped and is `-1` exactly when
an odd number are flipped.  Consequently the even-weight sign choices are
precisely the matrices in the special orthogonal group.

## Main results

* `flipMatrix_transpose` — every sign matrix is symmetric.
* `flipMatrix_mem_orthogonalGroup` — every sign matrix belongs to `O(n)`.
* `det_flipMatrix_eq_one_iff` — determinant `+1` iff the flip count is even.
* `det_flipMatrix_eq_neg_one_iff` — determinant `-1` iff the flip count is odd.
* `flipMatrix_mem_specialOrthogonalGroup_iff` — membership in `SO(n)` iff the
  flip count is even.
-/

open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix

namespace BookProof.ChapterFreeFieldBornSignOrientation

variable {n : ℕ}

/-
A diagonal sign matrix is symmetric.
-/
theorem flipMatrix_transpose (b : Fin n → Bool) :
    Matrix.transpose (flipMatrix b) = flipMatrix b := by
  exact Matrix.diagonal_transpose (flipVec b)

/-
Every diagonal sign matrix belongs to the real orthogonal group.
-/
theorem flipMatrix_mem_orthogonalGroup (b : Fin n → Bool) :
    flipMatrix b ∈ Matrix.orthogonalGroup (Fin n) ℝ := by
  rw [Matrix.mem_orthogonalGroup_iff, flipMatrix_transpose]
  exact flipMatrix_sq b

/-
A sign matrix has determinant `+1` exactly when it flips an even number of
coordinates.
-/
theorem det_flipMatrix_eq_one_iff (b : Fin n → Bool) :
    Matrix.det (flipMatrix b) = 1 ↔ Even (flipCount b) := by
  rw [det_flipMatrix]
  exact neg_one_pow_eq_one_iff_even (by norm_num)

/-
A sign matrix has determinant `-1` exactly when it flips an odd number of
coordinates.
-/
theorem det_flipMatrix_eq_neg_one_iff (b : Fin n → Bool) :
    Matrix.det (flipMatrix b) = -1 ↔ Odd (flipCount b) := by
  rw [det_flipMatrix]
  exact neg_one_pow_eq_neg_one_iff_odd (by norm_num)

/-
**Headline.** The orientation-preserving part of the diagonal Born sign
 gauge consists exactly of the even-weight sign choices.
-/
theorem flipMatrix_mem_specialOrthogonalGroup_iff (b : Fin n → Bool) :
    flipMatrix b ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ ↔ Even (flipCount b) := by
  rw [← det_flipMatrix_eq_one_iff b, Matrix.mem_specialOrthogonalGroup_iff]
  exact ⟨fun h => h.2, fun h => ⟨flipMatrix_mem_orthogonalGroup b, h⟩⟩

end BookProof.ChapterFreeFieldBornSignOrientation
