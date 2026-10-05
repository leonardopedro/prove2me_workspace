-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.resLin_right_inverse
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.resLin_right_inverse (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) (h : F) :
    resLin A h + frFun A ⟨resLin A h, resCLM_mem_frDom A h⟩ = h := by sorry
