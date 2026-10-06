-- Generated from ChapterBrstReducedTransfer.lean — solution of BookProof.BrstReducedTransfer.exactStates_le_physicalStates
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
open BookProof.BrstReducedTransfer




open BookProof BookProof.ChapterStoneResolvent


variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]

variable (Om : H →L[ℂ] H)

variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]
variable (Om : H →L[ℂ] H)

set_option maxHeartbeats 1000000 in
theorem solution (hnil : ∀ x, Om (Om x) = 0) :
    exactStates Om ≤ physicalStates Om := by

  refine Submodule.topologicalClosure_minimal _ ?_ Om.isClosed_ker
  rintro x ⟨y, rfl⟩
  exact hnil y
