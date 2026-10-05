-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.eq_smul_of_hasSum_norm
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
open BookProof.ChapterWignerSymmetryInfinite

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterWignerSymmetryInfinite.eq_smul_of_hasSum_norm {z : ι → ℂ} {S : ℂ} (hz : HasSum z S)
    (hn : HasSum (fun k => ‖z k‖) ‖S‖) (hS : S ≠ 0) (k : ι) :
    z k = (S / (‖S‖ : ℂ)) * ((‖z k‖ : ℝ) : ℂ) := by sorry
