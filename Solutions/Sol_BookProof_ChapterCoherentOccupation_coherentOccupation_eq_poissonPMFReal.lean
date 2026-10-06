-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.coherentOccupation_eq_poissonPMFReal
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (r : NNReal) (n : ℕ) :
    coherentOccupation r n = poissonPMFReal r n := rfl
