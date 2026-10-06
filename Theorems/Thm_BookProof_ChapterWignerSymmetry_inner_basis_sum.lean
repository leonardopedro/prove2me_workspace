-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.inner_basis_sum
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}


open scoped InnerProductSpace ComplexConjugate
open Finset





theorem BookProof.ChapterWignerSymmetry.inner_basis_sum (b : OrthonormalBasis ι ℂ E) (v : ι → ℂ) (k : ι) :
    ⟪b k, ∑ j, v j • b j⟫_ℂ = v k := by sorry
