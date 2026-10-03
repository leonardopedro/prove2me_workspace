-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.weyl_friedrichs_bounded
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.ChapterH5
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

/
theorem BookProof.YangMillsFriedrichsLimit.weyl_friedrichs_bounded [CompleteSpace F] {D : Submodule ℂ F} {n m : ℕ}
    {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ := by sorry
