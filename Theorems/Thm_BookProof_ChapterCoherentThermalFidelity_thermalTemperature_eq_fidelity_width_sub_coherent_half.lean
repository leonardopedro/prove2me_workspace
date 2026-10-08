-- Generated from ChapterCoherentThermalFidelity.lean — theorem BookProof.ChapterCoherentThermalFidelity.thermalTemperature_eq_fidelity_width_sub_coherent_half
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterDisplacedThermalOverlap
import Mathlib
import Definitions.Def_ChapterCoherentThermalFidelity
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentThermalFidelity


noncomputable section


open BookProof.ChapterCoherentOccupation BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentFidelity BookProof.ChapterDisplacedThermalOverlap
open Real

variable {nbar lam : ℝ}


theorem BookProof.ChapterCoherentThermalFidelity.thermalTemperature_eq_fidelity_width_sub_coherent_half (h : 0 ≤ nbar)
    {w : ℝ} (hw : 0 < w)
    (hfid : ∀ lam : ℝ, coherentThermalFidelity nbar lam = Real.exp (-(lam / w)) / w) :
    thermalTemperature nbar = w - coherentWidth := by sorry
