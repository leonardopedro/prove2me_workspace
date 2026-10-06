-- Generated from ChapterWignerSymmetry.lean — solution of BookProof.ChapterWignerSymmetry.inner_basis_sum
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
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
theorem solution (b : OrthonormalBasis ι ℂ E) (v : ι → ℂ) (k : ι) :
    ⟪b k, ∑ j, v j • b j⟫_ℂ = v k := by

  classical
  rw [inner_sum, Finset.sum_eq_single k]
  · rw [inner_smul_right, orthonormal_iff_ite.mp b.orthonormal k k]; simp
  · intro j _ hj
    rw [inner_smul_right, orthonormal_iff_ite.mp b.orthonormal k j, if_neg (Ne.symm hj)]
    simp
  · simp
