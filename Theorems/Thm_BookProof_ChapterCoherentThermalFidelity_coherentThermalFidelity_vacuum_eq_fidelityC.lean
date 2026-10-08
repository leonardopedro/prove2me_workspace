-- Generated from ChapterCoherentThermalFidelity.lean — theorem BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_vacuum_eq_fidelityC
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentTemperature
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterDisplacedThermalOverlap
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
open BookProof.ChapterCoherentThermalFidelity


noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}


theorem BookProof.ChapterCoherentThermalFidelity.coherentThermalFidelity_vacuum_eq_fidelityC {n : ℕ}
    (q k : EuclideanSpace ℂ (Fin n)) :
    coherentThermalFidelity 0 (‖q - k‖ ^ 2) = fidelityC q k := by sorry
