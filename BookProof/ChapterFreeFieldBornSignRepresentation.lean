import Mathlib
import BookProof.ChapterFreeFieldBornSignOrientationQuotient

/-!
# Faithful orthogonal representation of the Born sign gauge

The diagonal boolean sign action is packaged here as a genuine monoid
representation in the real orthogonal group.  It is faithful, and its
special-orthogonal preimage is exactly the multiplicative copy of the
orientation-preserving additive subgroup.
-/

open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup

namespace BookProof.ChapterFreeFieldBornSignRepresentation

variable {n : ℕ}

/-- The faithful diagonal representation of boolean sign choices in `O(n)`. -/
def flipRepresentation (n : ℕ) :
    Multiplicative (Fin n → Bool) →* Matrix.orthogonalGroup (Fin n) ℝ where
  toFun b := ⟨flipMatrix b.toAdd, flipMatrix_mem_orthogonalGroup b.toAdd⟩
  map_one' := by
    ext i j
    exact congrFun (congrFun (flipMatrix_false (n := n)) i) j
  map_mul' := by
    intro b₁ b₂
    apply Subtype.ext
    change flipMatrix (b₁.toAdd + b₂.toAdd) =
      flipMatrix b₁.toAdd * flipMatrix b₂.toAdd
    have hadd : b₁.toAdd + b₂.toAdd =
        fun k => xor (b₁.toAdd k) (b₂.toAdd k) := by
      funext k
      change b₁.toAdd k + b₂.toAdd k = xor (b₁.toAdd k) (b₂.toAdd k)
      cases b₁.toAdd k <;> cases b₂.toAdd k <;> rfl
    rw [hadd, flipMatrix_xor]

@[simp] theorem flipRepresentation_apply (b : Multiplicative (Fin n → Bool)) :
    (flipRepresentation n b : Matrix (Fin n) (Fin n) ℝ) = flipMatrix b.toAdd :=
  rfl

/-
Equality of diagonal sign matrices recovers the underlying sign choice.
-/
theorem flipMatrix_injective : Function.Injective (flipMatrix :
    (Fin n → Bool) → Matrix (Fin n) (Fin n) ℝ) := by
  intro b₁ b₂ h
  apply flipVec_injective
  ext k
  convert congrArg (fun m : Matrix (Fin n) (Fin n) ℝ => m k k) h using 1 <;>
    simp [flipMatrix]

/-
The diagonal orthogonal representation is faithful.
-/
theorem flipRepresentation_injective :
    Function.Injective (flipRepresentation n) := by
  intro b₁ b₂ h
  apply_fun fun x => x.val at h
  exact Multiplicative.toAdd.injective (flipMatrix_injective h)

/-- A represented sign choice lies in `SO(n)` exactly when the original boolean
choice belongs to the orientation-preserving additive subgroup. -/
theorem flipRepresentation_specialOrthogonal_iff
    (b : Multiplicative (Fin n → Bool)) :
    (flipRepresentation n b : Matrix (Fin n) (Fin n) ℝ) ∈
        Matrix.specialOrthogonalGroup (Fin n) ℝ ↔
      b.toAdd ∈ orientationPreservingSigns n := by
  rfl

/-- The determinant of the faithful representation is the parity sign
`(-1) ^ flipCount`. -/
theorem det_flipRepresentation (b : Multiplicative (Fin n → Bool)) :
    Matrix.det (flipRepresentation n b : Matrix (Fin n) (Fin n) ℝ) =
      (-1 : ℝ) ^ flipCount b.toAdd := by
  exact det_flipMatrix b.toAdd

end BookProof.ChapterFreeFieldBornSignRepresentation
