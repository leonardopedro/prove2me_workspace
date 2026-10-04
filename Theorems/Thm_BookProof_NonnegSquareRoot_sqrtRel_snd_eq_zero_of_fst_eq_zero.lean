-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.sqrtRel_snd_eq_zero_of_fst_eq_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterA4
open BookProof.NonnegSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.sqrtRel_snd_eq_zero_of_fst_eq_zero (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {w : F} (h : ((0 : F), w) ∈ sqrtRel hT) :
    w = 0 := by sorry
