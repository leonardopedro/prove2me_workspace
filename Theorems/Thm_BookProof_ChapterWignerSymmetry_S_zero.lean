-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.S_zero
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}


open scoped InnerProductSpace ComplexConjugate
open Finset





theorem BookProof.ChapterWignerSymmetry.S_zero (hS : WignerCoord S o) {v : ι → ℂ} {k : ι} (h : v k = 0) : S v k = 0 := by sorry
