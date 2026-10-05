-- Generated from ChapterCoherentThermalFidelity.lean — theorem BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_hasSum
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterDisplacedThermalOverlap
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentOccupation
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentThermalFidelity

variable {nbar lam : ℝ}


noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real


theorem BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_hasSum (h : 0 ≤ nbar) (lam : ℝ) :
    HasSum (fun n : ℕ => coherentOccupation lam n * thermalProb nbar n)
      (Real.exp (-(lam / (nbar + 1))) / (nbar + 1)) := by sorry
