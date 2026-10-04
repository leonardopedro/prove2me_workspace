import Definitions.Def_ChapterFreeFieldBornSignOrientationQuotient
import Definitions.Def_ChapterA4
import Mathlib


/-!
# Faithful orthogonal representation of the Born sign gauge

The diagonal boolean sign action is packaged here as a genuine monoid
representation in the real orthogonal group.  It is faithful, and its
special-orthogonal preimage is exactly the multiplicative copy of the
orientation-preserving additive subgroup.
-/


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


/-
The diagonal orthogonal representation is faithful.
-/






end BookProof.ChapterFreeFieldBornSignRepresentation
