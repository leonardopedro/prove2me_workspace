import Mathlib
import BookProof.ChapterFreeFieldBornSignOrientationCard

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the orientation-preserving sign gauge as an index-two kernel

The preceding files represent the diagonal Born sign gauge by orthogonal
matrices, identify orientation preservation with even Hamming weight, and count
the orientation-preserving choices. This file records the corresponding
algebraic structure: the orientation-preserving choices contain the identity,
are closed under the boolean `xor` group law, and the parity of an `xor` is even
exactly when its two inputs have the same parity. Thus the even choices form the
kernel of the determinant/sign character, while the odd choices form its other
coset.

## Main results

* `orientationPreserving_false` — the identity sign choice preserves orientation.
* `orientationPreserving_xor` — orientation-preserving choices are closed under
  coordinate-wise `xor`.
* `even_flipCount_xor_iff` — an `xor` has even weight exactly when its inputs
  have the same parity.
* `orientationPreserving_xor_iff` — matrix form of the index-two kernel/coset law.
-/

open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation

namespace BookProof.ChapterFreeFieldBornSignOrientationKernel

variable {n : ℕ}

/-
The all-false sign choice is the identity and preserves orientation.
-/
theorem orientationPreserving_false :
    flipMatrix (fun _ => false : Fin n → Bool) ∈
      Matrix.specialOrthogonalGroup (Fin n) ℝ := by
  rw [flipMatrix_mem_specialOrthogonalGroup_iff]
  simp [flipCount]

/-
Orientation-preserving diagonal sign choices are closed under xor.
-/
theorem orientationPreserving_xor {b₁ b₂ : Fin n → Bool}
    (h₁ : flipMatrix b₁ ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ)
    (h₂ : flipMatrix b₂ ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ) :
    flipMatrix (fun k => xor (b₁ k) (b₂ k)) ∈
      Matrix.specialOrthogonalGroup (Fin n) ℝ := by
  rw [flipMatrix_xor]
  exact mul_mem h₁ h₂

/-
The xor of two boolean sign choices has even Hamming weight exactly when
its inputs have the same Hamming-weight parity.
-/
theorem even_flipCount_xor_iff (b₁ b₂ : Fin n → Bool) :
    Even (flipCount (fun k => xor (b₁ k) (b₂ k))) ↔
      (Even (flipCount b₁) ↔ Even (flipCount b₂)) := by
  unfold flipCount
  induction (Finset.univ : Finset (Fin n)) using Finset.induction <;>
    simp_all [Finset.filter_insert]
  grind

/-
Index-two kernel/coset law in matrix form: the product sign choice preserves
orientation exactly when its two factors either both preserve or both reverse
orientation.
-/
theorem orientationPreserving_xor_iff (b₁ b₂ : Fin n → Bool) :
    flipMatrix (fun k => xor (b₁ k) (b₂ k)) ∈
        Matrix.specialOrthogonalGroup (Fin n) ℝ ↔
      (flipMatrix b₁ ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ ↔
       flipMatrix b₂ ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ) := by
  rw [flipMatrix_mem_specialOrthogonalGroup_iff,
    flipMatrix_mem_specialOrthogonalGroup_iff,
    flipMatrix_mem_specialOrthogonalGroup_iff, even_flipCount_xor_iff]

end BookProof.ChapterFreeFieldBornSignOrientationKernel
