-- Generated from ChapterFriedrichsCanonical.lean — theorem BookProof.FriedrichsCanonical.friedrichs_unique_selfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsCanonical

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section


theorem BookProof.FriedrichsCanonical.friedrichs_unique_selfAdjoint (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    {Dom' : Submodule ℂ F} (A' : Dom' →ₗ[ℂ] F)
    (hA' : IsPositiveSelfAdjointExtension P.op A') (hform : Dom' ≤ formDomain P) :
    Dom' = friedrichsDomain P ∧
      ∀ (x : F) (hx : x ∈ Dom') (hx' : x ∈ friedrichsDomain P),
        A' ⟨x, hx⟩ = friedrichsOp P hdense ⟨x, hx'⟩ := by sorry
