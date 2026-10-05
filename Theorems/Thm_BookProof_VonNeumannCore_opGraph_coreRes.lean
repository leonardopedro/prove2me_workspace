-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.opGraph_coreRes
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.opGraph_coreRes (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) :
    opGraph (coreRes A hdense hsym) = coreGraph A := by sorry
