-- Generated from ChapterCoherentThermalFidelity.lean — theorem BookProof.ChapterCoherentThermalFidelity.dtOverlap_coherentParameter
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentTemperature
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Definitions.Def_ChapterDisplacedThermalOverlap
import Definitions.Def_ChapterA4
open BookProof.ChapterDisplacedThermalOverlap
open BookProof.ChapterCoherentThermalFidelity

variable {nbar lam : ℝ}


noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real


theorem BookProof.ChapterCoherentThermalFidelity.dtOverlap_coherentParameter (nb : NNReal) (a b : ℝ) :
    dtOverlap nb (Real.sqrt 2 * a) (Real.sqrt 2 * b)
      = Real.exp (-((a - b) ^ 2 / (((nb : ℝ) + 1 / 2) + ((nb : ℝ) + 1 / 2))))
        / Real.sqrt (4 * π * ((nb : ℝ) + 1 / 2)) := by sorry
