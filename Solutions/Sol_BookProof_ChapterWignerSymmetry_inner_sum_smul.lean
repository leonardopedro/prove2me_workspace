-- Generated from ChapterWignerSymmetry.lean — solution of BookProof.ChapterWignerSymmetry.inner_sum_smul
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
import Theorems.Thm_BookProof_ChapterWignerSymmetry_inner_basis_sum
open BookProof.ChapterWignerSymmetry



open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (b : OrthonormalBasis ι ℂ E) (v w : ι → ℂ) :
    ⟪∑ j, v j • b j, ∑ j, w j • b j⟫_ℂ = ∑ k, conj (v k) * w k := by

  rw [sum_inner]
  exact Finset.sum_congr rfl fun i _ => by rw [inner_smul_left, inner_basis_sum]
