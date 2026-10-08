-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.mem_factorGraph_sqOp
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.mem_factorGraph_sqOp (A : D →ₗ[ℂ] F) (hsym : SymmetricOn D A)
    (hstab : ∀ v : D, (A v : F) ∈ D) (v : D) :
    ((v : F), sqOp A hstab v) ∈ factorGraph A := by sorry
