import Mathlib
import BookProof.ChapterFreeFieldBornSignOrientationKernel

/-!
# The orientation-preserving Born sign gauge as an additive subgroup

The boolean sign choices carry their standard elementary abelian `2`-group
structure: pointwise addition on `Bool` is xor. This file packages the
orientation-preserving choices as an actual `AddSubgroup`, rather than only
recording closure as separate propositions.
-/

open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationKernel
open BookProof.ChapterFreeFieldBornSignOrientationCard

namespace BookProof.ChapterFreeFieldBornSignOrientationSubgroup

variable {n : ℕ}

/-- The additive subgroup of boolean sign choices whose diagonal matrices have
determinant `+1`. -/
def orientationPreservingSigns (n : ℕ) : AddSubgroup (Fin n → Bool) where
  carrier := {b | flipMatrix b ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ}
  zero_mem' := by
    change flipMatrix (fun _ => false) ∈
      Matrix.specialOrthogonalGroup (Fin n) ℝ
    exact orientationPreserving_false
  add_mem' := by
    intro b₁ b₂ h₁ h₂
    have hadd : b₁ + b₂ = fun k => xor (b₁ k) (b₂ k) := by
      funext k
      change b₁ k + b₂ k = xor (b₁ k) (b₂ k)
      cases b₁ k <;> cases b₂ k <;> rfl
    rw [hadd]
    exact orientationPreserving_xor h₁ h₂
  neg_mem' := by
    intro b hb
    simpa using hb

@[simp] theorem mem_orientationPreservingSigns_iff (b : Fin n → Bool) :
    b ∈ orientationPreservingSigns n ↔
      flipMatrix b ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ :=
  Iff.rfl

/-- Membership in the subgroup is exactly even Hamming weight. -/
theorem mem_orientationPreservingSigns_iff_even (b : Fin n → Bool) :
    b ∈ orientationPreservingSigns n ↔ Even (flipCount b) := by
  rw [mem_orientationPreservingSigns_iff,
    flipMatrix_mem_specialOrthogonalGroup_iff]

/-- Two sign choices determine the same orientation coset exactly when their
xor is orientation-preserving. -/
theorem sub_mem_orientationPreservingSigns_iff (b₁ b₂ : Fin n → Bool) :
    b₁ - b₂ ∈ orientationPreservingSigns n ↔
      (b₁ ∈ orientationPreservingSigns n ↔
       b₂ ∈ orientationPreservingSigns n) := by
  have hsub : b₁ - b₂ = fun k => xor (b₁ k) (b₂ k) := by
    funext k
    change b₁ k - b₂ k = xor (b₁ k) (b₂ k)
    cases b₁ k <;> cases b₂ k <;> rfl
  rw [hsub]
  exact orientationPreserving_xor_iff b₁ b₂

/-
In positive dimension, the orientation-preserving subgroup has index two.
-/
theorem orientationPreservingSigns_index (n : ℕ) :
    (orientationPreservingSigns (n + 1)).index = 2 := by
  have h_card : Nat.card (orientationPreservingSigns (n + 1)) = 2 ^ n := by
    convert natCard_orientationPreserving_flip n using 1
  have h_index :=
    AddSubgroup.card_mul_index (orientationPreservingSigns (n + 1))
  simp_all [pow_succ']
  nlinarith [pow_pos (zero_lt_two' ℕ) n]

end BookProof.ChapterFreeFieldBornSignOrientationSubgroup
