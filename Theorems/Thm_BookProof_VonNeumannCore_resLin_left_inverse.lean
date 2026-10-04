-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.resLin_left_inverse
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.resLin_left_inverse (A : D →ₗ[ℂ] F) (x : frDom A) :
    resLin A ((x : F) + frFun A x) = (x : F) := by sorry
