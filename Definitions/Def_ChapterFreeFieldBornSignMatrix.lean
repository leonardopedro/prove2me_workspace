import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignAction
import Mathlib


/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# matrix representation of the diagonal sign gauge

This file packages the boolean sign action from
`ChapterFreeFieldBornSignAction` as diagonal real matrices.  The resulting
matrix representation acts on coordinate vectors exactly as `boolFlip`, is
orthogonal, respects coordinate-wise `xor`, and has determinant equal to the
parity character `(-1) ^ flipCount b` computed in
`ChapterFreeFieldBornSignHom`.

## Main results

* `flipMatrix_mulVec` — the diagonal matrix acts as `boolFlip`.
* `flipMatrix_xor` — coordinate-wise `xor` becomes matrix multiplication.
* `flipMatrix_sq` — every sign matrix is an involution.
* `flipMatrix_transpose_mul` — every sign matrix is orthogonal.
* `det_flipMatrix` — its determinant is `(-1) ^ flipCount b`.
-/

open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom

namespace BookProof.ChapterFreeFieldBornSignMatrix

variable {n : ℕ}

/-- The diagonal matrix representing a boolean sign choice. -/
def flipMatrix (b : Fin n → Bool) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.diagonal (flipVec b)

/-
The diagonal sign matrix acts on coordinate vectors exactly as `boolFlip`.
-/


/-
The all-false choice is represented by the identity matrix.
-/


/-
Coordinate-wise `xor` is represented by matrix multiplication.
-/


/-
Every shapter "Wave-function parametrization of a probability measure", §5 —
# matrix representation of the diagonal sign gauge

This file packages the boolean sign action from
`ChapterFreeFieldBornSignAction` as diagonal real matrices.  The resulting
matrix representation acts on coordinate vectors exactly as `boolFlip`, is
orthogonal, respects coordinate-wise `xor`, and has determinant equal to the
parity character `(-1) ^ flipCount b` computed in
`ChapterFreeFieldBornSignHom`.

## Main results

* `flipMatrix_mulVec` — the diagonal matrix acts as `boolFlip`.
* `flipMatrix_xor` — coordinate-wise `xor` becomes matrix multiplication.
* `flipMatrix_sq` — every sign matrix is an involution.
* `flipMatrix_transpose_mul` — every sign matrix is orthogonal.
* `det_flipMatrix` — its determinant is `(-1) ^ flipCount b`.
-/

open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom

namespace BookProof.ChapterFreeFieldBornSignMatrix

variable {n : ℕ}

/-- The diagonal matrix representing a boolean sign choice. -/
def flipMatrix (b : Fin n → Bool) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.diagonal (flipVec b)

/-
The diagonal sign matrix acts on coordinate vectors exactly as `boolFlip`.
-/
theorem flipMatrix_mulVec (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    (flipMatrix b).mulVec x = boolFlip b x := by
  unfold boolFlip flipMatrix Matrix.mulVec
  aesop

/-
The all-false choice is represented by the identity matrix.
-/
theorem flipMatrix_false :
    flipMatrix (fun _ => false : Fin n → Bool) = 1 := by
  ext i j
  by_cases hi : i = j <;> simp_all [flipVec_false, flipMatrix]
  simp [hi, Matrix.one_apply]

/-
Coordinate-wise `xor` is represented by matrix multiplication.
-/
theorem flipMatrix_xor (b₁ b₂ : Fin n → Bool) :
    flipMatrix (fun k => xor (b₁ k) (b₂ k)) = flipMatrix b₁ * flipMatrix b₂ := by
  ext i j
  by_cases hi : i = j <;> simp [hi, flipMatrix, flipVec]
  grind +splitImp

/-
Every sign matrix squares to the identity.
-/
theorem flipMatrix_sq (b : Fin n → Bool) :
    flipMatrix b * flipMatrix b = 1 := by
  ext i j
  by_cases hi : i = j <;> simp_all [flipMatrix, flipVec]
  simp [hi, Matrix.one_apply]

/-
Every sign matrix is orthogonal.
-/


/-
The determinant of the sign matrix is its parity character.
-/


end BookProof.ChapterFreeFieldBornSignMatrix
