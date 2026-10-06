-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.imgBasis_apply
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}
variable {b : OrthonormalBasis ι ℂ E} {o : ι}


open scoped InnerProductSpace ComplexConjugate
open Finset





theorem BookProof.ChapterWignerSymmetry.imgBasis_apply (hT : IsWignerSymmetry T) (i : ι) :
    imgBasis b T o hT i = alignPhase b T o i • T (b i) := by sorry
