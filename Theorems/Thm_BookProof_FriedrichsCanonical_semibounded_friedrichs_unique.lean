-- Generated from ChapterFriedrichsCanonical.lean — theorem BookProof.FriedrichsCanonical.semibounded_friedrichs_unique
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterA4
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.FriedrichsCanonical

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section


theorem BookProof.FriedrichsCanonical.semibounded_friedrichs_unique (H : D →ₗ[ℂ] F) (hsym : SymmetricOn D H) (c : ℝ)
    (hbelow : ∀ x : D, -c * ‖(x : F)‖ ^ 2 ≤ quadForm H x) (hdense : Dense (D : Set F))
    {Dom' : Submodule ℂ F} (A' : Dom' →ₗ[ℂ] F)
    (hA' : IsSemiboundedSelfAdjointExtension c H A')
    (hform : Dom' ≤ formDomain (shiftedPosSymOp H hsym c hbelow)) :
    Dom' = friedrichsDomain (shiftedPosSymOp H hsym c hbelow) ∧
      ∀ (x : F) (hx : x ∈ Dom')
        (hx' : x ∈ friedrichsDomain (shiftedPosSymOp H hsym c hbelow)),
        A' ⟨x, hx⟩ = semiboundedFriedrichsOp H hsym c hbelow hdense ⟨x, hx'⟩ := by sorry
