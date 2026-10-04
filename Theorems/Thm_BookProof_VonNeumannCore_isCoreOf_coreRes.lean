-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.isCoreOf_coreRes
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterA4
open BookProof.ClosureUniqueness
open BookProof.EsaClosure
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.isCoreOf_coreRes (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) :
    IsCoreOf (coreRes A hdense hsym) (clExt A hdense hsym) := by sorry
