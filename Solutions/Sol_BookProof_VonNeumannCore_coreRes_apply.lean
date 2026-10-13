-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.coreRes_apply
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_FriedrichsSquare_frDom_le_clDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A)
    (x : frDom A) : coreRes A hdense hsym x = clFun A ⟨(x : F), frDom_le_clDom A x.2⟩ := rfl
