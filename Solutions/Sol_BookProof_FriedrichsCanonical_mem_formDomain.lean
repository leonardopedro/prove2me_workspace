-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.mem_formDomain
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {P : PosSymOp F} {v : F} (k : FormSpace P) (hk : formExt P k = v) :
    v ∈ formDomain P := ⟨k, hk⟩
