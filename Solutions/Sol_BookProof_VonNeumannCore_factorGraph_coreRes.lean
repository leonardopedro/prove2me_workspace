-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.factorGraph_coreRes
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_clGraph_coreRes
import Theorems.Thm_BookProof_ClosureUniqueness_factorGraph_eq_of_clGraph_eq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFarisLavineCore
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare
open BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) : factorGraph (coreRes A hdense hsym) = factorGraph A := factorGraph_eq_of_clGraph_eq (clGraph_coreRes A hdense hsym)
