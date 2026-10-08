-- Generated from ChapterBrstReducedTransfer.lean — theorem BookProof.BrstReducedTransfer.exactStates_le_physicalStates
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
open BookProof.BrstReducedTransfer



open BookProof BookProof.ChapterStoneResolvent


variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]

variable (Om : H →L[ℂ] H)


theorem BookProof.BrstReducedTransfer.exactStates_le_physicalStates (hnil : ∀ x, Om (Om x) = 0) :
    exactStates Om ≤ physicalStates Om := by sorry
